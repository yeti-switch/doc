.. :maxdepth: 2


==========================
CDR databases installation
==========================

.. note:: System requires two databases: one for routing and one for CDRs. Setting up different PostgreSQL instances is highly recommended to make replication possible.

Packages installation
=====================

CDRs databases require similar set of packages as routing database

::

    # aptitude update && aptitude install postgresql-9.4 postgresql-contrib-9.4 postgresql-9.4-prefix postgresql-9.4-pgq3 postgresql-9.4-yeti skytools3 skytools3-ticker

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


PGQ ticker
==========

After initialization of CDR database you should run skytools pgq ticker daemon on server with CDR database.

Create configuration file /etc/skytools/pgqd.ini 

.. code-block:: ini
    
    [pgqd]
    base_connstr = host=127.0.0.1 port=5432 dbname=cdr user=cdr password=somepassword
    initial_database = cdr
    database_list = cdr
    script = /usr/bin/pgqd
    pidfile = /var/run/skytools/pgqd.pid
    ticker_max_count=1
    ticker_max_lag=3
    ticker_idle_period=360
    
    
Then you should start ticker:

.. code-block:: console

    # service skytools3 start
    
    
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

Don't forget to make changes in /etc/postgresql/9.4/main/pg_hba.conf
and apply them if you plan to access this databases from other hosts and/or set up database replication

