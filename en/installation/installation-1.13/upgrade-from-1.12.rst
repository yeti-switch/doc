.. :maxdepth: 2

====================
Upgrade instructions
====================

This instructions describe how to upgrade Yeti system from version 1.12 to version 1.13

Reconfigure repositories
------------------------

Before start upgrade you have to reconfigure Debian repositories according to documentation


Upgrade OS
----------

Upgrade Debian GNU/Linux to version 12.


Upgrade Postgresql instances
----------------------------

Upgrade routing and CDR databases instances from Postgresql 13 to Postgresql 16.


Upgrade yeti-web package
------------------------

Upgrade and reconfigure yeti-web:

.. code-block:: console

    root@yeti:/# apt update
    root@yeti:/# apt install yeti-web


Apply database migrations
-------------------------

.. code-block:: console

    root@yeti:/# cd /opt/yeti-web
    root@yeti:/# su -s /bin/bash yeti-web
    root@yeti:/opt/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
    root@yeti:/opt/yeti-web# 
    

Restart all components of yeti-web
----------------------------------

.. code-block:: console

    root@yeti:/# systemctl restart yeti-web yeti-cdr-billing@cdr_billing yeti-cdr-billing@cdr_stats yeti-delayed-job yeti-scheduler

Upgrade SEMS
------------

Upgrade your SEMS nodes to new version. Configuration files format was changed, See :ref:`sems.conf <sems_conf_1.13>`  for details.


