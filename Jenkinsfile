        stage('git checkout') {
            node {
                cleanWs()
                git credentialsId: 'gitcredentials', url: 'https://github.com/spsuriyah/mediawiki.git'
            }
        }
        stage('terraform init') {
            node {
                sh 'cd application; terraform init '
            }
        }
        stage('terraform plan') {
            node {
                sh 'cd application; terraform plan -var-file=../../access.tfvars -var-file=../../test.tfvars '
            }
        }
        stage('terraform apply') {
            node {
                sh 'cd application; terraform apply -auto-approve -var-file=../../access.tfvars -var-file=../../test.tfvars '
            }
        }        
