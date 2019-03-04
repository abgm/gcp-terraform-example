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


# We will remove state elements referents to kubernetes and cloud sql because they will be destroyed with the instances after

bash -c '
cd services/third-service
terraform workspace select '$1'
terraform destroy -auto-approve
'

bash -c '
cd services/second-registry
terraform workspace select '$1'
terraform destroy -auto-approve
'

bash -c '
cd services/first-registry
terraform workspace select '$1'
terraform destroy -auto-approve
'

bash -c '
cd infrastructure/environment/gke
terraform workspace select '$1'
terraform destroy -auto-approve
'

bash -c '
cd infrastructure/environment/sql-db
terraform workspace select '$1'
terraform destroy -auto-approve
'



