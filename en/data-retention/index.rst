
.. _data_retention:

Data retention
~~~~~~~~~~~~~~

Data retention should be configured for heavy loaded production systems. Yeti has built-in tools to remove historical data from databases. Such tools can be configured via **/opt/yeti-web/config/yeti_web.yml** configuration file::

    
    partition_remove_delay:
      cdr.cdr: 120 days
      auth_log.auth_log: 7 days
      rtp_statistics.rx_streams: 3 days
      rtp_statistics.tx_streams: 3 days
      logs.api_requests: 90 days
      

This configuration defines how many historical **partitions** should be saved in database for each table.


Admin WEB interface views :ref:`CDR -> CDR Partitions <cdr_partitions>` and :ref:`Logs -> Log partitions <log_partitions>` allows to see existing partitions in CDRs and Routing databases.
