locals {
  github_oidc_already_exists = false
}
resource "aws_iam_openid_connect_provider" "default" {
  count                       = local.github_oidc_already_exists ? 0 : 1
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type = "Federated"
      identifiers = [aws_iam_openid_connect_provider.default[0].arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [format("repo:%s:*", var.repo_name)]
    }
    condition {
      test = "ForAllValues:StringEquals"
      variable = "token.actions.githubusercontent.com:iss"
      values = ["https://token.actions.githubusercontent.com"]
    }
    condition {
      test = "ForAllValues:StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = ["sts.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "github_actions" {
  statement {
   effect = "Allow"
   actions = [
    "s3:*Bucket*",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["s3:*"]
    resources = ["arn:aws:s3:::${var.prefix}-tfstate", "arn:aws:s3:::${var.prefix}-tfstate/*"]
  }

  statement {
    effect = "Allow"
    actions = ["dynamodb:*"]
    resources = [format("arn:aws:dynamodb:%s:%s:table/%s-tfstate-locks*", data.aws_region.current.id, data.aws_caller_identity.current.id, var.prefix)]
  }

  statement {
    effect = "Allow"
    actions = ["secretsmanager:*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["logs:*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["ecr:*"]
    resources = [format("arn:aws:ecr:*:%s:repository/*", data.aws_caller_identity.current.id)]
  }

  statement {
    effect = "Allow"
    actions = ["iam:PassRole",
            "iam:*Role*",
            "iam:*Policy*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "github_actions_role" {
  name = format("%s-github-actions-role", var.prefix)
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "github_actions_policy" {
  name = format("%s-github-actions-policy", var.prefix)
  role = aws_iam_role.github_actions_role.id
  policy = data.aws_iam_policy_document.github_actions.json
}

resource "aws_iam_role_policy_attachment" "elb_full_access" {
  for_each = toset([
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
  ])
  role       = aws_iam_role.github_actions_role.id
  policy_arn = each.value
}
