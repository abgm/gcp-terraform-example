# Infrastructure-as-code

[Dependencies](Dependencies.md)

## Pre-reqs
* export GOOGLE_CREDENTIALS=$(pwd)/credential.json (backend on terraform start before the core services the credential file can't be dynamic)

## Running Order
1. my-infrastructure/infrastructure/environment/sql-db (create cloud sql service instance)
2. my-infrastructure/infrastructure/environment/gke (create Kubernetes Engine instance, dependent of 1 )
3. my-infrastructure/services/first-service (install first-service service on cluster, dependent of 1&2)
4. my-infrastructure/services/second-service (install second-service service on cluster, dependent of 1&2)
5. my-infrastructure/services/third-service (install third-service on cluster, dependent of 1,2,3,4)

To run any of the above, execute the following commands in the appropriate project sub-directory:
````bash
    terraform init
    terraform workspace new [dev|int|prod|<user>]
    terraform plan
    terraform apply
````
