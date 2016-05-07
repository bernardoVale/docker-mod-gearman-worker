#!/bin/bash

#Installing Perl Dependencies for Oracle DB monitoring
cd /tmp
tar -zxvf /tmp/DBI-1.636.tar.gz
tar -zxvf /tmp/DBD-Oracle-1.74.tar.gz
tar -zxvf /tmp/check_oracle_health-1.7.3.tar.gz
cd /tmp/DBI-1.636
echo $ORACLE_HOME
(
	perl Makefile.PL
	make
	make install
)
cd /tmp/DBD-Oracle-1.74
(
	perl Makefile.PL
	make
	make install
)

cd /tmp/check_oracle_health-1.7.3
(
	./configure
	make
	make install
)

export PERL_MM_USE_DEFAULT=1
cpan -i Time::HiRes

# Housekeeping
cd /tmp
rm -rf *.tar.gz
rm -rf /tmp/DBD-Oracle-1.74
rm -rf /tmp/DBI-1.636
rm -rf /tmp/check_oracle_health-1.7.3.tar.gz
rm -rf /tmp/*.rpm
rm -rf /tmp/*.zip
