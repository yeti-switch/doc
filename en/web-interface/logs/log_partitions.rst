
.. _log_partitions:

Log Partitions
~~~~~~~~~~~~~~

Yeti widely uses `Postgresql partitioning mechanism <https://www.postgresql.org/docs/current/ddl-partitioning.html>`_ for tables contains time series data like :ref:`CDR History <cdr_history>`, :ref:`Auth logs <cdr_auth_logs>`, :ref:`RTP Statistics <rtp_statistics>` and :ref:`API Logs <api_logs>`

Log Partitions view allow to see details for partitioned tables in Routing database

**Fields**:
```````````
    Name
        Partition name. Usually partition name contains date in some format
    Parent table
        Name of Parent table
    Date From/Date To
        Describes time interval allowed for this partition
    Size
        Size of partition without indexes
    Total Size
        Size of partition with indexes
    Approximate Row Count
        Row count estimation based on internal PostgreSQL statistics
