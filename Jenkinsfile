pipeline {
    agent any
    
    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git branch: 'main', credentialsId: 'b0f761c5-c059-4df9-845f-0624d4ec2dc0', url: 'https://github.com/rawatvinay/terraform.git'
                        }
                    }
                }
            }

        stage('Plan') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh 'terraform -chdir=env/sandbox/appserver/ init'
                //sh 'terraform -chdir=env/sandbox/appserver/ workspace select ${environment} || terraform -chdir=env/sandbox/appserver/ workspace new ${environment}'

                sh "terraform -chdir=env/sandbox/appserver/ plan"
                //sh 'terraform -chdir=env/sandbox/appserver/ show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Apply') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }
        
        stage('Destroy') {
            when {
                equals expected: true, actual: params.destroy
            }
        
        steps {
           sh "terraform destroy --auto-approve"
        }
    }

  }
}
