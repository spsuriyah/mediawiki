        stage('git checkout') {
            node {
                cleanWs()
                git credentialsId: 'gitcredentials', url: 'https://github.com/spsuriyah/mediawiki.git'
            }
        }
        stage('terraform init') {
            node {
                sh 'cd terraform; terraform init '
            }
        }
        stage('terraform plan') {
            node {
                sh 'cd terraform; terraform plan -var-file=../../access.tfvars -var-file=../../test.tfvars '
            }
        }
        stage('terraform apply') {
            node {
                sh 'cd terraform; terraform apply -auto-approve -var-file=../../access.tfvars -var-file=../../test.tfvars '
            }
        }
        stage('ansible deploy') {
            node {
                sh 'cd ansible; ansible-playbook -i host mediawiki_playbook.yml '
            }
        }    
        stage('terraform destroy') {
            node {
                sh 'cd terraform; terraform destroy -auto-approve -var-file=../../access.tfvars -var-file=../../test.tfvars '
            }
        }