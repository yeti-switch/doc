.. :maxdepth: 2

.. spelling:word-list::
    postgresql

.. _database_tuning:

=====================
Databases Maintenance
=====================

Yeti switch using two postgresql databases to store routing data and CDRs. This document describes some maintenance procedures.


Performance tuning
==================

By default PostgreSQL RDBMS configured to consume minimal system resources. This approach allows PostgreSQL to start on any server after installation. YETI as well as any other system uses PostgreSQL requires changing default configuration in order to archive best performance.

We recommends to change next configuration variables at ``/etc/postgresql/16/yeti/postgresql.conf``

.. code-block:: ini

    shared_buffers = 10GB
    work_mem = 8MB
    fsync = on
    checkpoint_timeout = 50min

    
Set ``shared_buffers`` variable to 1/3 of total RAM installed to server if you share this server with some another application. For example we recommends install yeti-web on same server as routing database.
If your server is dedicated for PostgreSQL set ``shared_buffers`` to 2/3 of your RAM.

When configuration changed you should restart your PostgreSQL instance using ``service postgresql restart``

.. seealso:: Read PostgreSQL manual https://www.postgresql.org/docs/16/ to understand RDBMS architecture and features



Dump and Restore
================

.. TODO:  Explain why we need it

See https://github.com/markokr/skytools/blob/master/doc/faq.txt#L50 for details

To get know your cluster epoch, connect to database using ``psql`` and run:

.. code-block:: psql

	cdr=# SELECT (txid_current() >> 32) as epoch;
	epoch
	-------
		0
	(1 row)


To change PostgreSQL cluster epoch - shutdown cluster and use ``pg_resetwal`` tool:

.. code-block:: console

	# su - postgres
	$ /usr/lib/postgresql/16/bin/pg_resetwal -e 1 /var/lib/postgresql/16/cdr


Where **1** is new epoch - it should be greater then epoch of old instance
