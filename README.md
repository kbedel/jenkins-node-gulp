# jenkins-node-gulp

A docker image which allows building Javascript applications via a Jenkins slave with NodeJS tools

To override the user which Jenkins should run as, pass the following as the Docker command:

`sh -c 'JENKINSUSER=myuser && export JENKINSUSER && sh /var/mkuser.sh && /usr/sbin/sshd -d'`