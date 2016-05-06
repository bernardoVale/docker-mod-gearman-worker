FROM centos:6.7
MAINTAINER Bernardo Vale <bernardo.vale@lb2.cm.br>

# Baixando pacotes do Mod Gearman
ADD download.sh /tmp/
RUN yum install -y wget ; \
/tmp/download.sh

#Limpeza do YUM
RUN rm -f /var/lib/rpm/__db* ; rpm --rebuilddb; yum clean all

# Instalando Mod Gearman
RUN (yum --nogpgcheck --enablerepo base -y install /tmp/gearmand-0.33-2.rhel6.x86_64.rpm && yum --nogpgcheck --enablerepo base -y install /tmp/gearmand-devel-0.33-2.rhel6.x86_64.rpm && yum --nogpgcheck --enablerepo base -y install /tmp/mod_gearman2-2.1.1-1.rhel6.x86_64.rpm && yum clean all)

#Supervisord + Nagios Scripts
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm ; \
yum --enablerepo=epel install -y supervisor nagios-nrpe nagios-plugins-icmp nagios-plugins-nt nagios-plugins-nrpe ; \
mv -f /etc/supervisord.conf /etc/supervisord.conf.org

ADD supervisord.conf /etc/

#Configuracao do Mod Gearman
ADD worker.conf /etc/mod_gearman2/worker.conf

#Adicionando script de entrypoint
ADD entrypoint.sh /entrypoint.sh

# Links simbolicos
RUN mkdir -p /usr/local/nagios/libexec ; \ 
ln -s /usr/lib64/nagios/plugins/check_nrpe /usr/local/nagios/libexec/check_nrpe ; \
ln -s /usr/lib64/nagios/plugins/check_icmp /usr/local/nagios/libexec/check_icmp ; \
ln -s /usr/local/nagios/libexec/check_nt /usr/local/nagios/libexec/check_nt

ENTRYPOINT ["/entrypoint.sh"]
