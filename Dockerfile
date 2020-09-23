FROM jenkins/inbound-agent:latest-jdk11

USER root

ARG user=jenkins

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&\
    unzip awscliv2.zip &&\
    ./aws/install

RUN git config --global credential.helper '!aws codecommit credential-helper $@' &&\
    git config --global credential.useHttpPath true


#==========
# Gradle
#==========

ENV GRADLE_VERSION 6.5.1

RUN wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp \
  && unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-bin.zip \
  && ln -s /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle /usr/bin/gradle \
  && rm /tmp/gradle-${GRADLE_VERSION}-bin.zip

USER ${user}

ENTRYPOINT ["jenkins-agent"]