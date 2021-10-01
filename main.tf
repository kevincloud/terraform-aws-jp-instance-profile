data "aws_iam_policy_document" "assume-role" {
    statement {
        effect  = "Allow"
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

data "aws_iam_policy_document" "main-access-doc" {
    statement {
        sid       = "FullAccess"
        effect    = "Allow"
        resources = ["*"]

        actions = var.actions
    }
}

resource "aws_iam_role" "main-access-role" {
    name               = "access-role-${var.unit_prefix}"
    assume_role_policy = data.aws_iam_policy_document.assume-role.json

    tags = var.tags
}

resource "aws_iam_role_policy" "main-access-policy" {
    name   = "access-policy-${var.unit_prefix}"
    role   = aws_iam_role.main-access-role.id
    policy = data.aws_iam_policy_document.main-access-doc.json
}

resource "aws_iam_instance_profile" "main-profile" {
    name = "access-profile-${var.unit_prefix}"
    role = aws_iam_role.main-access-role.name
}

