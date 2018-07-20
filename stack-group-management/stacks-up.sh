#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <namespace> <environment:dev|test|staging|prod>"
    echo "Example: $0 fribit dev"
    exit 1
fi

NAMESPACE=$1
TARGETENV=$2

REGION_NAME="us-east-1"

# stack names
B01="${NAMESPACE}-${TARGETENV}-01-vpc"
B02="${NAMESPACE}-${TARGETENV}-02-roles"
B03="${NAMESPACE}-${TARGETENV}-03-secgroups"
B04="${NAMESPACE}-${TARGETENV}-04-hosts"
B05="${NAMESPACE}-${TARGETENV}-05-es"

# as files are generated, they go here.
SGDIR="stack-groups/${NAMESPACE}/${TARGETENV}"

# these are the files that wiNAMESPACE}-${TARGETENV}-vpcll be generated.
F01="${SGDIR}/${B01}.yaml"
F02="${SGDIR}/${B02}.yaml"
F03="${SGDIR}/${B03}.yaml"
F04="${SGDIR}/${B04}.yaml"
F05="${SGDIR}/${B05}.yaml"

T01="01-vpc-stack.template.yaml"
T02="02-roles-stack.template.yaml"
T03="03-secgroups-stack.template.yaml"
T04="04-hosted-zone-stack.template.yaml"
T05="05-elasticsearch-stack.template.yaml"

VPCNAME="${B01}"

mkdir -p "${SGDIR}"
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T01} > ${F01}
cp ${T02} ${F02}
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T03} > ${F03}
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T04} > ${F04}
cp ${T05} ${F05}

aws cloudformation deploy \
  --stack-name "${B01}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F01}

aws cloudformation deploy \
  --stack-name "${B02}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F02}

aws cloudformation deploy \
  --stack-name "${B03}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F03}

aws cloudformation deploy \
  --stack-name "${B04}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F04}

aws cloudformation deploy \
  --stack-name "${B05}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F05}
