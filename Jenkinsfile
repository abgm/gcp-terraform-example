pipeline {
    agent {
        label 'my-docker'
    }
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '20')
        timeout(time: 1, unit: "HOURS")
        disableResume()
        checkoutToSubdirectory 'my-infrastructure'
    }
    stages {
        stage('Validate Terraform') {
            steps {
                withCredentials([file(credentialsId: 'terraform-credential-gcp', variable: 'GOOGLE_CREDENTIALS')]) {
                    withEnv(["HTTP_PROXY=http://no-proxy.my-domain.com:3128", "HTTPS_PROXY=http://no-proxy.my-domain.com:3128"]) {
                        dir('my-infrastructure/infrastructure/environment/sql-db') {
                            sh " terraform init  -backend=false  && terraform validate "
                        }
                        dir('my-infrastructure/infrastructure/environment/gke') {
                            sh " terraform init  -backend=false  && terraform validate -var master_ipv4_cidr_block=10.22.0.0/28 "
                        }
                        dir('my-infrastructure/services/first-service') {
                            sh " terraform init  -backend=false  && terraform validate "
                        }
                        dir('my-infrastructure/services/scond-registry') {
                            sh " terraform init  -backend=false  && terraform validate "
                        }
                    }
                }
            }
        }
    }
    post {
        cleanup {
            deleteDir()
        }
    }
}
