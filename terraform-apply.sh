#!/usr/bin/env bash
if [ -z "$1" ]; then
    echo "Need to set workspace"
    echo "./terraform-apply.sh <workspace> [noProxy]"
    exit 1
fi
if [ -z "$GOOGLE_CREDENTIALS" ]; then
    echo "Need to set GOOGLE_CREDENTIALS"
    export GOOGLE_CREDENTIALS=$(pwd)/credential.json
fi

if [ -z "$2" ]; then
    echo "Need proxy!"
    if [ -z "$HTTP_PROXY" ]; then
        echo "Need to set HTTP_PROXY"
        export HTTP_PROXY=http://no-proxy.my-domain.com:3128
    fi
    if [ -z "$HTTPS_PROXY" ]; then
        echo "Need to set HTTPS_PROXY"
        export HTTPS_PROXY=http://no-proxy.my-domain.com:3128
    fi
fi

bash -c '
cd infrastructure/environment/sql-db
terraform init
terraform workspace new '$1' || terraform workspace select '$1'
terraform init
terraform apply -auto-approve
'

bash -c '
cd infrastructure/environment/gke
terraform init
terraform workspace new '$1' || terraform workspace select '$1'
terraform init
terraform apply -auto-approve
'

bash -c '
cd services/first-registry
terraform init
terraform workspace new '$1' || terraform workspace select '$1'
terraform init
terraform apply -auto-approve
'

bash -c '
cd services/second-service
terraform init
terraform workspace new '$1' || terraform workspace select '$1'
terraform init
terraform apply -auto-approve
'


bash -c '
cd services/third-service
terraform init
terraform workspace new '$1' || terraform workspace select '$1'
terraform init
terraform apply -auto-approve
'