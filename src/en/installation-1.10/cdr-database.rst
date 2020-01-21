.. :maxdepth: 2


==========================
CDR databases installation
==========================

.. note:: System requires two databases: one for routing and one for CDRs. Setting up different PostgreSQL instances is highly recommended to make replication possible.

Packages installation
=====================

CDRs databases require similar set of packages as routing database

.. code-block:: console

    # apt update && apt install postgresql-11 postgresql-contrib-11 postgresql-11-prefix postgresql-11-pgq3 postgresql-11-pgq-ext postgresql-11-yeti postgresql-11-pllua pgqd
    
    
.. warning:: Since  yeti-web version 1.6.0 it is important to install Postgresql from  `PGDG <https://wiki.postgresql.org/wiki/Apt>`_ repository. See :doc:`repositories` for details
  
  

Databases creation
==================

Create routing database

.. code-block:: console

    # su - postgres
    $ psql


.. code-block:: psql

    postgres=# create user cdr encrypted password 'somepassword' superuser; 
    CREATE ROLE 
    postgres=# create database cdr owner cdr; 
    CREATE DATABASE 
    postgres=# \q

.. warning:: It's recommended to choose databases names, usernames and passwords different from specified in this manual for security reasons.

For large installations it's recommended to place CDR database on dedicated server.


PGQd ticker
===========

After initialization of CDR database you should run pgq ticker daemon(**pgqd**) on server with CDR database.

Create configuration file /etc/pgqd.ini 

.. code-block:: ini
    
    [pgqd]
    base_connstr = host=127.0.0.1 port=5432 dbname=cdr user=cdr password=somepassword
    initial_database = cdr
    database_list = cdr
    script = /usr/bin/pgqd
    pidfile = /var/run/postgresql/pgqd.pid
    ticker_max_count=1
    ticker_max_lag=3
    ticker_idle_period=360
    
    
Then you should start ticker:

.. code-block:: console

    # service pgqd start
    
    
Checks
======

Check if databases were successfully created and are accessible:

.. code-block:: psql

    root@cdr-server:/# psql -h 127.0.0.1 -U cdr -d cdr
    Password for user cdr:  psql (9.4.5) SSL connection
    (cipher: DHE-RSA-AES256-GCM-SHA384, bits: 256) 
    Type "help" for help.

    cdr=# \q
    root@cdr-server:/#

Don't forget to make changes in /etc/postgresql/11/main/pg_hba.conf
and apply them if you plan to access this databases from other hosts and/or set up database replication


.. seealso:: :doc:`database-tuning`
