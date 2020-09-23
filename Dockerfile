FROM jenkins/inbound-agent:latest-jdk11

USER root

ARG user=jenkins

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&\
    unzip awscliv2.zip &&\
    ./aws/install

RUN git config --global credential.helper '!aws codecommit credential-helper $@' &&\
    git config --global credential.useHttpPath true

USER ${user}

ENTRYPOINT ["jenkins-agent"]