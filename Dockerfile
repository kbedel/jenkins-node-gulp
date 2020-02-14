FROM mhart/alpine-node:12.16

RUN apk update && apk upgrade && \
    apk --no-cache add openssh git chromium \
        ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family ttf-opensans font-adobe-100dpi

# Based on dockerfile at https://github.com/alexellis/jenkins2docker/blob/master/slave_node_alpine/Dockerfile
RUN ssh-keygen -A

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

ADD mkuser.sh /var/mkuser.sh

CMD ["sh", "-c", "sh /var/mkuser.sh && /usr/sbin/sshd -d"]
