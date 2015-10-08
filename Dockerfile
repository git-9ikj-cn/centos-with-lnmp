#基于centos6的已下载lnmp在root目录

FROM centos:centos6
MAINTAINER www.9ikj.cn

#安装SSH
RUN yum -y install openssh-server epel-release && \
    yum -y install pwgen && \
    rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

#安装wget tar
RUN yum -y install wget && \
    yum -y install tar && \
    yum -y install screen

#下载安装一键包解压到root
RUN wget -c http://soft.vpser.net/lnmp/lnmp1.2-full.tar.gz && \
    tar zxf lnmp1.2-full.tar.gz -C root && \
    rm -rf lnmp1.2-full.tar.gz

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

#端口
EXPOSE 22 80 3306

#变量
ENV AUTHORIZED_KEYS **None**
#挂载
VOLUME ['/home']

#运行
CMD ["/run.sh"]
