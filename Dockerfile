#基于centos6的lnmp一键包

FROM tutum/centos:centos6
MAINTAINER www.9ikj.cn

#更新
RUN yum -y update

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
    yum -y install tar

#下载安装一键包
RUN wget -c http://soft.vpser.net/lnmp/lnmp1.2-full.tar.gz && \
    tar zxf lnmp1.2-full.tar.gz && \
    rm -rf /root/lnmp1.2-full.tar.gz
WORKDIR /
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

#端口
EXPOSE 22 80

#运行
CMD ["/run.sh"]
