# Terraform Test Examples
#
# For more info please see: https://developer.hashicorp.com/terraform/language/tests
# To learn more about mocking providers see: https://developer.hashicorp.com/terraform/language/tests/mocking
#

run "lb_tests" {

  command = plan

  assert {
    condition     = aws_lb.lb.name == format("%s-lb", var.prefix)
    error_message = "Load balancer name did not match expected"
  }
}

run "rds_tests" {

  command = plan

  assert {
    condition     = module.rds.instance_class == "db.t3.small"
    error_message = "RDS instance class did not match expected"
  }

  assert {
    condition     = module.rds.engine == "postgres"
    error_message = "RDS engine did not match expected"
  }
}
