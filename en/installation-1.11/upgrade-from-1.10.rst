.. :maxdepth: 2

====================
Upgrade instructions
====================

This instuctions describe how to upgrade Yeti system from version 1.10.13 to version 1.11.0. If you have any other Yeti version you should previously upgrade it to 1.10.3


Get know your postgresql cluster epoch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PGQ components of CDR database require cluster epoch increment. To get know your cluster epoch, connect to CDR postgresql database using **psql** and run:

.. code-block:: console

	cdr=# SELECT (txid_current() >> 32) as epoch;
	epoch 
	-------
		0
	(1 row)
    
See https://github.com/markokr/skytools/blob/master/doc/faq.txt#L50 for details


Shutdown CDR billing process and other pgq-processor consumers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: console

    # systemctl stop yeti-cdr-billing@cdr_billing
    # systemctl stop yeti-delayed-job
    
    
Upgrade yeti-web package to 1.11.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.11.0
	

Postgresql 13 installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
You should install postgresql-13 packages, as described at  :doc:`routing-database` and :doc:`cdr-database` and create appropriate databases.


Run new instances of Postgresql(version 13) 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New postgresql instances should run on different ports:

.. code-block:: console

    root@yeti-postgresql-9:~# pg_lsclusters 
    Ver Cluster Port Status Owner    Data directory                  Log file
    11  cdr     5435 online postgres /var/lib/postgresql/9.4/cdr     /var/log/postgresql/postgresql-9.4-cdr.log              <<< OLD CDR database   
    11  routing 5434 online postgres /var/lib/postgresql/9.4/routing /var/log/postgresql/postgresql-9.4-routing.log          <<< OLD routing database
    13  cdr     5437 online postgres /var/lib/postgresql/11/cdr      /var/log/postgresql/postgresql-11-cdr.log               <<< NEW CDR database   
    13  routing 5436 online postgres /var/lib/postgresql/11/routing  /var/log/postgresql/postgresql-11-routing.log           <<< NEW routing database
    
    
Stop CDR writing to old Postgresql CDR instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To stop CDR writing change **listen_address** to '127.0.0.1'(if your CDR db locaated not on same node as SEMS) at postgresql.conf Configuration for old postgresql instances and restart postgresql


Change epoch of new postgresql CDR instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shutdown new postgresql CDR cluster and change epoch:

.. code-block:: console

	# su - postgres
	# /usr/lib/postgresql/13/bin/pg_resetwal -e 1 /var/lib/postgresql/13/cdr
	

Where **1** is increased epoch - it should be greater then epoch of old intance

See https://github.com/markokr/skytools/blob/master/doc/faq.txt#L50 for details

Start new  postgresql CDD instance.


Copy data from old databases to new instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should dump your databases using pg_dump and then restore data to new instances:

.. code-block:: console

    root@yeti-postgresql:~# pg_dump -h 127.0.0.1 -p 5434 -U yeti -O -x -F c -f yeti.dmp yeti
    root@yeti-postgresql:~# pg_restore -h 127.0.0.1 -p 5436 -U yeti -d yeti -e yeti.dmp
    root@yeti-postgresql:~# pg_dump -h 127.0.0.1 -p 5435 -U cdr -O -x -F c -f yeti.dmp yeti
    root@yeti-postgresql:~# pg_restore -h 127.0.0.1 -p 5437 -U cdr -d yeti -e yeti.dmp
    

Shutdown old databases and move new instances to their ports
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Change **port** at postgresql.conf of each postgresql cluster to move new instances to old ports. Restart postgresql.

 
Apply migrations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

        root@yeti:/# cd /opt/yeti-web
        root@yeti:/# su -s /bin/bash yeti-web
        root@yeti:/opt/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
        root@yeti:/opt/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate
        root@yeti:/opt/yeti-web# 
    

Restart all components of yeti-web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# systemctl restart yeti-web yeti-cdr-billing@cdr_billing yeti-delayed-job
	
	
Upgrade SEMS
~~~~~~~~~~~~

Upgrade your SEMS nodes to new version. Configuration files format was changed, See :ref:`sems.conf <sems_conf_1.11>`  for details.




