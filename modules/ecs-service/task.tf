resource "aws_iam_role" "task_execution_role" {
  count              = var.create_task_execution_role ? 1 : 0
  name               = "ecsTaskExecutionRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    Name          = "ecsTaskExecutionRole"
    resource_type = "AWS IAM Role"
  }
}

resource "aws_iam_policy" "task_execution_policy" {
  count       = var.create_task_execution_role ? 1 : 0
  name        = "ecsTaskDefinitionPolicy"
  path        = "/"
  description = ""
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "task_execution_policy_attachment" {
  count      = var.create_task_execution_role ? 1 : 0
  name       = "${var.name}-task-execution-attachment"
  roles      = [aws_iam_role.task_execution_role.0.name]
  policy_arn = aws_iam_policy.task_execution_policy.0.arn
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = var.name
  container_definitions = jsonencode(var.ecs_task_container_definitions)
  execution_role_arn    = aws_iam_role.task_execution_role.0.arn
  network_mode          = "bridge"

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  tags = {
    Name          = "${var.name}"
    resource_type = "AWS ECS Task Definition"
  }
}
