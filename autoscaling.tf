
# resource "aws_autoscaling_group" "webapp" {
#   name = "${aws_launch_configuration.webapp.name}-asg"

#   min_size = 2
#   desired_capacity = 2
#   max_size = 4

#   health_check_type = "ELB"
#   load_balancers = [
#     "${aws_elb.loadbalancer1.id}"
#   ]
#   launch_configuration = "${aws_launch_configuration.webapp.name}"


#   enabled_metrics = [
#     "GroupMinSize",
#     "GroupMaxSize",
#     "GroupDesiredCapacity",
#     "GroupInServiceInstances",
#     "GroupTotalInstances"
#   ]
  
#     metrics_granularity = "1Minute"
#     vpc_zone_identifier = [
#         aws_subnet.projectsubnet.id,
#         aws_subnet.projectsubnet2.id,
        
#     ]
#     lifecycle {
#       create_before_destroy = true
#     }
#     tag {
#       key = "Name"
#       value = "webapp"
#       propagate_at_launch = true
#     }
# }

# resource "aws_autoscaling_policy" "web_policy_up" {
#   name = "web_policy_up"
#   scaling_adjustment = 1
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 300
#   autoscaling_group_name = aws_autoscaling_group.webapp.name
# }
# resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
#     alarm_name = "web_cpu_alarm_up"
#     comparison_operator = "GreaterThanOrEqualToThreshold"
#     evaluation_periods = "2"
#     metric_name = "CPUUtilization"
#     namespace = "AWS/EC2"
#     period = "120"
#     statistic = "Average"
#     threshold = "60"

#     dimensions = {
#         autoscaling_group_name = aws_autoscaling_group.webapp.name
#     }
#     alarm_description = "This metric monitor Ec2 cpu"
#     alarm_actions = [
#         aws_autoscaling_policy.web_policy_up.arn
#     ]

# resource "aws_autoscaling_policy" "web_policy_down" {
#   name = "web_policy_down"
#   scaling_adjustment = -1
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 300
#   autoscaling_group_name = aws_autoscaling_group.webapp.name
# }

# resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
#     alarm_name = "web_cpu_alarm_down"
#     comparison_operator = "LessThanOrEqualToThreshold"
#     evaluation_periods = "2"
#     metric_name = "CPUUtilization"
#     namespace = "AWS/EC2"
#     period = "120"
#     statistic = "Average"
#     threshold = "10"

#     dimensions = {
#         autoscaling_group_name = aws_autoscaling_group.webapp.name
#     }
#     alarm_description = "This metric monitor Ec2 cpu"
#     alarm_actions = [
#         aws_autoscaling_policy.web_policy_up.arn
#     ]
# }
resource "aws_ami_from_instance" "Publicaafi" {
  name               = "ami-image"
  source_instance_id = aws_instance.PublicInstance.id
}
resource "aws_launch_template" "wordpress" {
  name_prefix   = "wordpress-template"
  image_id      = aws_ami_from_instance.Publicaafi.id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "wordpress-asg" {
  availability_zones        = ["us-east-1a","us-east-1b"]
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true

  launch_template {
    id      = aws_launch_template.wordpress.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.wordpress-asg.id
  lb_target_group_arn    = aws_lb_target_group.test.arn
}