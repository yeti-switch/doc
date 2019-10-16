
============================
CLI utility and RPC commands
============================

Yeti CLI installation
---------------------

.. code-block:: console

    # apt update && apt install yeti-cli

Configuration
-------------

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


* **nodes** - Array of nodes condifurations
* **timeout** - result waiting timeout
* **default_node** - default node, to which we connect on start
* **prompt_system_name** - Promt string

You can override default config location via enviroment variable YETI_CMD_CFG_PATH

Yeti CLI Internal commands
--------------------------

list
    List of configured connections to SEMS nodes.

history
    Displays commands history. **yeti-cli** saves history to **~/.yeticli_history**

use
    Switch connection to specific node. All command will be sent to this node.
    
loadtree
    Loads command tree from SEMS to local cache. yeti-cli use local cache for command autocompleteon

showtree
    Displays content of command tree cache
    

SEMS RPC commands
-----------------

Each SEMS module can expose some command via JSONPRC interface. Use **showtree** command to display actual command list for your SEMS and loaded modules.

core.show.status
    Displays SEMS instance status.
core.show.sessions
    Displays list of all sessions
core.show.sessions.count
    Displays count of sessions
core.show.sessions.limit
    Displays current configuration for session limit. See **session_limit** section of **sems.conf** config file.
core.show.media.streams
    Displays full list of active media streams
core.show.interfaces
    Displays current SEMS interfaces configuration. See **signaling-interfaces** and **media-interfaces** sections of **sems.conf**.
core.show.log-level
    Diplays current log-level for each log destination. Recommended values is 3 for **di_log** and 2 for **syslog**
core.show.connections
    Displays active connections on each SEMS interface.
core.show.version
    Displays SEMS version
core.show.payloads
    Displays current set of supported RTP payloads. This list depends on loaded modules.
core.show.dump-level
    Displays current global dump level.
core.show.recorder.stats
    Displays current audio recording statistics 
core.show.tr_blacklist
    Displays SIP transactions destinations blacklist.

core.set.dump-level.signalling
    Swith SEMS node to global signalling tracing mode. Signalling PCAP trace will be saved for each session independend on Customer Auth dump level parameters.
core.set.dump-level.none
    Disabling any global tracing
core.set.dump-level.full
    Switch SEMS node to full tracing mode. Signalling and RTP trace will be saved for each session independend on Customer Auth dump level parameters.
core.set.dump-level.rtp
    Switch SEMS node to RTP tracing mode. RTP trace will be saved for each session independend on Customer Auth dump level parameters. 
core.set.log-level.di_log
    Allow to modify loglevel for **di_log** destination in runtime, without SEMS restart.
core.set.log-level.syslog
    Allow to modify loglevel for **syslog** destination in runtime, without SEMS restart.
core.set.sessions.limit
    Allow runtime modification of sessions limit
    
core.request.shutdown.cancel
    Cancels SEMS graceful shutdown process. Shutdown mode will be disabled, SEMS will start to accept initial INVITE transactions.
core.request.shutdown.graceful
    Switch SEMS to graceful shutdown mode. In this mode SEMS will respond error for initial INVITE transactions. See **shutdown_mode** section of **sems.conf**
core.request.shutdown.immediate
    Immediately shutdown SEMS instance without stopping SIP sessions.
core.request.shutdown.normal
    Shutdown SEMS instance. All active sessions will be shutted down correctly from SIP protocol point of view.
core.request.log.dump
    Dump internal log ring-buffer to file on disk. 
core.request.resolver.clear
    Clear DNS resolver internal cache.
core.request.resolver.get
    Try to resolve some DNS record

