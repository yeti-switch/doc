.. :maxdepth: 2

.. spelling:word-list::
    postgresql

.. _database_tuning:

============================
Databases performance tuning
============================

By default PostgreSQL RDBMS configured to consume minimal system resources. This approach allows PostgreSQL to start on any server after installation. YETI as well as any other system uses PostgreSQL requires changing default configuration in order to archive best performance.

We recommends to change next configuration variables at /etc/postgresql/16/yeti/postgresql.conf

.. code-block:: ini

    shared_buffers = 10GB
    work_mem = 8MB
    fsync = on
    checkpoint_timeout = 50min

    
Set **shared_buffers** variable to 1/3 of total RAM installed to server if you share this server with some another application. For example we recommends install yeti-web on same server as routing database. 
If your server is dedicated for PostgreSQL set **shared_buffers** to 2/3 of your RAM.

When configuration changed you should restart your PostgreSQL instance using `service postgresql restart`

.. seealso:: Read PostgreSQL manual https://www.postgresql.org/docs/16/ to understand RDBMS architecture and features




    



