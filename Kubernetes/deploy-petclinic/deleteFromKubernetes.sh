#!/bin/bash

if [ -z "${REPOSITORY_PREFIX}" ]
then 
    echo "Please set the REPOSITORY_PREFIX"
else 
    cat ./Manifests/*.yaml | \
    sed 's#\${REPOSITORY_PREFIX}'"#${REPOSITORY_PREFIX}#g" | \
    kubectl delete -f -
fi
