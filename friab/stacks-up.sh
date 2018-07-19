#!/bin/bash

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name friab-dev-vpc-01 \
  --template-file friab-dev-vpc-01-stack.yaml

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name friab-dev-02-role-readonly-codecommit-ecr-s3 \
  --template-file friab-dev-02-role-readonly-codecommit-ecr-s3-stack.yaml

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name friab-dev-03-security-groups \
  --template-file friab-dev-03-security-groups-stack.yaml

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name friab-dev-04-hosted-zone \
  --template-file friab-dev-04-hosted-zone-stack.yaml

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name friab-dev-05-elasticsearch \
  --template-file friab-dev-05-elasticsearch-stack.yaml
