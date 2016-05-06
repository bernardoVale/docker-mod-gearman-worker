#!/bin/bash
if [ -z "$CLIENTE" ]; then
	echo "Variavel cliente nao foi setada"
	exit 2
fi
if [ -z "$SERVER" ]; then
        echo "Variavel server nao foi setada"
        exit 2
fi
echo $CLIENTE
echo $SERVER
sed -i "s/identifier\=LB2/identifier\=$CLIENTE/" /etc/mod_gearman2/worker.conf
sed -i "s/hostgroups\=LB2/hostgroups\=$CLIENTE/" /etc/mod_gearman2/worker.conf
sed -i "s/server\=/server\=$SERVER/" /etc/mod_gearman2/worker.conf
/usr/bin/supervisord
