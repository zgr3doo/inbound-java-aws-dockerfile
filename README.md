# Linux Docker slave agent image for inbound Jenkins agents on AWS with Java 11
based on [jenkins/inbound-agent](https://hub.docker.com/r/jenkins/inbound-agent/).


## Running

To run a Docker container

  Linux agent:

    docker run --init zgr3doo/inbound-java-aws -url http://jenkins-server:port <secret> <agent name>
  Note: `--init` is necessary for correct subprocesses handling (zombie reaping)

    docker run --init zgr3doo/inbound-java-aws -url http://jenkins-server:port -workDir=/home/jenkins/agent <secret> <agent name>

Optional environment variables:

* `JENKINS_URL`: url for the Jenkins server, can be used as a replacement to `-url` option, or to set alternate jenkins URL
* `JENKINS_TUNNEL`: (`HOST:PORT`) connect to this agent host and port instead of Jenkins server, assuming this one do route TCP traffic to Jenkins master. Useful when when Jenkins runs behind a load balancer, reverse proxy, etc.
* `JENKINS_SECRET`: agent secret, if not set as an argument
* `JENKINS_AGENT_NAME`: agent name, if not set as an argument
* `JENKINS_AGENT_WORKDIR`: agent work directory, if not set by optional parameter `-workDir`
* `JENKINS_WEB_SOCKET`: `true` if the connection should be made via WebSocket rather than TCP

Make sure your ECS container agent is [updated](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html) before running. Older versions do not properly handle the entryPoint parameter. See the [entryPoint](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definitions) definition for more information.