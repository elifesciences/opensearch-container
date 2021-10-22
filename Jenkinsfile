elifePipeline {
    node('containers-jenkins-plugin') {
        def commit
        def tag
        stage 'Checkout', {
            checkout scm
            commit = elifeGitRevision()
            tag = commit
        }

        stage 'Build image', {
            sh "docker build -f Dockerfile -t elifesciences/opensearch:${tag} --build-arg image_tag=${commit} ."
        }

        stage 'Sanity tests', {
            def container = sh(script: "docker run -d elifesciences/opensearch:${tag} -e \"discovery.type=single-node\"", returnStdout: true).trim()
            try {
                sh "sleep 10 && docker exec ${container} curl --silent localhost:9200"
            } finally {
                sh "docker stop ${container}"
                sh "docker rm ${container}"
            }
        }

        elifeMainlineOnly {
            stage 'Push image', {
                sh "docker push elifesciences/opensearch:${tag}"
                sh "docker tag elifesciences/opensearch:${tag} elifesciences/opensearch:latest && docker push elifesciences/opensearch:latest"
            }
        }
    }
}
