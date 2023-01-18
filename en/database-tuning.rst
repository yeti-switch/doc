.. :maxdepth: 2
.. _database_tuning:

============================
Databases performance tuning
============================

By default Postgresql RDBMS configured to consume minimal system resources. This approach allows Postgresql to start on any server after installation. YETI as well as any other system uses Postgresql requires changing default configuration in order to archive best performance.

We recommends to change next configuration variables at /etc/postgresql/13/yeti/postgresql.conf

.. code-block:: ini

    shared_buffers = 10GB
    work_mem = 8MB
    fsync = on
    checkpoint_timeout = 50min

    
Set **shared_buffers** variable to 1/3 of total RAM installed to server if you share this server with some another application. For example we recommends install yeti-web on same server as routing database. 
If your server is dedicated for postgresql set **shared_buffers** to 2/3 of your RAM.

When configuration changed you should restart your postgresql instance using `service postgresql restart`

.. seealso:: Read Postgresql manual https://www.postgresql.org/docs/13/ to understand postgresql architecture and features




    



