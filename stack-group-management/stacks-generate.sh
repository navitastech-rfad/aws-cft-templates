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

T01="01-vpc-stack.template.yaml"
T02="02-roles-stack.template.yaml"
T03="03-secgroups-stack.template.yaml"
T04="04-hosted-zone-stack.template.yaml"
T05="05-elasticsearch-stack.template.yaml"
T06="06-sns-devops-stack.template.yaml"
T07="07-bastion.template.yaml"
T08="08-aurora-mysql.template.yaml"

VPCNAME="${B01}"

mkdir -p "${SGDIR}"
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T01} > ${F01}
cp ${T02} ${F02}
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T03} > ${F03}
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T04} > ${F04}
cp ${T05} ${F05}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T06} > ${F06}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T07} > ${F07}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T08} > ${F08}
