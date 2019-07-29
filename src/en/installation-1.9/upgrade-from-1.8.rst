.. :maxdepth: 2

====================
Upgrade instructions
====================

This instuctions describe how to upgrade Yeti system from version 1.8.8 to version 1.9. If you have any other Yeti version you should previously upgrade it to 1.8.8


Shutdown CDR billing process and other pgq-processor consumers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: console

    # systemctl stop yeti-cdr-billing@cdr_billing
    # systemctl stop yeti-delayed-job
    
    

Upgrade yeti-web package to 1.9.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.9.0
	

Postgresql 11 installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
You should install postgresql-11 packages, as described at  :doc:`routing-database` and :doc:`cdr-database` and create appropriate databases.

 
 
Apply migrations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# cd /home/yeti-web
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate
	root@yeti:/home/yeti-web# 
    

Restart all components of yeti-web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# systemctl restart yeti-web
	root@yeti:/# systemctl restart yeti-cdr-billing@cdr_billing
	root@yeti:/# systemctl restart yeti-delayed-job


	
Switch to new routing schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change at /etc/yeti/system.cfg switch routing schema to **switch18** from **switch17** on your yeti-management server::

    signalling {
        globals {
            yeti {
                pop_id = 4
                msg_logger_dir = /var/spool/sems/dump
                log_dir = /var/spool/sems/logdump
                routing {
                    schema = switch18
    ...


Restart yeti-management service to apply changes


SEMS servers
~~~~~~~~~~~~

Upgrade your SEMS nodes to new version. Configuration files format was changed, See :ref:`sems.conf <sems_conf_1.9>`  for details.



