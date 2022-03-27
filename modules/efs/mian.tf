resource "aws_efs_file_system" "Casestudy-EFS" {
  creation_token = "Casestudy-EFS"

  tags = {
    Name = "Casestudy-EFS"
  }
}

resource "aws_efs_mount_target" "Casestudy-mount-efs" {
  file_system_id = aws_efs_file_system.Casestudy-EFS.id
  subnet_id      = var.efssubnetname
  security_groups = [var.efssgname]
}

/*
resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.fs.id

  bypass_policy_lockout_safety_check = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "ExamplePolicy01",
    "Statement": [
        {
            "Sid": "ExampleStatement01",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Resource": "${aws_efs_file_system.test.arn}",
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                }
            }
        }
    ]
}
POLICY
}
*/