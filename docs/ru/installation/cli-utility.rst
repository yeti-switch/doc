.. :maxdepth: 2


=======================================
Установка консольной утилиты управления
=======================================

Системные требования:

- OS Debian 8 Wheezy with amd64 architecture
- Python 2.7

Установка пакетов
---------------------

.. code-block:: console

    # apt update && apt install yeti-cli

Конфигурация
----------------------------------

Для настройки утилиты отредактируйте файл /etc/yeti/yeti-cli.yml

Создайте файл yeti-cli.yml со следующим содержимым:

.. code-block:: yaml

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


Режим командной оболочки
-------------------------
Также, возможно использование yeti-cli как командной оболочки.
Для этого openssh-server должен поддерживать опцию AuthorizedKeysCommand и содержать следующие параметры в sshd_config

.. code-block::yaml

    AuthorizedKeysCommand /usr/sbin/yeti-cli-authentificator
    AuthorizedKeysCommandUser console
    PermitUserEnvironment yes


Перезапустите демон ssh

.. code-block:: console

    # systemctl sshd reload