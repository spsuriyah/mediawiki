# aws-automation
Automate the infrastructure through GIT,Jenkins,Terraform and Ansible.

#Prerequesties

Jenkins Server - With Terraform and ansible plugin installed

configure jenkins and save credentials for aws and git repostory in global configuration in jenkins configuration.

For security, you may use vault,KMS for credentials store

#create pipeline 

 create pipeline project in jenkins using jenkinsfile in the git repo

 Once pipeline triggered, you job will start and infrastructure created in your aws environment

 Get ip address of the machine and paste in ansible host file

# Run Ansible command in jenkins server  

cd mediawiki/ansible
ansible-playbook -i host mediawiki_playbook.yml -vv

