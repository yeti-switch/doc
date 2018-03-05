.. :maxdepth: 2

==============================
Обновление с 1.4 до 1.5
==============================

:Site: https://yeti-switch.org/

Обновление пакеты yeti-web до версии 1.5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# apt update
	root@yeti:/# apt install yeti-web=1.5.0


Применение миграций
~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# cd /home/yeti-web
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
	root@yeti:/home/yeti-web# RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate

Перезапуск всех компонентов yeti-web
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

	root@yeti:/# systemctl restart yeti-web
	root@yeti:/# systemctl restart yeti-cdr-billing@cdr_billing
	root@yeti:/# systemctl restart yeti-delayed-job

Переключение на новую схему роутинга
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Переключите схему роутинга на 'switch14' в /etc/yeti/system.cfg - конфигурации сервера yeti-management и перезапустите его

Остановка, обновление и запуск нод SEMS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

