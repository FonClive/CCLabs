#!/bin/bash
AWS_Account=`aws sts get-caller-identity --query Account --output text`
echo "AWS account id is $AWS_Account" 