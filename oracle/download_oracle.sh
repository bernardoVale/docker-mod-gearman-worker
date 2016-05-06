#!/bin/bash

if [ ! -f /tmp/check_oracle_health-1.7.3.tar.gz ]; then
	wget http://assets.nagios.com/downloads/nagiosxi/packages/check_oracle_health-1.7.3.tar.gz -P /tmp/
fi
if [ ! -f /tmp/DBI-1.636.tar.gz ]; then
	wget http://search.cpan.org/CPAN/authors/id/T/TI/TIMB/DBI-1.636.tar.gz -P /tmp/
fi
if [ ! -f /tmp/DBD-Oracle-1.74.tar.gz ]; then
        wget http://search.cpan.org/CPAN/authors/id/P/PY/PYTHIAN/DBD-Oracle-1.74.tar.gz -P /tmp/
fi
if [ ! -f /tmp/mod_gearman2-2.1.1-1.rhel6.x86_64.rpm ]; then
  wget http://assets.nagios.com/downloads/mod_gearman/v2.1.1/rhel6/x86_64/mod_gearman2-2.1.1-1.rhel6.x86_64.rpm -P /tmp/
fi
if [ ! -f /tmp/gearmand-devel-0.33-2.rhel6.x86_64.rpm ]; then
  wget http://assets.nagios.com/downloads/mod_gearman/v2.1.1/rhel6/x86_64/gearmand-devel-0.33-2.rhel6.x86_64.rpm -P /tmp/
fi
if [ ! -f /tmp/gearmand-0.33-2.rhel6.x86_64.rpm ]; then
  wget http://assets.nagios.com/downloads/mod_gearman/v2.1.1/rhel6/x86_64/gearmand-0.33-2.rhel6.x86_64.rpm -P /tmp/
fi
