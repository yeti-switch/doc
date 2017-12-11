.. :maxdepth: 2

=========================
Обновление с 1.2 до 1.4.0
=========================

:Site: https://yeti-switch.org/

Обновите пакет yeti-web до версии 1.2.29
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.2.29

Примените все миграции для версии 1.2.29
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

        root@yeti:/# yeti-db apply_all
        root@yeti:/# yeti-db --cdr apply_all

Обновите пакет yeti-web до версии 1.4.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

        root@yeti:/# apt update
        root@yeti:/# apt install yeti-web=1.4.0

Приведите конфиг database.yml к новому формату
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Примените миграции
~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# cd /home/yeti-web
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate

Перезапустите все компоненты yeti-web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# systemctl restart yeti-web
	root@yeti:/# systemctl restart yeti-cdr-billing@cdr_billing
	root@yeti:/# systemctl restart yeti-delayed-job

Переключитесь на новую схему маршрутизации
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Поменяйте схему маршрутизации на 'switch13' в конфиге /etc/yeti/system.cfg на вашем менеджмент сервере и перезапустите yeti-management процесс

Остановите, обновите и запустите все ваши SEMS ноды
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



