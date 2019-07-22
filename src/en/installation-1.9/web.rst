.. :maxdepth: 2


==========================
WEB interface installation
==========================

Server requirements:

- amd64 architecture
- Debian 9 Stretch distibution
- at least 4GB of RAM

Packages installation
---------------------

.. code-block:: console

    # apt update && apt install yeti-web nginx

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
      schema_search_path: 'gui, public, switch, billing, class4, runtime_stats, sys, logs, data_import'
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
To initialize empty databases:

.. code-block:: console

    # cd /home/yeti-web 
    # su -s /bin/bash yeti-web
    $ RAILS_ENV=production ./bin/bundle.sh exec rake db:structure:load db:migrate
    $ RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:structure:load db:second_base:migrate
    $ RAILS_ENV=production ./bin/bundle.sh exec rake db:seed
 
    
To upgrade databases to the latest version:

.. code-block:: console

    # cd /home/yeti-web 
    # su -s /bin/bash yeti-web
    $ RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
    $ RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate
    
    
Nginx configuration
-------------------

For basic configuration remove default config and copy yeti-web.dist.nginx:

.. code-block:: console

    # rm /etc/nginx/sites-enabled/default
    # cp /home/yeti-web/config/yeti-web.dist.nginx /etc/nginx/sites-enabled/yeti
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

This will run web-interface and CDR processing workers

Checks
------

check if unicorn listens on local socket:

.. code-block:: console

    # netstat -lpn | grep unicorn
    unix 2 [ ACC ] STREAM LISTENING 2535145 24728/unicorn.rb -E /tmp/yeti-unicorn.sock

check if nginx listens on correct TCP/IP addresses and ports:

.. code-block:: console

    # netstat -lpn | grep nginx
    tcp 0 0 0.0.0.0:80 0.0.0.0:* LISTEN 23627/nginx
    tcp 0 0 127.0.0.1:6666 0.0.0.0:* LISTEN 23627/nginx

Log files to check for possible warnings/errors:

- /var/log/yeti-admin.log
- /var/log/yeti-cdr-billing.log
- /home/yeti-web/log/unicorn.stdout.log
- /home/yeti-web/log/unicorn.stderr.log

Try to open management interface in your favorite browser and login with default credentials:

:user: admin
:password: 111111


Invoice PDF generation
----------------------

If you need to generate invoices in PDF format, you have to install additional packages. 
It is accomplished via LibreOffice software, so our package just a wrapper for a LibreOffice installation.

.. warning::
    This operation will install a lot of packages in your system!

.. code-block:: console

    # apt install yeti-libreoffice-headless

Make sure, that service is enabled for autostart

.. code-block:: console

    # systemctl enable yeti-libreoffice-headless

Run it

.. code-block:: console

    # systemctl start yeti-libreoffice-headless


LDAP Authentication
-------------------
Yeti's web-interface may use LDAP in order to authnticate users.

Copy configuration from example file

.. code-block:: console

    # cp /home/yeti-web/config/ldap.yml.dist /home/yeti-web/config/ldap.yml

and edit it

.. code-block:: console

    production:
      host: yeti-host.com
      port: 389 
      ssl: false
      attribute: uid
      base: ou=employees,dc=yeti,dc=com
      group_base: ou=groups,dc=yeti,dc=com
      required_groups:
        - ["member", "cn=yeti,ou=groups,dc=yeti,dc=com"]
    
* **host** - address of LDAP server
* **port** - port of LDAP server
* **ssl** - enable/disable SSL
* **attribute** - name of attribute which contains user login
* **base** - base DN where YETI will try find users
* **group_base** - base DN where YETI will try find groups
* **required_groups** - array of groups where user must present
* **member** - attribute where group stored
* **cn=yeti,ou=groups,dc=yeti,dc=com** - group


After editing file, restart YETI web interface

.. code-block:: console

    # systemctl restart yeti-web

