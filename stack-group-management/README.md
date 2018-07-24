# CloudFormation Templates

This set of scripts is designed to provide a VPC suitable for software
development.

There are both `stacks-generate.sh` and `stacks-up.sh` scripts so that
changes can be made to the templates separately from execution. This allows
the YAML files to be regenerated when changes to the template are made. Then
a stack can be updated manually.

## Preparation

Create an EC2 Key Pair for each Stack Group that you are creating. For example,
of you will run `./stacks-up dmm dev` then create a key pair called `dmm-dev`.
This key pair is needed when creating a bastion and maybe other times as well.

## Generate Template Files

```
./stacks-generate.sh dmm dev
./stacks-generate.sh dmm test
./stacks-generate.sh dmm staging
./stacks-generate.sh dmm prod
```

## Execute Template Files

```
./stacks-up.sh dmm dev
./stacks-up.sh dmm test
./stacks-up.sh dmm staging
./stacks-up.sh dmm prod
```

## Destroy a Stack Group

```
./stack-destroy dmm dev
./stack-destroy dmm test
./stack-destroy dmm staging
./stack-destroy dmm prod
```
