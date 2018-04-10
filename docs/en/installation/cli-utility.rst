.. :maxdepth: 2


==========================
CLI utility installation
==========================

Server requirements:

- OS Debian 8 or Debian 9 with amd64 architecture
- Python 2.7

Packages installation
---------------------

.. code-block:: console

    # apt update && apt install yeti-cli

Configuration
----------------------------------

To configure yeti-cli parameters edit /etc/yeti/yeti-cli.yml file

Create yeti-cli.yml file with the following content:

.. code-block:: yaml

    nodes_url: 'http://localhost:6666/api/rest/system/nodes.json'
    authentificator_url: 'http://localhost:6666/api/rest/system/admin_users.json?q[ssh_key_present]=1'
    timeout: 5
    default_node: 8
    prompt_system_name: 'YETI'


* **nodes_url** - url for getting nodes list on initial startup
* **authentificator_url** - url for getting public keys via yeti-cli-authentificator
* **timeout** - result waiting timeout
* **default_node** - default node, to which we connect on start
* **prompt_system_name** - Promt string

You can override default config location via enviroment variable YETI_CMD_CFG_PATH

Shell mode
-------------

Also you can configure yeti-cli to work as shell.
You openssh-server must support AuthorizedKeysCommand.
Add next lines to sshd_config

.. code-block::yaml

    AuthorizedKeysCommand /usr/sbin/yeti-cli-authentificator
    AuthorizedKeysCommandUser console
    PermitUserEnvironment yes


Reload ssh daemon 

.. code-block:: console

    # systemctl sshd reload
