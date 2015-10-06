#����centos6��lnmpһ����

FROM tutum/centos:centos6
MAINTAINER www.9ikj.cn

#����
RUN yum -y update

#��װSSH
RUN yum -y install openssh-server epel-release && \
    yum -y install pwgen && \
    rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

#��װwget tar
RUN yum -y install wget && \
    yum -y install tar

#���ذ�װһ����
RUN wget -c http://static.suod.ga/lnmp/lnmp1.2-full.tar.gz && \
    tar zxf lnmp1.2-full.tar.gz
WORKDIR lnmp1.2-full
RUN ./install.sh lnmp && \
    rm -rf /root/lnmp1.2-full.tar.gz
WORKDIR /
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

#���ص�
VOLUME ["/home/wwwroot"]

#�˿�
EXPOSE 22 80

#����
CMD ["/run.sh"]