# CloudFormation Templates

This set of scripts is designed to provide a VPC suitable for software
development.

## stacks-generate.sh

This script generates YAML files from templates. These templates are simply
YAML files with some %%VARIABLE%% indicators where `sed` can be used for
customization.

The customized YAML files are placed into the `stack-groups` directory
hierarchy. Each namespace and environment has its own sub-directory.

Separate `stacks-up.sh` and `stacks-destroy.sh` scripts are generated and
placed into the namespace/environemnt sub-directory.

## Preparation

Create an EC2 Key Pair for each Stack Group that you are creating. For example,
of you will run `./stacks-up dmm dev` then create a key pair called `dmm-dev`.
This key pair is needed when creating a bastion and maybe other times as well.

## Generate Template Files

```
./stacks-generate.sh -n dmm -e dev -c 10.5
./stacks-generate.sh -n dmm -e test -c 10.6
./stacks-generate.sh -n dmm -e staging -c 10.7
./stacks-generate.sh -n dmm -e prod -c 10.8
```

Look in `stack-groups\dmm` to see the genereated files.

## Create a Stack Group

See the `stacks-up.sh` script in the namespace/environment sub-directory.

## Destroy a Stack Group

See the `stacks-destroy.sh` script in the namespace/environment sub-directory.
