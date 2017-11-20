.. :maxdepth: 2


==========================================
Инструкция по установке YETI в ОС Debian 8
==========================================



Обзор
=====

Минимальная конфигурация платформы состоит из следующих компонентов:

- База данных роутинга (postgresql-9.4)
  смотри `Установка базы данных`_

- База данных записей звонков CDR(postgresql-9.4)
  смотри `Установка базы данных`_

- Управляющий интерфейс (web-интерфейс написанный на RoR)
  смотри `Установка управляющего интерфейса`_

- Хранилище DSS (Redis)
  смотри `Установка хранилища DSS`_

- Управляющий сервер (сервер управления конфигурацией)
  смотри `Установка управляющего сервера`_

- Маршрутизатор трафика (SBC основанный на SEMS)
  смотри `Установка сервера маршрутизации трафика`_

- Балансировщик нагрузки (kamailio)
  смотри `Установка сервера балансировки нагрузки`_
  
  
Конфигурация репозиториев
=========================

Все серверы должны иметь одинаковый набор репозиториев::

    deb http://ftp.us.debian.org/debian/ jessie main contrib non-free
    deb http://ftp.us.debian.org/debian/ jessie-updates main
    deb http://security.debian.org/ jessie/updates main
    deb http://pkg.yeti-switch.org/debian/jessie stable main ext
    

Системные репозиторие могут быть изменены, путём правки файла: /etc/apt/sources.list

Установка ключа репозитория

.. code-block:: console

	root@evial:/# apt-key adv --keyserver keys.gnupg.net --recv-key 9CEBFFC569A832B6

Установка базы данных
=====================

Платформа требует двух баз данных: одну для роутинга и вторую для хранения записей звонков (CDR). Установка дополнительных нод PostgreSQL для обеспечения репликации
данных крайне рекомендуется.

Мы советуем размещать базу данных роутинга на том же узле, на котором установлен `Управляющий сервер` для снижения сетевых задержек и обеспечения максимальной
эффективности работы `Управляющего интерфейса`


Установка пакетов
-----------------

Обе базы данных - и роутинга и CDR требуют установки одинакового набора пакетов

::

    # aptitude update && aptitude install postgresql-9.4 postgresql-contrib-9.4 postgresql-9.4-prefix postgresql-9.4-pgq3 postgresql-9.4-yeti skytools3 skytools3-ticker

Создание баз данных
-------------------

Создание базы данных роутинга

.. code-block:: console

    # su - postgres
    $ psql


.. code-block:: psql

    postgres=# create user yeti encrypted password 'somepassword' superuser; 
    CREATE ROLE 
    postgres=# create database yeti owner yeti; 
    CREATE DATABASE 
    postgres=# \q

Создание базы данных для хранения CDR::

    # su - postgres
    $ psql
    postgres=# create database cdr owner yeti;
    CREATE DATABASE
    postgres=# \q

.. warning:: В целях безопасности рекомендуем выбирать иные названия баз данных, логины и пароли

Для больших инсталляций, рекомендуется устанавливать базу данных для хранения CDR на отдельный сервер


Проверки
--------

Проверим, что базы данных были успешно созданы и доступны для подключения::

    root@evial:/# psql -h 127.0.0.1 -U yeti -d yeti
    Password for user yeti:  psql (9.4.5) SSL connection
    (cipher: DHE-RSA-AES256-GCM-SHA384, bits: 256) 
    Type "help" for help.

    yeti=# \q
    root@evial:/#

    root@evial:/# psql -h 127.0.0.1 -U yeti -d cdr
    Password for user yeti: 
    psql (9.4.5) 
    SSL connection (cipher: DHE-RSA-AES256-GCM-SHA384, bits: 256) 
    Type "help" for help.

    cdr=# \q 
    root@evial:/#

Не забудьте внести изменения в файл /etc/postgresql/9.4/main/pg_hba.conf для получения доступа к 
базам данных с внешних серверов и/или настройки репликации данных


Создание схемы и инициализация базы данных
------------------------------------------

Обратитесь к `Настройка подключения к базам данных`_ и `Инициализация баз данных`_ для получения дальнейших инструкций


Установка управляющего интерфейса
=================================

Системные требования:

- ОС Debian 8 Wheezy с архитектурой amd64
- по крайней мере 1GB of RAM

Установка пакетов
-----------------

::

    # aptitude update && aptitude install yeti-web nginx

Настройка подключения к базам данных
------------------------------------

Отредактируйте файл /home/yeti-web/config/database.yml для настройки параметров соединения 
с базами данных (При необходимости создайте его)

Данный файл должен иметь следующее содержимое:

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


.. warning::  Вы должны использовать корректные адреса и данные авторизации, которые были использованы в предыдущих секциях


Инициализация баз данных
------------------------

Для упрощения работы с базами данных: инициализации и установки обновлений, используйте утилиту yeti-db

Для инициализации пустой базы данных::

    # cd /home/yeti-web 
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:create db:structure:load db:migrate
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:create db:second_base:structure:load db:second_base:migrate
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:seed

Для обновления до последней версии базы данных::

    # cd /home/yeti-web 
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:migrate
    # RAILS_ENV=production ./bin/bundle.sh exec rake db:second_base:migrate


Конфигурирование NGINX
----------------------

Для минимальной конфигурации достаточно удалить дефолную конфигурацию nginx и скопировать пример конфига::

    # rm /etc/nginx/sites-enabled/default
    # cp /home/yeti-web/config/yeti-web.dist.nginx /etc/nginx/sites-enabled/yeti
    # nginx -t
    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
    # service nginx restart
    

Запуск
------

После успешной конфигурации баз данных, вы наконец-то можее запустить программное обеспечение,
используя следующие команды::

    # service yeti-web start 
    # service yeti-cdr-billing@cdr_billing start
    # service yeti-delayed-job start

Эти команды запустят веб-интерфейс и обработчики CDR


Проверки
--------

убедитесь, что unicorn прослушивает локальный сокет::

    # netstat -lpn | grep unicorn
    unix 2 [ ACC ] STREAM LISTENING 2535145 24728/unicorn.rb -E /tmp/yeti-unicorn.sock

убедитесь, что Nginx запущен и прослушивает корректные TCP/IP адреса и порты::

    # netstat -lpn | grep nginx
    tcp 0 0 0.0.0.0:80 0.0.0.0:* LISTEN 23627/nginx
    tcp 0 0 127.0.0.1:6666 0.0.0.0:* LISTEN 23627/nginx

проверьте следующие лог-файлы и убедитесь, что они не содержат предупреждений или ошибок::

- /var/log/yeti-admin.log
- /var/log/yeti-cdr-billing.log
- /home/yeti-web/log/unicorn.stdout.log
- /home/yeti-web/log/unicorn.stderr.log

Попытайтесь открыть веб-страницу управляющего интерфейса в вашем любимом браузере. 
Для входа в систему используются следующие данные авторизации по-умолчанию:

:user: admin
:password: 111111


Установка хранилища DSS
=======================

Redis используется для синхронизации данных между серверами маршрутизации трафика.
Он содержит информацию об использованных ресурсах (лимитах ёмкости гейтвеев) для
обеспечения корректных ограничений среди всех нод в случае распределеной инсталляции

Установка пакетов
-----------------

::

    # aptitude install redis-server

Проверки
--------

Попытайтесь запустить консоль Redis на сервере, где производилась установка::

    # redis-cli
    127.0.0.1:6379> ping
    PONG
    127.0.0.1:6379> quit


Установка управляющего сервера
==============================

Начиная с версии 1.6.3-175 мы начали использовать централизованный сервер
конфигураций, для хранения конфигурации модуля yeti для всех нод в кластере

Установка пакетов
-----------------

::

    # aptitude install yeti-management

Файлы конфигурации
------------------

/etc/yeti/management.cfg
~~~~~~~~~~~~~~~~~~~~~~~~

Данный файл содержит конфигурацию системного демона управляющего сервера.
Установите желаемые уровень логгировани и сетевой адрес, который будет 
прослушиваться данным демоном.

Вы можете назначить несколько сетевых адресов для прослушивания, разделяя их запятыми.

Возможные значения для параметра log_level: (1 - error, 2 - info, 3 - debug)

.. code-block:: c

    daemon {
      listen = {
        "tcp://0.0.0.0:4444"
      }
      log_level = 2
    }

/etc/yeti/system.cfg
~~~~~~~~~~~~~~~~~~~~

Данный файл содержит конфигурацию для всех нод кластера. Каждая секция
верхнего уровня определяет конфигурацию для ноды определенного типа
(секция signaling предназначена для серверов маршрутизации трафика).
Все секции верхнего уровня должны содержать секцию globals, которая
должна содержать все необходимые параметр, общие для всех нод.
Кроме того, в именных секциях для каждого node_id можно указать параметры, 
которые переопределят содержимое параметров в секции globals

Примечание:  Даже если ноды не содержат специфических настроек, вы должны 
указать пустые именные секции для каждой ноды кластера. В противном случае,
управляющей сервер не будет предоствлять им конфигурацию для загрузки

Пример минимального конфигурационного файла, для ноды с id=0::

    signalling {
      globals {
        yeti {
          pop_id = 2
          msg_logger_dir = /var/spool/sems/dump
          log_dir = /var/spool/sems/logdump
          routing {
            schema = switch13
            function = route_release
            init = init
            master_pool {
              host = 127.0.0.1
              port = 5432
              name = yeti
              user = yeti
              pass = yeti
              size = 4
              check_interval = 10
              max_exceptions = 0
              statement_timeout=3000
            }
            failover_to_slave = false
            slave_pool {
              host = 127.0.0.1
              port = 5432
              name = yeti
              user = yeti
              pass = yeti
              size = 4
              check_interval = 10
              max_exceptions = 0
              statement_timeout=3000
            }
            cache {
              enabled = false
              check_interval = 60
              buckets = 100000
            }
          }
          cdr {
           dir = /var/spool/sems/cdrs
           completed_dir = /var/spool/sems/cdrs/completed
           pool_size = 2
           schema = switch
           function = writecdr
           master {
             host = 127.0.0.1
             port = 5433
             name = cdr
             user = cdr
             pass = cdr
          }
           failover_to_slave = false
           slave {
             host = 127.0.0.1
             port = 5433
             name = cdr
             user = cdr
             pass = cdr
           }
           failover_requeue = true
           failover_to_file = false
           serialize_dynamic_fields = false
         }
         resources {
           reject_on_error = false
           write {
             host = 127.0.0.1
             port = 6379
             size = 2
             timeout = 500
           }
           read {
             host = 127.0.0.1
             port = 6379
             size = 2
             timeout = 1000
           }
         }
         registrations {
           check_interval = 5000
         }
         rpc {
           calls_show_limit = 1000
         }
       }
      }
      node 0 { }
    } 

Запуск управляющего сервера
---------------------------

Для запуска демона управляющего сервера используйте команду::

    # service yeti-management start

Проверки
--------


После запуска, проверьте файл /var/log/yeti/yeti-management.log::

    # tail -2 /var/log/yeti/yeti-management.log
    Sep 12 12:54:47 evial yeti-management[25376]: [25376] 
      info: server/src/yeti_mgmt_server.cpp:148: starting version 1.0.5
    Sep 12 12:54:47 evial yeti-management[25376]: [25376]
      info: server/src/mgmt_server.cpp:123: listen on tcp://0.0.0.0:4444

Проверьте, прослушивает демон указанный порт::

    # netstat -lpn | grep yeti_management
    4444 tcp 0 0 0.0.0.0:4444 0.0.0.0:* LISTEN 25376/yeti_management


Установка сервера маршрутизации трафика
=======================================

Установка пакетов
-----------------

::

    # aptitude install sems sems-modules-yeti
    
Файлы конфигурации
------------------

/etc/sems/sems.conf
~~~~~~~~~~~~~~~~~~~

Замените <SIGNALLING_IP>, <MEDIA_IP> подходящими значениями для вашего сервера::

    interfaces=intern
    sip_ip_intern=<SIGNALLING_IP> 
    sip_port_intern=5061 
    media_ip_intern=<MEDIA_IP> 
    rtp_low_port_intern=20000 
    rtp_high_port_intern=50000
    plugin_path=/usr/lib/sems/plug-in/ 
    load_plugins=wav;ilbc;speex;gsm;adpcm;l16;g722;yeti;session_timer;uac_auth;di_log;registrar_client;jsonrpc
    application = yeti
    plugin_config_path=/etc/sems/etc/
    fork=yes
    stderr=no
    syslog_loglevel=2
    max_shutdown_time = 10

    session_processor_threads=20
    media_processor_threads=2
    session_limit="4000;509;Node overloaded"
    shutdown_mode_reply="508 Node in shutdown mode"
    options_session_limit="900;503;Warning, server soon overloaded"
    # cps_limit="100;503;Server overload"
    use_raw_sockets=yes 
    sip_timer_B = 8000 
    default_bl_ttl=0
    registrations_enabled=no

/etc/sems/etc/yeti.conf
~~~~~~~~~~~~~~~~~~~~~~~

Перед редактированием данного файла, добавьте ноду в базу данных роутинга
через упраляющий веб-интерфейс [ System -> Nodes -> New Node ]
Затем, используйте id созданной ноды в качестве значения для параметра **node_id**

node_id
    уникальный id ноды сигнализации
cfg_timeout
    таймаут ожидания ответа от управляющей ноды
cfg_urls
    список адресов управляющих нод, разделенный запятыми
cfg_url_<name>
    адрес управляющей ноды для получения конфигурации ([sub:/etc/yeti/management.cfg])

::

    node_id = <id созданной ноды>
    
    cfg_timeout = 1000
    
    cfg_urls = main
    cfg_url_main = tcp://127.0.0.1:4444
    core_options_handling=yes
    

Прочие конфигурационные файлы
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Скопируйте содержимое стандартных файлов конфигурации, а затем
отредактируйте их по своему усмотрению::

    # mv /etc/sems/etc/jsonrpc.conf.dist /etc/sems/etc/jsonrpc.conf

В данном файле измените адрес, который будет прослушивать нода, если вы планируете установку
в режиме кластера

Запуск сервера маршрутизации трафика
------------------------------------

Для запуска настроенного демона маршрутизации трафика выполните команду::

    # service sems start

В случае возникновения ошибок при запуске, вы можете запустить 
демон в режиме дебага и проверить вывод в консоль на предмет ошибок.
Для этого используйте команду **sems -E -D3** 

Проверки
--------

Убедитесь, что процесс **sems** запущен и необходимые сокеты
сигнализация/медиа/rpc открыты::

    # pgrep sems
    29749
    # netstat -lpn | grep sems
    tcp 0    0 127.0.0.1:8090 0.0.0.0:*  LISTEN 29749/sems
    udp 0    0 127.0.0.1:5061 0.0.0.0:*         29749/sems
    raw 2688 0 0.0.0.0:17     0.0.0.0:*  7      29749/sems

Проверьте лог-файл /var/log/sems/sems-main.log  на наличие ошибок


Установка сервера балансировки нагрузки
=======================================

Установка пакетов
-----------------

::

    # aptitude install yeti-lb
    
Примечание:  На этапе установки, вам будет предложено указать адрес, на котором прослушивает демон
маршрутизации трафика, а также адрес и порт для прослушивания самим балансировщиком

После установки вы сможете изменить параметры по своему усмотрению, отредактировав файлы::

/etc/kamailio/dispatcher.list
/etc/kamailio/lb.conf

Запуск
------

Запуск демона балансировщика::

    # service kamailio start

Проверки
--------

Убедитесь, что процесс **kamailio** запущен и прослушивает следующие ноды::

    # pgrep kamailio
    30853
    30854
    30855
    30856
    30857
    # netstat -lpn | grep kamailio
    tcp 0 0 127.0.0.1:5060 0.0.0.0:* LISTEN 30857/kamailio 
    udp 0 0 127.0.0.1:5060 0.0.0.0:* 30853/kamailio
    raw 0 0 0.0.0.0:255 0.0.0.0:* 7 30853/kamailio
    unix 2 [ ACC ] STREAM LISTENING 2673337 30856/kamailio /var/run/kamailio//kamailio_ctl

Проверьте лог-файл /var/log/syslog на наличие ошибок

Также, вы можете запустить демон в режиме дебага, для контроля его запуска::

    # kamailio -eED /etc/kamailio/kamailio.cfg

Дополнительные пакеты
=====================

Генерация PDF для счетов
------------------------

Если вы хотите генерировать счета в формате PDF, то для этого необходимо установить дополнительные пакеты.
Данная операция выполноется при помощи пакета LibreOffice software и наш пакет является лишь оберткой для его установки.

.. warning::
    Данная операция установит множество дополнительных пакето в вашу систему!

::

    # aptitude install yeti-libreoffice-headless

Убедитесь, что данный сервис активирован для автозагрузки

::

    # systemctl enable yeti-libreoffice-headless

Запустите сервис

::

    # systemctl start yeti-libreoffice-headless

