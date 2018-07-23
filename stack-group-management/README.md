# CloudFormation Templates

This set of scripts is designed to provide a VPC suitable for software
development.

## Preparation

Create an EC2 Key Pair for each Stack Group that you are creating. For example,
of you will run `./stacks-up dmm dev` then create a key pair called `dmm-dev`.
This key pair is needed when creating a bastion and maybe other times as well.

## Create a Stack Group

```
./stacks-up dmm dev
./stacks-up dmm test
./stacks-up dmm staging
./stacks-up dmm prod
```

## Destroy a Stack Group

```
./stack-destroy dmm dev
./stack-destroy dmm test
./stack-destroy dmm staging
./stack-destroy dmm prod
```
