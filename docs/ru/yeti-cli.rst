.. :maxdepth: 2

========================================
Утилита YETI CLI
========================================

:Site: https://yeti-switch.org/

Информация
==========

Консольная утилита yeti-cli обепечивает управление кластером YETI.
Она имеет дружественный к пользователю интерфейс с возможностью дополнения команд клавишей Tab.


Установка
=========

Перед установкой убедитесь, что в вашей операционной системе добавлен следующий репозиторий::

    deb http://pkg.yeti-switch.org/debian wheezy/.

Обновите кэш пакетов и проведите установку

    # apt-get update
    # apt-get install yeti-cli

Конфигурация
============

Файл конфигурации /etc/yeti/yeti-cli.yml содержит следующие данные::

    # cat /etc/yeti/yeti-cli.yml
    nodes_url: 'http://localhost:6666/api/rest/system/nodes.json'
    authentificator_url: 'http://localhost:6666/api/rest/system/admin_users.json?q[ssh_key_present]=1'
    timeout: 5
    default_node: 8
    prompt_system_name: 'YETI'

    
* **nodes_url** - URL для получения списка нод при первом запуске
* **authentificator_url** - URL для получения публичных ключей посредством yeti-cli-authentificator
* **timeout** - время ожидания получения результата
* **default_node** - нода по-умолчанию, к которой необходимо производить подключение при запуске утилиты
* **prompt_system_name** - строка привествия

Вы можете переопределить стандартное расположение файла, указав переменную окружения YETI_CMD_CFG_PATH.

Также, возможно использование yeti-cli как командной оболочки.
Для этого openssh-server должен поддерживать опцию AuthorizedKeysCommand и содержать следующие параметры в sshd_config::

    AuthorizedKeysCommand /usr/sbin/yeti-cli-authentificator
    AuthorizedKeysCommandUser console
    PermitUserEnvironment yes

После настройки следует перезагрузить демон SSH::

    # service ssh reload

Использование
=============
Yeti-cli может быть запущена напрямую из командной оболочки (shell)::

    # yeti-cli
    YETI-CLI version 0.1.3-11
    node changed from empty to 8
    anonymous@YETI:8> 

Также возможно использование yeti-cli как командной оболочки при входе в систему::

    $ ssh console@demo.yeti-switch.org -p 22000
    YETI-CLI version 0.1.3-11
    node changed from empty to 8
    admin@YETI:8>

ВАЖНО! Ваш публичный ключ должен быть добавлен в ваш аккаунт в веб-интерфейсе YETI и sshd должен быть настроен должным образом!
