def testPodYaml = libraryResource 'podtemplates/react/react-test-pod.yml'
pipeline {
  agent none
  options { 
    buildDiscarder(logRotator(numToKeepStr: '10'))
    skipDefaultCheckout true
    preserveStashes(buildCount: 10)
  }
  stages('React Test and Build')
  {
    stage('React Tests') {
      agent {
        kubernetes {
          label 'nodejs'
          yaml testPodYaml
       }
      }
      steps {
            checkout scm           
            container('nodejs') {
              sh '''
                 npm install
                 '''
            }
      } 
    }
    stage('Build and Push Image') {
      when {
        beforeAgent true
        anyOf {
          branch 'main';
          branch 'master'
        }
      }
      steps { 
        kanikoBuildPushGeneric("fresh-start", "latest", "core-flow-research/ldonley-workshop")
        {
          checkout scm
        }
      }
    } 
  }
}
