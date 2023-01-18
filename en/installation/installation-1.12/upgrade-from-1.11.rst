.. :maxdepth: 2

.. warning:: This upgrading flow is not complete and may cause system DOWNTIME

====================
Upgrade instructions
====================

This instructions describe how to upgrade Yeti system from version 1.11 to version 1.12


Upgrade yeti-web package
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web
	

Apply migrations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

        root@yeti:/# cd /opt/yeti-web
        root@yeti:/# su -s /bin/bash yeti-web
        root@yeti:/opt/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
        root@yeti:/opt/yeti-web# 
    

Restart all components of yeti-web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# systemctl restart yeti-web yeti-cdr-billing@cdr_billing yeti-delayed-job yeti-scheduler
	
	
Upgrade SEMS
~~~~~~~~~~~~

Upgrade your SEMS nodes to new version. Configuration files format was changed, See :ref:`sems.conf <sems_conf_1.12>`  for details.




