.. :maxdepth: 2

==================================
Upgrading from 1.4 branch to 1.5
==================================

:Site: https://yeti-switch.org/

Upgrade yeti-web package to 1.5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.5.0


Apply migrations
~~~~~~~~~~~~~~~~

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

Switch to new routing schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Switch routing schema  to 'switch14' at /etc/yeti/system.cfg on your yeti-management server and restart yeti-management server

Shutdown, upgrade and start your SEMS nodes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



