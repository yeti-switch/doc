.. :maxdepth: 2


=============================
Routing database installation
=============================

.. note:: We recommend placing routing database on the same host with management WEB interface for best performance and web interface responsiveness.


Supported versions
------------------

The only supported postgresql version is 11.


Packages installation
---------------------

.. code-block:: console

    # apt update && apt install postgresql-11 postgresql-contrib-11 postgresql-11-prefix postgresql-11-pgq3 postgresql-11-pgq-ext postgresql-11-yeti pgqd
       
    
.. warning:: Since  yeti-web version 1.6.0 it is important to install Postgresql from  `PGDG <https://wiki.postgresql.org/wiki/Apt>`_ repository. See :doc:`repositories` for details


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


Don't forget to make changes in /etc/postgresql/11/main/pg_hba.conf
and apply them if you plan to access this databases from other hosts and/or set up database replication

.. seealso:: :doc:`database-tuning`
