#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "  Usage: $0 -n <namespace>"
    echo "Example: $0 -n fribit"
    exit 1
fi

while getopts ":n:" opt; do
  case $opt in
    n)
      NAMESPACE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

echo "NAMESPACE: $NAMESPACE"

./stacks-generate.sh -n ${NAMESPACE} -e dev -c 10.5
./stacks-generate.sh -n ${NAMESPACE} -e test -c 10.6
./stacks-generate.sh -n ${NAMESPACE} -e staging -c 10.7
./stacks-generate.sh -n ${NAMESPACE} -e prod -c 10.8
