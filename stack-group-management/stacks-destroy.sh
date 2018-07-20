#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <namespace> <environment:dev|test|staging|prod>"
    echo "Example: $0 fribit dev"
    exit 1
fi

NAMESPACE=$1
TARGETENV=$2

# stack names
B01="${NAMESPACE}-${TARGETENV}-01-vpc"
B02="${NAMESPACE}-${TARGETENV}-02-roles"
B03="${NAMESPACE}-${TARGETENV}-03-secgroups"
B04="${NAMESPACE}-${TARGETENV}-04-hosts"
B05="${NAMESPACE}-${TARGETENV}-05-es"

echo "${B5}"
echo "${B4}"
echo "${B3}"
echo "${B2}"
echo "${B1}"

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
