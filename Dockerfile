FROM centos:latest
MAINTAINER Jiu Ai <admin@9ikj.cn>

RUN yum -y install openssh-server epel-release && \
    yum -y install pwgen && \
    rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

RUN yum -y install wget tar screen

RUN RUN wget -c http://static.suod.ga/lnmp/lnmp1.2-full.tar.gz && \
    tar zxf lnmp1.2-full.tar.gz -C root && \
    rm -rf lnmp1.2-full.tar.gz

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**
ENV ROOT_PASS **RANDOM**

VOLUME ["/home"]

EXPOSE 22 80 3306

CMD ["/run.sh"]
