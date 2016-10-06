FROM mhart/alpine-node:6

RUN apk --update --no-cache add openjdk8-jre openssh git tar make gcc clang g++ python linux-headers paxctl binutils-gold autoconf bison zlib-dev openssl-dev # Everything after git is required just for building the node-sass bindings. Once node-sass officially supports alpine, will no longer be required (https://github.com/sass/node-sass/issues/1589)

# Based on dockerfile at https://github.com/alexellis/jenkins2docker/blob/master/slave_node_alpine/Dockerfile
RUN ssh-keygen -A

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

ADD mkuser.sh /var/mkuser.sh

EXPOSE 22
CMD ["sh", "-c", "sh /var/mkuser.sh && /usr/sbin/sshd -d"]