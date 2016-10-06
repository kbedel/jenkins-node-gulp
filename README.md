# jenkins-node-gulp

A docker image which allows building Javascript applications via a Jenkins slave with NodeJS tools

To override the user which Jenkins should run as, you can run like:

`docker run -d -p22:22 -eJENKINSUSER=myuser kbedel/jenkins-node-gulp sh -c 'sh /var/mkuser.sh && /usr/sbin/sshd -d'`

or

`docker run -d -p22:22 kbedel/jenkins-node-gulp sh -c 'JENKINSUSER=myuser && export JENKINSUSER && sh /var/mkuser.sh && /usr/sbin/sshd -d'`