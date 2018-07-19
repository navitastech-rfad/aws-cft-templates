#!/bin/bash

aws cloudformation delete-stack --stack-name friab-dev-05-elasticsearch
aws cloudformation delete-stack --stack-name friab-dev-04-hosted-zone
aws cloudformation delete-stack --stack-name friab-dev-03-security-groups
aws cloudformation delete-stack --stack-name friab-dev-02-role-readonly-codecommit-ecr-s3
aws cloudformation delete-stack --stack-name friab-dev-vpc-01
