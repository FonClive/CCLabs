#!/bin/bash
regions=(us-east-2 us-east-1 eu-central-1 eu-west-1)

for region in "${regions[@]}"
do 
    echo "Creating AWS bucket"

    if [[ region == "us-east-1" ]]; then 
        aws cloudformation deploy\
        --stack-name s3-auto-deploy \
        --template-body file://s3.yml \
        --parameters file://s3-params.json 

    else if [[ region == "us-east-2" ]]; then 
        aws cloudformation deploy\
        --stack-name s3-auto-deploy \
        --template-body file://s3.yml \
        --parameters file://s3-params.json

    else if [[ region == "eu-central-1" ]]; then 
        aws cloudformation deploy\
        --stack-name s3-auto-deploy \
        --template-body file://s3.yml \
        --parameters file://s3-params.json

    else if [[ region == "eu-west-1" ]]; then 
        aws cloudformation deploy\
        --stack-name s3-auto-deploy \
        --template-body file://s3.yml \
        --parameters file://s3-params.json
    else
        echo "Region not supported"
    fi
done
