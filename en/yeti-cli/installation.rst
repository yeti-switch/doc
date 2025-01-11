============
Installation
============

.. code-block:: console

    # apt update && apt install yeti-cli

=============    
Configuration
=============

To configure yeti-cli parameters edit /etc/yeti/yeti-cli.yml file.

.. code-block:: yaml

    nodes:
      - id: local
        rpc_endpoint: 127.0.0.1:7080

    default_node: local

    timeout: 5
    prompt_system_name: 'yeti-cli'
    tree_autoload: True
    tree_clear_on_use: False


* **nodes** - Array of nodes configurations
* **timeout** - result waiting timeout
* **default_node** - default node, to which we connect on start
* **prompt_system_name** - Prompt string

Config path can be overridden via environment variable YETI_CMD_CFG_PATH

Now you can run yeti-cli from shell:

.. code-block:: console

    # root@demo-yeti:/opt/yeti-client/dist# yeti-cli 
    yeti-cli version 2.1.1
    node changed from empty to local
    local completion tree is loaded
    yeti-cli:local> 
