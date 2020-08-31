resource "aws_key_pair" "demo" {
  key_name   = "demo"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}