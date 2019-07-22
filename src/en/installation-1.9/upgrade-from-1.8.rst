.. :maxdepth: 2

====================
Upgrade instructions
====================

This instuctions describe how to upgrade Yeti system from version 1.8.8 to version 1.9. If you have any other Yeti version you should previously upgrade it to 1.8.8


Upgrade yeti-web package to 1.9.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.9.0
	

Postgresql 11 installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
You should install postgresql-11 packages, as described at  :doc:`routing-database` and :doc:`cdr-database` and create appropriate databases.

 
Run new instances of Postgresql(version 11) 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New postgresql instances should run on different ports:

.. code-block:: console

    root@yeti-postgresql-9:~# pg_lsclusters 
    Ver Cluster Port Status Owner    Data directory                  Log file
    9.4 cdr     5435 online postgres /var/lib/postgresql/9.4/cdr     /var/log/postgresql/postgresql-9.4-cdr.log              <<< OLD CDR database   
    9.4 routing 5434 online postgres /var/lib/postgresql/9.4/routing /var/log/postgresql/postgresql-9.4-routing.log          <<< OLD routing database
    11  cdr     5437 online postgres /var/lib/postgresql/11/cdr      /var/log/postgresql/postgresql-11-cdr.log               <<< NEW CDR database   
    11  routing 5436 online postgres /var/lib/postgresql/11/routing  /var/log/postgresql/postgresql-11-routing.log           <<< NEW routing database


    
Shutdown CDR billing process and other pgq-processor consumers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: console

    # systemctl stop yeti-cdr-billing@cdr_billing
    # systemctl stop yeti-delayed-job
    
    
Stop CDR writing to old Postgresql CDR instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To stop CDR writing change **listen_address** to '127.0.0.1' at postgresql.conf Configuration for old postgresql instances and restart postgresql


Copy data from old databases to new instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should dump your databases using pg_dump and then restore data to new instances:

.. code-block:: console

    root@yeti-postgresql-9:~# pg_dump -h 127.0.0.1 -p 5434 -U yeti -O -x -F c -f yeti.dmp yeti
    root@yeti-postgresql-9:~# pg_restore -h 127.0.0.1 -p 5436 -U yeti -d yeti -e yeti.dmp
    root@yeti-postgresql-9:~# pg_dump -h 127.0.0.1 -p 5435 -U cdr -O -x -F c -f yeti.dmp yeti
    root@yeti-postgresql-9:~# pg_restore -h 127.0.0.1 -p 5437 -U cdr -d yeti -e yeti.dmp
    

Shutdown old databases and move new instances to their ports
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Change **port** at postgresql.conf of each postgresql cluster to move new instances to old ports. Restart postgresql.


Apply first stage of migrations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# cd /home/yeti-web
	root@yeti:/# su -s /bin/bash yeti-web
	yeti-web@demo-yeti:~$ RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
	yeti-web@demo-yeti:~$ RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate
	....SKIPPED...
	== 20180212105355 MultipleMatchingConditions: migrated (2.0862s) ==============

	IMPORTANT: Now update and restart your servers. And after that run `rake db:migrate` again.
	root@yeti:/home/yeti-web# 
    
    
Restart all components of yeti-web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# systemctl restart yeti-web
	root@yeti:/# systemctl restart yeti-cdr-billing@cdr_billing
	root@yeti:/# systemctl restart yeti-delayed-job


	
Switch to new routing schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change at /etc/yeti/system.cfg switch routing schema to **switch17** from **switch16** on your yeti-management server and restart yeti-management server


SEMS servers
~~~~~~~~~~~~

Upgrade your SEMS nodes to new version. Configuration files format was changed, See :ref:`sems.conf <sems_conf_1.8>`  for details.



