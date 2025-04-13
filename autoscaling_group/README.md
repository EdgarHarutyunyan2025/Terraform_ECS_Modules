# ECS Auto Scaling Terraform Module

This module configures auto-scaling for
 - an ECS service using **AWS Application Auto Scaling**.
It creates an **Auto Scaling Target** and 
 - an **Auto Scaling Policy** to scale the ECS service based on CPU utilization.

## Resources Created

1. **aws_appautoscaling_target**
   - Sets up an auto-scaling target for the ECS service.

2. **aws_appautoscaling_policy**
   - Creates a scaling policy for the ECS service based on CPU utilization.

## Input Variables

| Name               | Description                                                  | Type     | Default Value       | Required |
|--------------------|--------------------------------------------------------------|----------|---------------------|----------|
| `max_capacity`      | The maximum number of tasks ECS can scale to.                | `number` | `None`              | Yes      |
| `min_capacity`      | The minimum number of tasks ECS should scale to.             | `number` | `None`              | Yes      |
| `resource_id`       | The ARN or ID of the ECS service to apply the scaling policy. | `string` | `None`              | Yes      |

## Output Values

| Name               | Description                                          |
|--------------------|------------------------------------------------------|
| `ecs_target_id`     | The ID of the auto-scaling target.                   |
| `ecs_policy_id`     | The ID of the auto-scaling policy.                   |

## Example Usage

```hcl
module "ecs_auto_scaling" {
  source        = "./modules/ecs_auto_scaling"
  max_capacity  = 10
  min_capacity  = 2
  resource_id   = "arn:aws:ecs:region:account-id:service/cluster-name/service-name"
}

