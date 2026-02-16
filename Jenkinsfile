pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-north-1'
    }

    stages {
        stage('Checkout GitHub Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/gaurav2311gehu/Ideal-Terraform-Project.git'
            }
        }

        stage('Bootstrap Backend') {
            steps {
                dir('backend_bootstrap') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                        // Initialize and apply backend (S3 + DynamoDB)
                        sh '/usr/bin/terraform init'
                        sh '/usr/bin/terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Main Infra Init') {
            steps {
                dir('main-infra') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                        sh '/usr/bin/terraform init -reconfigure'
                    }
                }
            }
        }

        stage('Plan') {
            steps {
                dir('main-infra') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                        sh '/usr/bin/terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Apply') {
            steps {
                dir('main-infra') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                        sh '/usr/bin/terraform apply -auto-approve tfplan'
                    }
                }
            }
        }

        stage('Wait 10 Minutes') {
            steps {
                echo 'Infrastructure live for testing...'
                sleep time: 10, unit: 'MINUTES'
            }
        }

        stage('Destroy Main Infrastructure') {
            steps {
                dir('main-infra') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                        // Only destroy main infrastructure; backend remains
                        sh '/usr/bin/terraform destroy -auto-approve'
                    }
                }
            }
        }

        // Optional: Destroy backend (S3 + DynamoDB) for full cleanup
        // WARNING: Only enable for practice environments
        stage('Destroy Backend (Optional)') {
            steps {
                dir('backend_bootstrap') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                        sh '/usr/bin/terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}
