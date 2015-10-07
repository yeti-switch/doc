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

Yeti cli utility manual.


Instalation
===========

Make sure that following repository added on your system::

    deb http://pkg.yeti-switch.org/debian wheezy/.

Update package cache and install package

    apt-get update
    apt-get install yeti-cli

Configuration
=============

Configuration file is /etc/yeti/yeti-cli.yml::

    cat /etc/yeti/yeti-cli.yml

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
