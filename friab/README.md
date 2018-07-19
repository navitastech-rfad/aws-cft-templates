# CloudFormation Templates

This set of scripts is designed to provide a VPC suitable for software
development.

`friab` is a nonsense word being used as a namespace to group a set of
CFM templates all relating to a single VPC.

Please always review these templates before use. Frequently they will need
tweaking. Especially if you change the name of template dependencies. Search
for "!ImportValue" to find references. A specific example is
"!ImportValue friab-dev-01-vpc:vpc-id".

## Configuration

Before running the `stacks-up.sh` script make sure that you have configured
AWS using the `aws configure` command.

Also define an EC2 Key-Pair and put its name into the `example-ec2-instance`
YAML file before using it.

## Introduction

This set of templates work together to provide an ecosystem inside AWS that
accelerates working with AWS services.

The stacks are numbered so you'll know the order to create them.

* 01-vpc-stack - one VPC, two public subnets, two private subnets and a
whole lot of other stuff. On 2017-04-11, there were 35 resources created by
the stack.

* 02-role-readonly-codecommit-ecr-s3-stack - This stack provides an
instance role that can be used with EC2 instances that need read-only access
to CodeCommit, ECR, or S3. This is the type of access needed to deploy
applications (i.e., not for development)

* 03-security-groups-stack - This stack provides single-purpose security
groups so you can use composition to aid clarity.

* 04-hosted-zone-stack - This stack creates a hosted zone that can
provide DNS host names for your servers.

* 05-elasticsearch-stack - This stack creates a three node AWS-managed
Elasticsearch cluster. It allows access by IP from one server. Note that the
DomainName is fixed and based on the stack name. This tightly locks down the
security.

* example-ec2-instance - This stack shows how to create a
launch configuration and an auto-scaling group. The EC2 instance is setup
so that anyone can SSH into it as the `centos` user if they have the PEM key.
The EC2 instance also has curl, git, unzip, docker and the AWS CLI tools
installed. Additionally, the git credential helper is configured for the
`centos` user. By default, a `t2.nano` instance type is used so that costs
are held as low as possible.

## NOTES

* If your template creates a S3 folder and objects are stored in it, then then
stack will not delete automatically.

## Links

* https://aws.amazon.com/answers/infrastructure-management/ec2-scheduler/
* http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-custom-resources-lambda.html
* https://blog.jayway.com/2015/07/04/extending-cloudformation-with-lambda-backed-custom-resources/

## Checking USERDATA

When you send USERDATA into an EC2 instance it is useful to know where the
scripts are located.

Location of USERDATA Script

```
/var/lib/cloud/instance/user-data.txt
```

As the script is executed, the output of the script is located at

```
/var/log/cloud-init.log
```

It's also possible to use curl or wget to get at the script:

```
http://169.254.169.254/latest/user-data
```
