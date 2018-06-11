FROM mhart/alpine-node:10.2

RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk --no-cache add openjdk8-jre openssh git chromium@edge nss@edge \
        ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family ttf-opensans font-adobe-100dpi \
        firefox@edge

# Based on dockerfile at https://github.com/alexellis/jenkins2docker/blob/master/slave_node_alpine/Dockerfile
RUN ssh-keygen -A

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

ADD mkuser.sh /var/mkuser.sh

CMD ["sh", "-c", "sh /var/mkuser.sh && /usr/sbin/sshd -d"]
