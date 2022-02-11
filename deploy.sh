#!/bin/bash

set -x
export AWS_DEFAULT_REGION=us-east-1

if [[ $BRANCH_NAME == feature-* ]]
then
    cd api/
    make build stage=dev
    make push stage=dev
    make deploy stage=dev
    cd ..
    cd web/
    make build stage=dev
    make push stage=dev
    make deploy stage=dev
elif [[ $BRANCH_NAME == master ]]
then
    cd api/
    make build stage=staging
    make push stage=staging
    make deploy stage=staging
    cd ..
    cd web/
    make build stage=staging
    make push stage=staging
    make deploy stage=staging
elif [[ $BRANCH_NAME == production/deploy ]]
then
    cd api/
    make deploy stage=prod
    cd ..
    cd web/
    make deploy stage=prod
fi
