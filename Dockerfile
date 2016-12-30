FROM mhart/alpine-node:6

RUN apk --update --no-cache add openjdk8-jre openssh git

# Based on dockerfile at https://github.com/alexellis/jenkins2docker/blob/master/slave_node_alpine/Dockerfile
RUN ssh-keygen -A

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

ADD mkuser.sh /var/mkuser.sh

CMD ["sh", "-c", "sh /var/mkuser.sh && /usr/sbin/sshd -d"]