#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <namespace>"
    echo "Example: $0 fribit"
    exit 1
fi

NAMESPACE=$1

./stacks-up.sh ${NAMESPACE} dev &
./stacks-up.sh ${NAMESPACE} test &
./stacks-up.sh ${NAMESPACE} staging &
./stacks-up.sh ${NAMESPACE} prod &
