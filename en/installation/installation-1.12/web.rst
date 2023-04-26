.. :maxdepth: 2


==========================
WEB interface installation
==========================

Server requirements:

- amd64 architecture
- Debian 11 Bullseye distibution
- at least 4GB of RAM

Packages installation
---------------------

.. code-block:: console

    # apt update && apt install yeti-web nginx

Databases connection configuration
----------------------------------

To configure databases connection parameters create /opt/yeti-web/config/database.yml file with the following content:

.. code-block:: yaml

    production:
      primary:
        adapter: postgresql
        encoding: unicode
        database: yeti
        username: yeti
        password: somepassword
        host: 127.0.0.1
        port: 5432
        schema_search_path: 'gui, public, switch, billing, class4, runtime_stats, sys, logs, data_import'
        min_messages: notice
        pool: 5
    
      cdr:
        adapter: postgresql
        encoding: unicode
        database: cdr
        username: yeti
        password: somepassword
        host: 127.0.0.1
        port: 5432
        schema_search_path: 'cdr, reports, billing'
        min_messages: notice
        pool: 5
        migrations_paths: db/cdr_migrate

.. warning:: You should specify correct addresses and credentials that were used in previous section

Yeti-web configuration
----------------------

Copy configuration file example **/opt/yeti-web/config/yeti_web.yml.distr** to **/opt/yeti-web/config/yeti_web.yml**


Databases data initialization
-----------------------------

To initialize empty databases during initial installation:

.. code-block:: console

    # cd /opt/yeti-web 
    # su -s /bin/bash yeti-web
    $ RAILS_ENV=production ./bin/bundle.sh exec rake db:schema:load db:migrate
    $ RAILS_ENV=production ./bin/bundle.sh exec rake db:seed
 
    
To upgrade databases to the latest version:

.. code-block:: console

    # cd /opt/yeti-web 
    # su -s /bin/bash yeti-web
    $ RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
    
    
Nginx configuration
-------------------

For basic configuration remove default config and copy yeti-web.dist.nginx:

.. code-block:: console

    # rm /etc/nginx/sites-enabled/default
    # cp /opt/yeti-web/config/yeti-web.dist.nginx /etc/nginx/sites-enabled/yeti
    # nginx -t
    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
    # service nginx restart
    

Launch
------

After successful configuration of databases you finally can run software using following commands:

.. code-block:: console

    # service yeti-web start 
    # service yeti-cdr-billing@cdr_billing start
    # service yeti-delayed-job start
    # service yeti-scheduler start

This will run web-interface, schedulers, background tasks processors and CDR processing workers

Checks
------

check if puma listens on local socket:

.. code-block:: console

    # netstat -lpn | grep puma
    unix  2      [ ACC ]     STREAM     LISTENING     16420    258/puma 5.5.2 (uni  /run/yeti/yeti-unicorn.sock

check if nginx listens on correct TCP/IP addresses and ports:

.. code-block:: console

    # netstat -lpn | grep nginx
    tcp 0 0 0.0.0.0:80 0.0.0.0:* LISTEN 23627/nginx
    tcp 0 0 127.0.0.1:6666 0.0.0.0:* LISTEN 23627/nginx

Log files to check for possible warnings/errors:

- /var/log/yeti/yeti-web.log
- /var/log/yeti/yeti-cdr-billing.log
- /opt/yeti-web/log/puma.stdout.log
- /opt/yeti-web/log/puma.stderr.log

Try to open management interface in your favorite browser and login with default credentials:

:user: admin
:password: 111111


