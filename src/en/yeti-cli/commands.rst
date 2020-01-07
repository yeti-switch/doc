========
Commands
========


Internal commands
-----------------

Internal command will not change system status and just change **yeti-cli** behavior.

list
    List of configured connections to SEMS nodes.

history
    Displays commands history. **yeti-cli** saves history to **~/.yeticli_history**

use <node-id>
    Switch connection to specific node. All command will be sent to this node.
    
loadtree
    Loads command tree from SEMS to local cache. yeti-cli use local cache for command autocompleteon

showtree
    Displays content of command tree cache

formatting disable
    Disable output autoformatting mode

formatting enable
    Enable output autoformatting mode

exit
    Exit from console





Core commands
-------------

Core commands provided by SEMS core and usually related to whole SEMS daemon.

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

    
    
YETI module commands
--------------------

yeti.show.calls [LOCAL-TAG]
    Show active calls
yeti.show.calls.count
    Show count of active calls
yeti.show.radius.authorization.profiles
    Show radius-authorization profiles
yeti.show.radius.authorization.statistic
    Show radius-authorization statistic
yeti.show.registrations
    Show active outgoing registrations send by YETI on external SIP-registrars
yeti.show.resource.types
    Show types of system resources
yeti.show.resource.state <type>/-1 <id>/-1
    Show state of selected resource <type> for selected entity <id> (Entities such as 'Customer account', 'Customer Auth', 'Dialpeer' etc)
    *Example: show resource state 6 123*
yeti.show.resource.state <type>/-1 <id>/-1 used
    Show usage of selected resource (For debbuging purposes)
yeti.show.router.cdrwriter.opened-files
    Show opened files which used by router in order to write CDR
yeti.show sensors
    Show sensors of the system which are using to mirror traffic
yeti.show.stats
    Show statistics of the system
yeti.show.system.alarms
    Show system alarms
yeti.show.system status
    Show system status
yeti.show.version
    Show current version of YETI module and SEMS core
yeti.request.call disconnect <LOCAL-TAG>
    Disconnect call selected by its <LOCAL-TAG>

.. warning:: Not all commands described in this documentation. Use **loadtree/showtree** internal commands to display actual command list for your SEMS and loaded modules.
    
Run command on all nodes
------------------------
You can prepend command with word "all" to run it on all nodes


Command output filtering
------------------------
You can use | to filter command output
