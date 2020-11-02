
.. _data_retention:

Data retention
~~~~~~~~~~~~~~

Data retention should be configured for heavy loaded production systems. Yeti has built-in tools to remove historical data from databases. Such tools can be configured via **/opt/yeti-web/config/yeti_web.yml** configuration file::

    
    partition_remove_delay:
      cdr.cdr: 120
      auth_log.auth_log: 7
      rtp_statistics.streams: 3
      logs.api_requests: 90

This configuration defines how many historical **partitions** should be saved in database for each table.

.. warning:: **cdr.cdr** table partitioned by months. So partition_remove_delay=120 means "save data for 120 months". All other tables are using per day partitioning.

Admin WEB interface views :ref:`CDR -> CDR Partitions <cdr_partitions>` and :ref:`Logs -> Log partitions <log_partitions>` allows to see currently exists partitions in CDRs and Routing databases.
