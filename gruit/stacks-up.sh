#!/bin/bash

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name gruit-dev-01-vpc \
  --template-file gruit-dev-01-vpc-stack.yaml

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name gruit-dev-02-role-readonly-codecommit-ecr-s3 \
  --template-file gruit-dev-02-role-readonly-codecommit-ecr-s3-stack.yaml

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name gruit-dev-03-security-groups \
  --template-file gruit-dev-03-security-groups-stack.yaml

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name gruit-dev-04-hosted-zone \
  --template-file gruit-dev-04-hosted-zone-stack.yaml

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --region us-east-1 \
  --stack-name gruit-dev-05-elasticsearch \
  --template-file gruit-dev-05-elasticsearch-stack.yaml
