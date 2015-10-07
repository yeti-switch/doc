Contents:

.. toctree::
   :maxdepth: 2

========================================
YETI CLI utility
========================================

:Site: https://yeti-switch.org/

.. image:: https://yeti-switch.org/img/logo.png

Information
===========

yeti-cli utility gives ability to manage yeti cluster.
It has frendly interface with tab completitions.


Instalation
===========

Make sure that following repository added on your system::

    deb http://pkg.yeti-switch.org/debian wheezy/.

Update package cache and install package

    # apt-get update
    # apt-get install yeti-cli

Configuration
=============

Configuration file is /etc/yeti/yeti-cli.yml::

    # cat /etc/yeti/yeti-cli.yml
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

Also you can configure yeti-cli to work as shell.
You openssh-server must support AuthorizedKeysCommand.
Add next lines to sshd_config::

    AuthorizedKeysCommand /usr/sbin/yeti-cli-authentificator
    AuthorizedKeysCommandUser console
    PermitUserEnvironment yes

Reload ssh daemon 

    # service ssh reload

Usage
=====
You can run yeti-cli directly from shell::

    # yeti-cli
    YETI-CLI version 0.1.3-11
    node changed from empty to 8
    anonymous@YETI:8> 

Also you can use yeti-cli as shell and run it on login::

    $ ssh console@demo.yeti-switch.org -p 22000
    YETI-CLI version 0.1.3-11
    node changed from empty to 8
    admin@YETI:8>

NOTE! you public key must be added to your account in yeti web management interface
and you have to configure sshd. Look in instalation section.
