#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <namespace> <environment:dev|test|staging|prod>"
    echo "Example: $0 fribit dev"
    exit 1
fi

NAMESPACE=$1
TARGETENV=$2

REGION_NAME="us-east-1"

SGNAME="${NAMESPACE}-${TARGETENV}"

# stack names
B01="${SGNAME}-01-vpc"
B02="${SGNAME}-02-roles"
B03="${SGNAME}-03-secgroups"
B04="${SGNAME}-04-hosts"
B05="${SGNAME}-05-es"
B06="${SGNAME}-06-sns-devops"
B07="${SGNAME}-07-bastion"
B08="${SGNAME}-08-rds"

# as files are generated, they go here.
SGDIR="stack-groups/${NAMESPACE}/${TARGETENV}"

# these are the files that wiNAMESPACE}-${TARGETENV}-vpcll be generated.
F01="${SGDIR}/${B01}.yaml"
F02="${SGDIR}/${B02}.yaml"
F03="${SGDIR}/${B03}.yaml"
F04="${SGDIR}/${B04}.yaml"
F05="${SGDIR}/${B05}.yaml"
F06="${SGDIR}/${B06}.yaml"
F07="${SGDIR}/${B07}.yaml"
F08="${SGDIR}/${B08}.yaml"

# aws cloudformation deploy \
#   --stack-name "${B01}" \
#   --region $REGION_NAME \
#   --capabilities CAPABILITY_NAMED_IAM \
#   --template-file ${F01}
#
# aws cloudformation deploy \
#   --stack-name "${B02}" \
#   --region $REGION_NAME \
#   --capabilities CAPABILITY_NAMED_IAM \
#   --template-file ${F02}
#
# aws cloudformation deploy \
#   --stack-name "${B03}" \
#   --region $REGION_NAME \
#   --capabilities CAPABILITY_NAMED_IAM \
#   --template-file ${F03}
#
# aws cloudformation deploy \
#   --stack-name "${B04}" \
#   --region $REGION_NAME \
#   --capabilities CAPABILITY_NAMED_IAM \
#   --template-file ${F04}
#
# aws cloudformation deploy \
#   --stack-name "${B05}" \
#   --region $REGION_NAME \
#   --capabilities CAPABILITY_NAMED_IAM \
#   --template-file ${F05}
#
# aws cloudformation deploy \
#   --stack-name "${B06}" \
#   --region $REGION_NAME \
#   --capabilities CAPABILITY_NAMED_IAM \
#   --template-file ${F06}
#
# aws cloudformation deploy \
#   --stack-name "${B07}" \
#   --region $REGION_NAME \
#   --capabilities CAPABILITY_NAMED_IAM \
#   --template-file ${F07}
#
# aws cloudformation deploy \
#   --stack-name "${B08}" \
#   --region $REGION_NAME \
#   --capabilities CAPABILITY_NAMED_IAM \
#   --template-file ${F08}
