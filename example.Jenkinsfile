node {

  checkout scm

  stage ("BuildBinary") {
    sh './scripts/build_binary.sh'
  }

	if (env.BRANCH_NAME == "master" || env.BRANCH_NAME == "staging" || env.BRANCH_NAME == "uat") {
    stage ("Build Docker Image") {
      sh './scripts/build_docker_image.sh'
    }

    stage ("Push Docker Image") {
      sh './scripts/push_docker_image.sh'
    }

    stage("Deploy") {
      sh './scripts/deploy.sh'
		}
	}
	
	stage("Clean Up") {
		cleanWs()
  }
}
