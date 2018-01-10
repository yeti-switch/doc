.. :maxdepth: 2

==================================
Upgrading from 1.2 branch to 1.4.0
==================================

:Site: https://yeti-switch.org/

Upgrade yeti-web package to 1.2.29
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.2.29

Apply all migrations for version 1.2.29
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

        root@yeti:/# yeti-db apply_all
        root@yeti:/# yeti-db --cdr apply_all

Upgrade yeti-web package to 1.4.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

        root@yeti:/# apt update
        root@yeti:/# apt install yeti-web=1.4.0

Change database.yml to new format
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: yaml

    production: 
      adapter: postgresql
      encoding: unicode
      database: yeti
      pool: 5
      username: yeti
      password: somepassword
      host: 127.0.0.1
      schema_search_path: gui, public, switch, billing, class4, runtime_stats, sys, logs, data_import
      port: 5432
      min_messages: notice
    
    secondbase:
      production: 
        adapter: postgresql
        encoding: unicode
        database: cdr
        pool: 5
        username: yeti
        password: somepassword
        host: 127.0.0.1
        schema_search_path: 'cdr, reports, billing'
        port: 5432
        min_messages: notice

Apply new migrations in new way
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Switch routing schema  to 'switch13' at /etc/yeti/system.cfg on your yeti-management server and restart yeti-management server

Shutdown, upgrade and start your SEMS nodes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



