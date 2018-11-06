pipeline {
    agent any
    stages {
    	   stage('Test') {
	            steps {
	                sh 'sbt test'
	                junit 'target/test-reports/*.xml'
            }
        }
  	     stage('Build') {
	            steps {
	                sh 'sbt dist'
            }
        }
	    stage('Deliver for DEV') {
            when {
                branch 'PR-*'
            }
            steps {
		    sh 'echo "AWS Provisioning Task: Started"'
		    sh './jenkins/scripts/EC2_on-demand.sh start'
                sh 'export IP=$(cat ip_from_file) && ssh -oStrictHostKeyChecking=no -i /home/leonux/aws/MyKeyPair.pem ec2-user@$IP ./deploy.sh'
	        sh 'export IP=$(cat ip_from_file) && echo "Your app is ready: http://$IP:9000"'
		input message: 'Finished using the web site? (Click "Proceed" to continue)'
	        sh 'export IP=$(cat ip_from_file) && ssh -i /home/leonux/aws/MyKeyPair.pem ec2-user@$IP ./kill.sh'
		    sh 'echo "Terminate Task: Started"'
		    sh './jenkins/scripts/EC2_on-demand.sh terminate'
            }
        }
        stage('Deliver for ITG') {
            when {
                branch 'master' 
            }
            steps {
		    sh 'echo "AWS Provisioning Task: Started"'
		    sh './jenkins/scripts/EC2_on-demand.sh start'
                sh 'export IP=$(cat ip_from_file) && ssh -oStrictHostKeyChecking=no -i /home/leonux/aws/MyKeyPair.pem ec2-user@$IP ./deploy.sh'
	        sh 'export IP=$(cat ip_from_file) && echo "Your app is ready: http://$IP:9000"'
		input message: 'Finished using the web site? (Click "Proceed" to continue)'
	        sh 'export IP=$(cat ip_from_file) && ssh -i /home/leonux/aws/MyKeyPair.pem ec2-user@$IP ./kill.sh'
		    sh 'echo "Terminate Task: Started"'
		    sh './jenkins/scripts/EC2_on-demand.sh terminate'
		    sh './jenkins/scripts/git-release.sh'
            }
        }
    }
}
