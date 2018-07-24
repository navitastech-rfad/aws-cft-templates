#!/bin/bash

if [ "$#" -ne 6 ]; then
    echo "  Usage: $0 -n <namespace> -e <environment:dev|test|staging|prod> -c <CIDR>"
    echo "Example: $0 -n fribit -e dev -c 10.5"
    exit 1
fi

while getopts ":n:e:c:" opt; do
  case $opt in
    n)
      NAMESPACE=$OPTARG
      ;;
    e)
      TARGETENV=$OPTARG
      ;;
    c)
      CIDR_BASE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

REGION_NAME="us-east-1"
SGNAME="${NAMESPACE}-${TARGETENV}"

echo ""
echo "STACK GENERATION FOR ${SGNAME}"
echo ""
echo "INPUT PARAMETERS"
echo "----------------"
echo "  CIDR_BASE: $CIDR_BASE"
echo "ENVIRONMENT: $TARGETENV"
echo "  NAMESPACE: $NAMESPACE"

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
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T01} | sed "s/%%CIDR_BASE%%/${CIDR_BASE}/g" > ${F01}
cp ${T02} ${F02}
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T03} > ${F03}
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T04} > ${F04}
cp ${T05} ${F05}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T06} > ${F06}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T07} > ${F07}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T08} > ${F08}

cat <<EOF > ${SGDIR}/stacks-up.sh
#!/bin/bash

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

aws cloudformation deploy \
  --stack-name "${B06}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F06}

aws cloudformation deploy \
  --stack-name "${B07}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F07}

aws cloudformation deploy \
  --stack-name "${B08}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F08}
EOF

cat <<EOF > ${SGDIR}/stacks-destroy.sh
#!/bin/bash
echo "Deleting Stack: ${B01}"
aws cloudformation delete-stack --stack-name ${B01}
aws cloudformation wait stack-delete-complete --stack-name ${B01}
echo "Deleting Stack: ${B02}"
aws cloudformation delete-stack --stack-name ${B02}
aws cloudformation wait stack-delete-complete --stack-name ${B02}
echo "Deleting Stack: ${B03}"
aws cloudformation delete-stack --stack-name ${B03}
aws cloudformation wait stack-delete-complete --stack-name ${B03}
echo "Deleting Stack: ${B04}"
aws cloudformation delete-stack --stack-name ${B04}
aws cloudformation wait stack-delete-complete --stack-name ${B04}
echo "Deleting Stack: ${B05}"
aws cloudformation delete-stack --stack-name ${B05}
aws cloudformation wait stack-delete-complete --stack-name ${B05}
echo "Deleting Stack: ${B06}"
aws cloudformation delete-stack --stack-name ${B06}
aws cloudformation wait stack-delete-complete --stack-name ${B06}
echo "Deleting Stack: ${B07}"
aws cloudformation delete-stack --stack-name ${B07}
aws cloudformation wait stack-delete-complete --stack-name ${B07}
echo "Deleting Stack: ${B08}"
aws cloudformation delete-stack --stack-name ${B08}
aws cloudformation wait stack-delete-complete --stack-name ${B08}
EOF

chmod +x ${SGDIR}/stacks-up-${SGNAME}.sh
chmod +x ${SGDIR}/stacks-destroy-${SGNAME}.sh

echo ""
echo "Generated Files"
echo "-------------------------------------------"
ls -l ${SGDIR}
echo ""
