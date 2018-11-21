FROM remuslazar/typo3-dev:6

RUN apt-get update && apt-get install -y openssh-server vim-tiny sudo git less mysql-client awscli \
 && mkdir /var/run/sshd \
 && usermod -s /bin/bash www-data \
 && echo "www-data ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
