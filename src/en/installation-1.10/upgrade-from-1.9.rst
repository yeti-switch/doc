.. :maxdepth: 2

====================
Upgrade instructions
====================

This instuctions describe how to upgrade Yeti system from version 1.9.9 to version 1.10. If you have any other Yeti version you should previously upgrade it to 1.9.9


Shutdown CDR billing process and other pgq-processor consumers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: console

    # systemctl stop yeti-cdr-billing@cdr_billing
    # systemctl stop yeti-delayed-job
    
    
Upgrade yeti-web package to 1.10.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.10.0
	

Postgresql 11 installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
You should install postgresql-11 packages, as described at  :doc:`routing-database` and :doc:`cdr-database` and create appropriate databases.

 
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

	root@yeti:/# systemctl restart yeti-web
	root@yeti:/# systemctl restart yeti-cdr-billing@cdr_billing
	root@yeti:/# systemctl restart yeti-delayed-job


