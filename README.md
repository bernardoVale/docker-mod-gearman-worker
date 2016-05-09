Getting Started
=================

This container it's used to provide workers for [Mod Gearman](https://labs.consol.de/nagios/mod-gearman/) using the Distribute Monitoring approach as you can see in the picture above:

![Distribute Monitoring](https://labs.consol.de/nagios/mod-gearman/sample_distributed.png)


To be able to use this container you need to specify two environment variables at docker run:

  * Variable `HOSTGROUP` define which Nagios hostgroup this worker will use
  * Variable `SERVER` define ip:port of your Gearman server


#### Basic Example



```
docker run -d --name gearman-worker \
-e HOSTGROUP=MYHOSTGROUP \
-e SERVER=GEARMANSERVER:GEARMAN_PORT \
bernardovale/mod-gearman-worker
```


Tags
===================
Tag `latest` will be always same as `minimum`. This tag it's the minimal setup required to make this container usable.

Tag `oracle` increments tag `minimum` adding Oracle Instant Client and check_oracle_health script

##### latest
   1. mod_gearman_worker 
   2. check_nrpe
   3. check_icmp
   4. check_nt

##### minimum
   1. mod_gearman_worker 
   2. check_nrpe
   3. check_icmp
   4. check_nt

##### oracle
   1. mod_gearman_worker 
   2. check_nrpe
   3. check_icmp
   4. check_nt
   5. check_oracle_health
   6. Oracle Instant Client 11g

Oracle Client
==========================
Container tag `oracle` has an Oracle Instant Client 11.2 installed whithout tnsnames.ora. 

You can provide it as a volume at `docker run`

On your **docker host** start a folder to keep your tnsnames.ora

```
mkdir -p /appliance/oracle

tee /appliance/oracle/tnsnames.ora <<EOF

TESTDB =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.1)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = test)
    )
  )
EOF
```

Lauch your container and map your tnsnames.ora folder pointing to `TNS_ADMIN` which is:

`/usr/local/instantclient/network/admin`

#### Example of a container with Oracle Client
```
docker run -d --name gearman-worker \
-e HOSTGROUP=APP \
-e SERVER=GEARMANSERVER:4730 \
-v /appliance/oracle:/usr/local/instantclient/network/admin \
mod-gearman-worker:oracle
```

#### Testing the check_oracle_health script

Use the command `docker exec` to make a quick connection test with an Oracle database.
```
docker exec gearman-worker bash -c \
"/usr/local/nagios/libexec/check_oracle_health --connect '192.168.0.1:1521/test' \
--username 'system' --password 'mypassword' \
--mode connection-time --warning 1 --critical 5"


OK - 0.07 seconds to connect as SYSTEM | connection_time=0.0676;1;5

```

Troubleshooting
=================

Error:
````
CRITICAL: Return code of 127 is out of bounds. Make sure the plugin 
you're trying to run actually exists. (worker: APP)

[/usr/bin/env: /usr/local/nagios/libexec/check_custom_script
: No such file or directory]

```
**Cause** 

You're using a Nagios script that doesn't exists inside the container.

**Solution**

Send the script from your Docker host to the container via [docker cp] (https://docs.docker.com/engine/reference/commandline/cp/).

`docker cp check_custom_script my-container-name:/usr/local/nagios/libexec/check_custom_script`

**OR**

If you think the script it's really important and others may also benefit from it please send my a PR.
