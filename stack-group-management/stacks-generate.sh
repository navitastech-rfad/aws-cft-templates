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
B02="${SGNAME}-02-sns-devops"
B03="${SGNAME}-03-bastion"
B04="${SGNAME}-04-roles"
B05="${SGNAME}-05-secgroups"
B06="${SGNAME}-06-hosts"
B07="${SGNAME}-07-es"
B08="${SGNAME}-08-rds"
B09="${SGNAME}-09-nexus"


#dev tool stack names
B19="${SGNAME}-19-IAMRoles"
B20="${SGNAME}-20-SG"
B21="${SGNAME}-21-sonar"
B22="${SGNAME}-22-keycloak"
B23="${SGNAME}-23-kong"
B24="${SGNAME}-24-pinpoint"
B25="${SGNAME}-25-rds-postgres"
B26="${SGNAME}-26-jenkins"

B27="${SGNAME}-27-ecs-cluster"
B30="${SGNAME}-30-ecs-service"



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
F09="${SGDIR}/${B09}.yaml"



#dev tool stack names
F19="${SGDIR}/${B19}.yaml"
F20="${SGDIR}/${B20}.yaml"
F21="${SGDIR}/${B21}.yaml"
F22="${SGDIR}/${B22}.yaml"
F23="${SGDIR}/${B23}.yaml"
F24="${SGDIR}/${B24}.yaml"
F25="${SGDIR}/${B25}.yaml"
F26="${SGDIR}/${B26}.yaml"


F27="${SGDIR}/${B27}.yaml"
F30="${SGDIR}/${B30}.yaml"




T01="01-vpc-stack.template.yaml"
T02="02-sns-devops-stack.template.yaml"
T03="03-bastion.template.yaml"
T04="04-roles-stack.template.yaml"
T05="05-secgroups-stack.template.yaml"
T06="06-hosted-zone-stack.template.yaml"
T07="07-elasticsearch-stack.template.yaml"
T08="08-aurora-mysql.template.yaml"
T09="09-nexus.template.yaml"



#dev tool stack names
T19="19-IAMRoles-stack.template.yaml"
T20="20-SecurityGroups-stack.template.yaml"
T21="21-sonar.template.yaml"
T22="22-keycloak.template.yaml"
T23="23-kong.template.yaml"
T24="24-pinpoint.template.yaml"
T25="25-rds-postgresql-stack.template.yaml"
T26="26-jenkins-stack.template.yaml"

T27="27-ecs-cluster-stack.template.yaml"
T30="30-ecs-app.template.yaml"



VPCNAME="${B01}"

mkdir -p "${SGDIR}"
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T01} | sed "s/%%CIDR_BASE%%/${CIDR_BASE}/g" > ${F01}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T02} > ${F02}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T03} > ${F03}
cp ${T04} ${F04}
sed "s/%%VPCNAME%%/${VPCNAME}/g" ${T05} > ${F05}
cp ${T07} ${F07}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T08} > ${F08}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T09} > ${F09}


#dev tool stack names

sed "s/%%SGNAME%%/${SGNAME}/g" ${T19} > ${F19}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T20} > ${F20}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T21} > ${F21}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T22} > ${F22}

sed "s/%%SGNAME%%/${SGNAME}/g" ${T22} > ${F22}

sed "s/%%SGNAME%%/${SGNAME}/g" ${T23} > ${F23}

sed "s/%%SGNAME%%/${SGNAME}/g" ${T24} > ${F24}

sed "s/%%SGNAME%%/${SGNAME}/g" ${T25} > ${F25}

sed "s/%%SGNAME%%/${SGNAME}/g" ${T26} > ${F26}

sed "s/%%SGNAME%%/${SGNAME}/g" ${T27} > ${F27}
sed "s/%%SGNAME%%/${SGNAME}/g" ${T30} > ${F30}

cat <<EOF > ${SGDIR}/stacks-up.sh
#!/bin/bash


export ENVIRONMENT=$TARGETENV



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

#aws cloudformation deploy \
  --stack-name "${B06}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F06}

#aws cloudformation deploy \
  --stack-name "${B07}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F07}

#aws cloudformation deploy \
  --stack-name "${B08}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F08}

#aws cloudformation deploy \
  --stack-name "${B09}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F09}


aws cloudformation deploy \
  --stack-name "${B19}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F19}

aws cloudformation deploy \
  --stack-name "${B20}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F20}

if [ "\${ENVIRONMENT}" = "dev" ]; then
  

aws cloudformation deploy \
  --stack-name "${B21}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F21} > /dev/null 2>&1 &

aws cloudformation deploy \
  --stack-name "${B22}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F22} > /dev/null 2>&1 &

aws cloudformation deploy \
  --stack-name "${B23}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F23} > /dev/null 2>&1 &


aws cloudformation deploy \
  --stack-name "${B24}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F24} > /dev/null 2>&1 &




aws cloudformation deploy \
  --stack-name "${B26}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F26} > /dev/null 2>&1 &


fi



aws cloudformation deploy \
  --stack-name "${B25}" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F25} \
  --parameter-overrides DBName=${TARGETENV}db DBMasterUsername=dbadmin DBMasterUserPassword=test12345  > /dev/null 2>&1 &




  aws cloudformation deploy \
  --stack-name "${B27}-API" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F27} \
  --parameter-overrides ClusterName=${TARGETENV}-APICluster > /dev/null 2>&1 &


  aws cloudformation deploy \
  --stack-name "${B27}-WEB" \
  --region $REGION_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-file ${F27} \
  --parameter-overrides ClusterName=${TARGETENV}-WebCluster > /dev/null 2>&1 &


EOF

cat <<EOF > ${SGDIR}/stacks-destroy.sh
#!/bin/bash

export ENVIRONMENT=$TARGETENV




echo "Deleting Stack: ${B27}-API"
aws cloudformation delete-stack --stack-name ${B27}-API
aws cloudformation wait stack-delete-complete --stack-name ${B27}-API > /dev/null 2>&1 &

echo "Deleting Stack: ${B27}-Web"
aws cloudformation delete-stack --stack-name ${B27}-WEB
aws cloudformation wait stack-delete-complete --stack-name ${B27}-WEB > /dev/null 2>&1 &


if [ "\${ENVIRONMENT}" = "dev" ]; then
  

echo "Deleting Stack: ${B26}"
aws cloudformation delete-stack --stack-name ${B26}
aws cloudformation wait stack-delete-complete --stack-name ${B26} 


echo "Deleting Stack: ${B25}"
aws cloudformation delete-stack --stack-name ${B25}
aws cloudformation wait stack-delete-complete --stack-name ${B25}  



echo "Deleting Stack: ${B24}"
aws cloudformation delete-stack --stack-name ${B24}
aws cloudformation wait stack-delete-complete --stack-name ${B24} 


echo "Deleting Stack: ${B23}"
aws cloudformation delete-stack --stack-name ${B23}
aws cloudformation wait stack-delete-complete --stack-name ${B23}  

echo "Deleting Stack: ${B22}"
aws cloudformation delete-stack --stack-name ${B22}
aws cloudformation wait stack-delete-complete --stack-name ${B22}  

echo "Deleting Stack: ${B21}"
aws cloudformation delete-stack --stack-name ${B21}
aws cloudformation wait stack-delete-complete --stack-name ${B21}  

fi

echo "Deleting Stack: ${B20}"
aws cloudformation delete-stack --stack-name ${B20}
aws cloudformation wait stack-delete-complete --stack-name ${B20}


echo "Deleting Stack: ${B19}"
aws cloudformation delete-stack --stack-name ${B19}
aws cloudformation wait stack-delete-complete --stack-name ${B19}




echo "Deleting Stack: ${B09}"
aws cloudformation delete-stack --stack-name ${B09}
aws cloudformation wait stack-delete-complete --stack-name ${B09}

echo "Deleting Stack: ${B08}"
aws cloudformation delete-stack --stack-name ${B08}
aws cloudformation wait stack-delete-complete --stack-name ${B08}

echo "Deleting Stack: ${B07}"
aws cloudformation delete-stack --stack-name ${B07}
aws cloudformation wait stack-delete-complete --stack-name ${B07}

echo "Deleting Stack: ${B06}"
aws cloudformation delete-stack --stack-name ${B06}
aws cloudformation wait stack-delete-complete --stack-name ${B06}

echo "Deleting Stack: ${B05}"
aws cloudformation delete-stack --stack-name ${B05}
aws cloudformation wait stack-delete-complete --stack-name ${B05}


echo "Deleting Stack: ${B04}"
aws cloudformation delete-stack --stack-name ${B04}
aws cloudformation wait stack-delete-complete --stack-name ${B04}


echo "Deleting Stack: ${B03}"
aws cloudformation delete-stack --stack-name ${B03}
aws cloudformation wait stack-delete-complete --stack-name ${B03}

echo "Deleting Stack: ${B02}"
aws cloudformation delete-stack --stack-name ${B02}
aws cloudformation wait stack-delete-complete --stack-name ${B02}


echo "Deleting Stack: ${B01}"
aws cloudformation delete-stack --stack-name ${B01}
aws cloudformation wait stack-delete-complete --stack-name ${B01}







EOF

chmod +x ${SGDIR}/stacks-up.sh
chmod +x ${SGDIR}/stacks-destroy.sh

echo ""
echo "Generated Files"
echo "-------------------------------------------"
ls -l ${SGDIR}
echo ""
