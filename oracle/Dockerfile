FROM centos:6.7
MAINTAINER Bernardo Vale <bernardosilveiravale@gmail.com>

# Oracle Dependencies
RUN yum install -y cpan sharutils wget unzip libaio tar gcc

# Downloading Mod Gearman packages
ADD *.sh /
RUN /download_oracle.sh

#Cleaning YUM
RUN yum clean all

# Installing Mod Gearman Worker
RUN (yum --nogpgcheck --enablerepo base -y install /tmp/gearmand-0.33-2.rhel6.x86_64.rpm && yum --nogpgcheck --enablerepo base -y install /tmp/gearmand-devel-0.33-2.rhel6.x86_64.rpm && yum --nogpgcheck --enablerepo base -y install /tmp/mod_gearman2-2.1.1-1.rhel6.x86_64.rpm && yum clean all)

#Supervisord + Nagios Scripts
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm ; \
yum --enablerepo=epel install -y supervisor nagios-nrpe nagios-plugins-icmp nagios-plugins-nt nagios-plugins-nrpe; \
mv -f /etc/supervisord.conf /etc/supervisord.conf.org

ADD ["supervisord.conf", "/etc/"]

#Configuring Gearman
ADD ["worker.conf", "/etc/mod_gearman2/worker.conf"]

# Providing sym links
RUN mkdir -p /usr/local/nagios/libexec ; \
mkdir -p /usr/lib/nagios/plugins ; \
ln -s /usr/lib64/nagios/plugins/check_nrpe /usr/local/nagios/libexec/check_nrpe ; \
ln -s /usr/lib64/nagios/plugins/check_icmp /usr/local/nagios/libexec/check_icmp ; \
ln -s /usr/lib64/nagios/plugins/check_nt /usr/local/nagios/libexec/check_nt ; \
ln -s /usr/lib64/nagios/plugins/check_nrpe /usr/lib/nagios/plugins/check_nrpe ; \
ln -s /usr/lib64/nagios/plugins/check_icmp /usr/lib/nagios/plugins/check_icmp ; \
ln -s /usr/lib64/nagios/plugins/check_nt /usr/lib/nagios/plugins/check_nt

# Oracle instantclient
ADD instantclient-basic-linux.x64-11.2.0.4.0.zip /tmp/instantclient-basic-linux.x64-11.2.0.4.0.zip
ADD instantclient-sdk-linux.x64-11.2.0.4.0.zip /tmp/instantclient-sdk-linux.x64-11.2.0.4.0.zip
ADD instantclient-sqlplus-linux.x64-11.2.0.4.0.zip /tmp/instantclient-sqlplus-linux.x64-11.2.0.4.0.zip

RUN unzip /tmp/instantclient-basic-linux.x64-11.2.0.4.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sdk-linux.x64-11.2.0.4.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sqlplus-linux.x64-11.2.0.4.0.zip -d /usr/local/
RUN ln -s /usr/local/instantclient_11_2 /usr/local/instantclient
RUN ln -s /usr/local/instantclient/libclntsh.so.11.1 /usr/local/instantclient/libclntsh.so
RUN ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus
RUN mkdir -p /usr/local/instantclient/network/admin

# Setting Oracle Variables
ENV LD_LIBRARY_PATH=/usr/local/instantclient ORACLE_HOME=/usr/local/instantclient

#Installing Perl libs for check_oracle_health
RUN /install_perl_oracle.sh
 
ENTRYPOINT ["/entrypoint.sh"]
