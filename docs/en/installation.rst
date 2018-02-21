.. :maxdepth: 2


=====================================
YETI installation manual for Debian 8
=====================================



Overview
========

Minimal system installation requires following components:

- Routing database (postgresql-9.4)
  see `Databases installation`_

- CDRs database (postgresql-9.4)
  see `Databases installation`_

- Management interface (web interface written on RoR)
  see `Management interface installation`_

- DSS storage (Redis)
  see `DSS Storage installation`_

- Management server (configurations server)
  see `Management server installation`_

- Traffic switch (SBC based on SEMS)
  see `Traffic switch server installation`_

- Load balancer (kamailio)
  see `Load balancer installation`_
  
  
Repositories configuration
==========================

All servers can use same repositories set::

    deb http://ftp.us.debian.org/debian/ jessie main contrib non-free
    deb http://ftp.us.debian.org/debian/ jessie-updates main
    deb http://security.debian.org/ jessie/updates main
    deb http://pkg.yeti-switch.org/debian/jessie stable main ext
    

System repositories can be changed by editing of file: /etc/apt/sources.list

.. code-block:: console

	root@evial:/# apt-key adv --keyserver keys.gnupg.net --recv-key 9CEBFFC569A832B6

Databases installation
======================

System requires two databases: one for routing and one for CDRs. Setting up different PostgreSQL instances is highly recommended to make replication possible.

We recommend placing routing database on the same host with management interface to reduce network latency and response times for best performance and web interface responsiveness. 

Packages installation
---------------------

both routing and CDRs databases require similar set of packages.

::

    # aptitude update && aptitude install postgresql-9.4 postgresql-contrib-9.4 postgresql-9.4-prefix postgresql-9.4-pgq3 postgresql-9.4-yeti skytools3 skytools3-ticker

Databases creation
------------------

Create routing database

.. code-block:: console

    # su - postgres
    $ psql


.. code-block:: psql

    postgres=# create user yeti encrypted password 'somepassword' superuser; 
    CREATE ROLE 
    postgres=# create database yeti owner yeti; 
    CREATE DATABASE 
    postgres=# \q

Create database to store CDR::

    # su - postgres
    $ psql
    postgres=# create database cdr owner yeti;
    CREATE DATABASE
    postgres=# \q

.. warning:: It's recommended to choose databases names, usernames and passwords different from specified in this manual for security reasons.

For large installations it's recommended to place CDR database on dedicated server.

Checks
------

Check if databases were successfully created and are accessible::

    root@evial:/# psql -h 127.0.0.1 -U yeti -d yeti
    Password for user yeti:  psql (9.4.5) SSL connection
    (cipher: DHE-RSA-AES256-GCM-SHA384, bits: 256) 
    Type "help" for help.

    yeti=# \q
    root@evial:/#

    root@evial:/# psql -h 127.0.0.1 -U yeti -d cdr
    Password for user yeti: 
    psql (9.4.5) 
    SSL connection (cipher: DHE-RSA-AES256-GCM-SHA384, bits: 256) 
    Type "help" for help.

    cdr=# \q 
    root@evial:/#

Don't forget to make changes in /etc/postgresql/9.4/main/pg_hba.conf
and apply them if you plan to access this databases from other hosts and/or set up database replication

Schema creation and database initialization
-------------------------------------------

Look at `Databases connection configuration`_ and `Databases data initialization`_ 
for further databases initialization instructions.

Management interface installation
=================================

Server requirements:

- OS Debian 8 Wheezy with amd64 architecture
- at least 1GB of RAM

Packages installation
---------------------

::

    # aptitude update && aptitude install yeti-web nginx

Databases connection configuration
----------------------------------

To configure databases connection parameters edit /home/yeti-web/config/database.yml file

Create database.yml file with the following content:

.. code-block:: yaml

    production: 
      adapter: postgresql
      encoding: unicode
      database: yeti
      pool: 5
      username: yeti
      password: somepassword
      host: 127.0.0.1
      schema_search_path: gui, public, switch, billing, class4, runtime_stats, sys, logs, data_import
      port: 5432
      min_messages: notice
    
    secondbase:
      production:
        adapter: postgresql
        encoding: unicode
        database: cdr
        pool: 5
        username: yeti
        password: somepassword
        host: 127.0.0.1
        schema_search_path: 'cdr, reports, billing'
        port: 5432
        min_messages: notice

Warning: you should specify correct addresses and credentials that were used in previous section

Databases data initialization
-----------------------------

To simplify work with databases use utility yeti-db
To initialize empty databases::

    # cd /home/yeti-web 
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:create db:structure:load db:migrate
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:create db:second_base:structure:load db:second_base:migrate
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:seed
 
    
To upgrade databases to the latest version::

    # cd /home/yeti-web 
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate
    
    
Nginx configuration
-------------------

For basic configuration remove default config and copy yeti-web.dist.nginx::

    # rm /etc/nginx/sites-enabled/default
    # cp /home/yeti-web/config/yeti-web.dist.nginx /etc/nginx/sites-enabled/yeti
    # nginx -t
    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
    # service nginx restart
    

Launch
------

After successful configuration of databases you finally can run software using following commands::

    # service yeti-web start 
    # service yeti-cdr-billing@cdr_billing start
    # service yeti-delayed-job start

This will run web-interface and CDR processing workers

Checks
------

check if unicorn listens on local socket::

    # netstat -lpn | grep unicorn
    unix 2 [ ACC ] STREAM LISTENING 2535145 24728/unicorn.rb -E /tmp/yeti-unicorn.sock

check if nginx listens on correct TCP/IP addresses and ports::

    # netstat -lpn | grep nginx
    tcp 0 0 0.0.0.0:80 0.0.0.0:* LISTEN 23627/nginx
    tcp 0 0 127.0.0.1:6666 0.0.0.0:* LISTEN 23627/nginx

Log files to check for possible warnings/errors :

- /var/log/yeti-admin.log
- /var/log/yeti-cdr-billing.log
- /home/yeti-web/log/unicorn.stdout.log
- /home/yeti-web/log/unicorn.stderr.log

Try to open management interface in your favorite browser and login with default credentials:

:user: admin
:password: 111111

CDR billing and PGQ ticker
==========================

After initialization of CDR database you should run skytools pgq ticker daemon on server with CDR database.

Create configuration file /etc/skytools/pgqd.ini 

.. code-block:: ini
    
    [pgqd]
    base_connstr = host=127.0.0.1 port=5432 dbname=cdr user=yeti password=somepassword
    initial_database = cdr
    database_list = cdr
    script = /usr/bin/pgqd
    pidfile = /var/run/skytools/pgqd.pid
    ticker_max_count=1
    ticker_max_lag=3
    ticker_idle_period=360

Then you can start ticker::

    # service skytools3 start   


DSS Storage installation
========================

Redis is used to synchronize data between traffic switch instances.
It stores information about used resources (e.g gateways capacity limits)
to provide correct limitation among all nodes for distributed installations.

Install packages
----------------

::

    # aptitude install redis-server

Checks
------

Try to enter redis console from traffic switch host
(redis installed at the same host
with traffic switch in this example)::

    # redis-cli
    127.0.0.1:6379> ping
    PONG
    127.0.0.1:6379> quit

Management server installation
==============================

Since version 1.6.3-175 we started to use central configuration server
to store yeti module configuration for all nodes in cluster.

Packages installation
---------------------

::

    # aptitude install yeti-management

Configuration files
-------------------

/etc/yeti/management.cfg
~~~~~~~~~~~~~~~~~~~~~~~~

This file contains configuration for management daemon.

Set desired logging level and address to listen.

You can set multiple addresses separated by comma to listen on multiple interfaces.

Possible log_level values are: (1 - error, 2 - info, 3 - debug)

.. code-block:: c

    daemon {
      listen = {
        "tcp://0.0.0.0:4444"
      }
      log_level = 2
    }

/etc/yeti/system.cfg
~~~~~~~~~~~~~~~~~~~~

This file contains configuration for all nodes.
Each top-level section defines configuration for node of certain type
(signaling is for traffic switch nodes).
All top-level sections contains mandatory section globals
which must have all possible values common for all nodes.
Then there is named sections for each node_id which may contain
values overriding ones set in global section.

Note: even if your node does not have
any specific values you have to define empty section
for this node anyway, otherwise management node
will not provide configuration for node with this id.

Example of minimal configuration file for node with id 0::

    signalling {
      globals {
        yeti {
          pop_id = 2
          msg_logger_dir = /var/spool/sems/dump
          log_dir = /var/spool/sems/logdump
          routing {
            schema = switch14
            function = route_release
            init = init
            master_pool {
              host = 127.0.0.1
              port = 5432
              name = yeti
              user = yeti
              pass = yeti
              size = 4
              check_interval = 10
              max_exceptions = 0
              statement_timeout=3000
            }
            failover_to_slave = false
            slave_pool {
              host = 127.0.0.1
              port = 5432
              name = yeti
              user = yeti
              pass = yeti
              size = 4
              check_interval = 10
              max_exceptions = 0
              statement_timeout=3000
            }
            cache {
              enabled = false
              check_interval = 60
              buckets = 100000
            }
          }
          cdr {
           dir = /var/spool/sems/cdrs
           completed_dir = /var/spool/sems/cdrs/completed
           pool_size = 2
           schema = switch
           function = writecdr
           master {
             host = 127.0.0.1
             port = 5432
             name = cdr
             user = cdr
             pass = cdr
          }
           failover_to_slave = false
           slave {
             host = 127.0.0.1
             port = 5432
             name = cdr
             user = cdr
             pass = cdr
           }
           failover_requeue = true
           failover_to_file = false
           serialize_dynamic_fields = false
         }
         resources {
           reject_on_error = false
           write {
             host = 127.0.0.1
             port = 6379
             size = 2
             timeout = 500
           }
           read {
             host = 127.0.0.1
             port = 6379
             size = 2
             timeout = 1000
           }
         }
         registrations {
           check_interval = 5000
         }
         rpc {
           calls_show_limit = 1000
         }
       }
      }
      node 0 { }
    } 

Management server launch
------------------------

Launch configured management server instance::

    # service yeti-management start

Checks
------

Check file /var/log/yeti/yeti-management.log for daemon logs::

    # tail -2 /var/log/yeti/yeti-management.log
    Sep 12 12:54:47 evial yeti-management[25376]: [25376] 
      info: server/src/yeti_mgmt_server.cpp:148: starting version 1.0.5
    Sep 12 12:54:47 evial yeti-management[25376]: [25376]
      info: server/src/mgmt_server.cpp:123: listen on tcp://0.0.0.0:4444

Check listening port::

    # netstat -lpn | grep yeti_management
    4444 tcp 0 0 0.0.0.0:4444 0.0.0.0:* LISTEN 25376/yeti_manageme

Traffic switch server installation
==================================

Install packages
----------------

::

    # aptitude install sems sems-modules-yeti
    
Configuration files
-------------------

/etc/sems/sems.conf
~~~~~~~~~~~~~~~~~~~

Replace <SIGNALLING_IP>, <MEDIA_IP> with correct values for your server ::

    interfaces=intern
    sip_ip_intern=<SIGNALLING_IP> 
    sip_port_intern=5061 
    media_ip_intern=<MEDIA_IP> 
    rtp_low_port_intern=20000 
    rtp_high_port_intern=50000
    plugin_path=/usr/lib/sems/plug-in/ 
    load_plugins=wav;ilbc;speex;gsm;adpcm;l16;g722;yeti;session_timer;uac_auth;di_log;registrar_client;jsonrpc
    application = yeti
    plugin_config_path=/etc/sems/etc/
    fork=yes
    stderr=no
    syslog_loglevel=2
    max_shutdown_time = 10

    session_processor_threads=20
    media_processor_threads=2
    session_limit="4000;509;Node overloaded"
    shutdown_mode_reply="508 Node in shutdown mode"
    options_session_limit="900;503;Warning, server soon overloaded"
    # cps_limit="100;503;Server overload"
    use_raw_sockets=yes 
    sip_timer_B = 8000 
    default_bl_ttl=0
    registrations_enabled=no

/etc/sems/etc/yeti.conf
~~~~~~~~~~~~~~~~~~~~~~~

Add new node to the routing database using web interface
[ System -> Nodes -> New Node ].
Use id of newly created node as value for **node_id** parameter

node_id
    unique signaling node id
cfg_timeout
    timeout of waiting response from management node
cfg_urls
    list of comma separated names for management node addresses
cfg_url_<name>
    management node address to fetch configuration ([sub:/etc/yeti/management.cfg])

::

    node_id = <id of created node>
    
    cfg_timeout = 1000
    
    cfg_urls = main
    cfg_url_main = tcp://127.0.0.1:4444
    core_options_handling=yes
    

Other configuration files
~~~~~~~~~~~~~~~~~~~~~~~~~

Copy defaults for the rest of needed configuration files::

    # mv /etc/sems/etc/jsonrpc.conf.dist /etc/sems/etc/jsonrpc.conf

Edit this file to change listenging address if you are going to build a multi-node system

Launch traffic switch
---------------------

Launch configured traffic switch instance::

    # service sems start

In case of errors it's useful to use **sems -E -D3** command
which will launch daemon in foreground with debug logging level

Checks
------

Check if **sems** process exists and signaling/media/rpc sockets are opened::

    # pgrep sems
    29749
    # netstat -lpn | grep sems
    tcp 0    0 127.0.0.1:8090 0.0.0.0:*  LISTEN 29749/sems
    udp 0    0 127.0.0.1:5061 0.0.0.0:*         29749/sems
    raw 2688 0 0.0.0.0:17     0.0.0.0:*  7      29749/sems

Check logfile /var/log/sems/sems-main.log for possible errors

Load balancer installation
==========================

Packages installation
---------------------

::

    # aptitude install yeti-lb
    
Note: On package configuration stage
you will be asked to specify address of previously installed
signaling node and address for load balancer to listen on.

After installation you can change any parameters by editing files:
/etc/kamailio/dispatcher.list and /etc/kamailio/lb.conf

Launch
------

Launch load balancer::

    # service kamailio start

Checks
------

Check kamailio running and listening desired sockets::

    # pgrep kamailio
    30853
    30854
    30855
    30856
    30857
    # netstat -lpn | grep kamailio
    tcp 0 0 127.0.0.1:5060 0.0.0.0:* LISTEN 30857/kamailio 
    udp 0 0 127.0.0.1:5060 0.0.0.0:* 30853/kamailio
    raw 0 0 0.0.0.0:255 0.0.0.0:* 7 30853/kamailio
    unix 2 [ ACC ] STREAM LISTENING 2673337 30856/kamailio /var/run/kamailio//kamailio_ctl

Check for /var/log/syslog on possible errors.

Also you can run daemon in foreground
with logging to stderr for debugging purposes::

    # kamailio -eED /etc/kamailio/kamailio.cfg

Extra packages
==============

Invoice PDF generation
----------------------

If you need to generate invoices in PDF format, you have to install additional packages. 
It is accomplished via LibreOffice software, so our package just a wrapper for a LibreOffice installation.

.. warning::
    This operation will install a lot of packages in your system!

::

    # aptitude install yeti-libreoffice-headless

Make sure, that service is enabled for autostart

::

    # systemctl enable yeti-libreoffice-headless

Run it

::

    # systemctl start yeti-libreoffice-headless

