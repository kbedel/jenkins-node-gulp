FROM mhart/alpine-node:6

RUN apk --update --no-cache add openjdk8-jre openssh git tar make gcc clang g++ python linux-headers paxctl binutils-gold autoconf bison zlib-dev openssl-dev # Everything after git is required just for building the node-sass bindings. Once node-sass officially supports alpine, will no longer be required (https://github.com/sass/node-sass/issues/1589)

# Based on dockerfile at https://github.com/alexellis/jenkins2docker/blob/master/slave_node_alpine/Dockerfile
RUN addgroup jenkins && \
    adduser -D jenkins -s /bin/sh -G jenkins && \
    chown -R jenkins:jenkins /home/jenkins && \
    echo "jenkins:jenkins" | chpasswd

RUN ssh-keygen -A

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

RUN apk --update add sudo && \
    rm -rf /var/cache/apk/* && \
echo "%jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
RUN touch ~/.sudo_as_admin_successful
WORKDIR /home/jenkins

EXPOSE 22
CMD ["sudo", "/usr/sbin/sshd", "-D"]