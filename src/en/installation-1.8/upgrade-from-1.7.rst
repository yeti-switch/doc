.. :maxdepth: 2

====================
Upgrade instructions
====================

This instuctions describe how to upgrade Yeti system from version 1.7.15 to version 1.8. If you have any other Yeti version you should previously upgrade it to 1.7.15


Upgrade yeti-web package to 1.8.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.8.0
	

Postgresql 11 installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
You should install postgresql-11 packages, see .. and  create appropriate databases

 
Run new instances of Postgresql(version 11) 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

    root@yeti-postgresql-9:~# pg_lsclusters 
    Ver Cluster Port Status Owner    Data directory                  Log file
    9.4 cdr     5435 online postgres /var/lib/postgresql/9.4/cdr     /var/log/postgresql/postgresql-9.4-cdr.log              <<< OLD CDR database   
    9.4 routing 5434 online postgres /var/lib/postgresql/9.4/routing /var/log/postgresql/postgresql-9.4-routing.log          <<< OLD routing database
    11  cdr     5437 online postgres /var/lib/postgresql/11/cdr      /var/log/postgresql/postgresql-11-cdr.log               <<< NEW CDR database   
    11  routing 5436 online postgres /var/lib/postgresql/11/routing  /var/log/postgresql/postgresql-11-routing.log           <<< NEW routing database


Stop CDR writing to old Postgresql CDR instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shutdown CDR billing process and other pgq-processor consumers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Copy data from old databases to new instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shutdown old databases and move new instances to their ports
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Apply first stage of migrations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# cd /home/yeti-web
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate
	....SKIPPED...
	== 20180212105355 MultipleMatchingConditions: migrated (2.0862s) ==============

	IMPORTANT: Now update and restart your servers. And after that run `rake db:migrate` again.
	root@yeti:/home/yeti-web# 
    
Notification ``IMPORTANT: Now update and restart your servers. And after that run `rake db:migrate` again.`` will inform you that migration is not finished. You should apply next part of migrations after SEMS upgrade.


Switch to new routing schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change at /etc/yeti/system.cfg switch routing schema to **switch17** from **switch16** on your yeti-management server and restart yeti-management server


SEMS servers
~~~~~~~~~~~~

Upgrade your SEMS nodes to new version. Configuration files format was changed, See :ref:`sems.conf <sems_conf_1.8>`  for details.



Apply second stage of migrations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# cd /home/yeti-web
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate

    
Restart all components of yeti-web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# systemctl restart yeti-web
	root@yeti:/# systemctl restart yeti-cdr-billing@cdr_billing
	root@yeti:/# systemctl restart yeti-delayed-job


