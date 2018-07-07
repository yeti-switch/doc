.. :maxdepth: 2

================================
Upgrading from 1.5 branch to 1.6
================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~
Changelog for version 1.6.3
~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Fix call termination by CallsMonitoring scheduler
- Fix call VAT calculation by CallsMonitoring scheduler
- Fix shared termination gateway processing
- Admin API endpoint for Routing::AreaPrefix backported from master branch
- Destinations/Dialpeers/RoutingTagDetectionRules filtering by routing tag IDs

~~~~~~~~~~~~~~~~~~~~~~~~~~~
Changelog for version 1.6.2
~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Fix writing vendor_id attribute to CDR

~~~~~~~~~~~~~~~~~~~~~~~~~~~
Changelog for version 1.6.1
~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Smallint validation fix
- Database initialisation fix.

~~~~~~~~~~~~~~~~~~~~~~~~~~~
Changelog for version 1.6.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Multiple routing tags can be applied for a call
- Multiple IP,src_prefix and dst_prefix values allowed at same Customer Auth record
- Ability to override Disconnect codes/reasons on capacity overload. See System->Disconnect codes menu
- At CDR database additination PGQ queue **cdr_streaming** was added to allow external system read full CDR
- Yeti writes to CDR external_id fields from Customer Auth, Account, Contractor and Gateway
- **active_admin.yml** was renamed to **yeti_web.yml**
- Ability to change GWT token lifetime via **yeti_web.yml** config variable **api.token_lifetime**
- CI improvements and Nightly packages from master branch
- Support for Debian 9
- Support for Postgresql 10(experimental)
- Multiple Copy action fixes
- Multiple Admin API improvements(pagination, new resources, etc)
- Writing operator name to audit log on data modifications by batch action
- Multiple libraries was updated. CVE-2014-7819, CVE-2017-17718,CVE-2015-1840 fixed
- https://github.com/yeti-switch/yeti-web/issues/150
- https://github.com/yeti-switch/yeti-web/issues/209

~~~~~~~~~~~~~~~~~~~~
Incompatible changes
~~~~~~~~~~~~~~~~~~~~

Since version 1.6.0 Yeti allow mark a call by multiple tags. In previous versions not tagged Destinations and Dialpeers can be used by calls with any tag or without tag. Since version 1.6.0 not tagged Destinations/Dialpeers will be selected only for not tagged calls.


~~~~~~~~~~~~~~~~~
Upgrade procedure
~~~~~~~~~~~~~~~~~

Upgrade your databases
~~~~~~~~~~~~~~~~~~~~~~

You should add PGDG APT repository, See :doc:`installation/repositories` for details. Then you should upgrade your postgresql packages to latest versions and install additional package **postgresql-9.4-pgq-ext**. You have to check that packages:

- postgresql-9.4
- postgresql-9.4-client
- postgresql-contrib-9.4
- postgresql-9.4-prefix
- postgresql-9.4-pgq3

is installed from PGDG repository
and packages:

- postgresql-9.4-pgq-ext
- postgresql-9.4-yeti

is installed from YETI repository. You can check it using command:

.. code-block:: console

        root@yeti-cdr-server:/# apt policy postgresql-9.4 postgresql-9.4-client postgresql-contrib-9.4 postgresql-9.4-prefix postgresql-9.4-pgq3 postgresql-9.4-pgq-ext postgresql-9.4-yeti

Upgrade pgqd on CDR database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should remove packages **skytools3** and **skytools3-ticker** and instead install package **pgqd**. Configure pgqd by changing file **/etc/pgqd.ini**. See :doc:`installation/cdr-database` for details. Kill all previous instances of pgqd and start service:

.. code-block:: console

        root@yeti-cdr-server:/# service pgqd start


Upgrade yeti-web package to 1.6.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.6.0


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

Change at /etc/yeti/system.cfg switch routing schema to **switch15** from **switch14** and **serialize_dynamic_fields = true** instead of **serialize_dynamic_fields = false** on your yeti-management server and restart yeti-management server


SEMS servers
~~~~~~~~~~~~

Upgrade your SEMS nodes to new version


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


