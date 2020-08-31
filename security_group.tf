resource "aws_security_group" "demo" {
  name        = var.sg_name
  vpc_id      = var.vpc_id   
}

# ingress rules 
resource "aws_security_group_rule" "ingress_http" {
  count       = length(var.tcp_ports)
  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = var.cidr_block
  from_port   = element(var.tcp_ports, count.index)
  to_port     = element(var.tcp_ports, count.index)
  security_group_id = aws_security_group.demo.id
}
# end resource

# egress rules
resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.demo.id
}