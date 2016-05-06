#!/bin/bash

if [ ! -f /tmp/mod_gearman2-2.1.1-1.rhel6.x86_64.rpm ]; then
  wget http://assets.nagios.com/downloads/mod_gearman/v2.1.1/rhel6/x86_64/mod_gearman2-2.1.1-1.rhel6.x86_64.rpm -P /tmp/
fi
if [ ! -f /tmp/gearmand-devel-0.33-2.rhel6.x86_64.rpm ]; then
  wget http://assets.nagios.com/downloads/mod_gearman/v2.1.1/rhel6/x86_64/gearmand-devel-0.33-2.rhel6.x86_64.rpm -P /tmp/
fi
if [ ! -f /tmp/gearmand-0.33-2.rhel6.x86_64.rpm ]; then
  wget http://assets.nagios.com/downloads/mod_gearman/v2.1.1/rhel6/x86_64/gearmand-0.33-2.rhel6.x86_64.rpm -P /tmp/
fi
