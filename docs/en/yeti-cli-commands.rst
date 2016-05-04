.. :maxdepth: 2

========================================
YETI CLI commands
========================================

:Site: https://yeti-switch.org/

Internal commands
-----------------

exit
    Exit from console
formatting disable
    Disable output autoformattin mode
formatting enable
    Enable output autoformattin mode
list
    Show node list
use <Node-id>
    Switch to node
    
Show commands
-------------

show calls
    Show active calls
show calls <LOCAL-TAG>
    Show call by its <LOCAL-TAG>
show calls count
    Show count of active calls
show calls fields
    Show all existing CDR fields of the system
TODO show calls filtered
    Show calls filtered by the one or more fields. 
    *Example: show calls filtered orig_gw_id src_name_in* 
TODO show calls filtered WHERE
    Отображает список активных звонков с фильтром
show configuration
    Show the system configuration
show interfaces
    Show network interfaces
show media streams
    Show active RTP streams
show radius authorization profiles
    Show radius-authorization profiles
show radius authorization statistic
    Show radius-authorization statistic
show registrations
    Show active registrations on external SIP-registrars
show resource types
    Show types of system resources
show resource state <type>/-1 <id>/-1
    Show state of selected resource <type> for selected entity <id> (Entities such as 'Customer account', 'Customer Auth', 'Dialpeer' etc)
    *Example: show resource state 6 123*
show resource state <type>/-1 <id>/-1 used
    Show usage of selected resource (For debbuging purposes)
show router cache
    Show cache of router-subsystem
show router cdrwriter opened-files
    Show opened files which used by router in order to write CDR
show sensors
    Show sensors of the system which are using to mirror traffic
show sessions 
    Show active sessions
show stats
    Show statistics of the system
show system alarms
    Show system alarms
show system dump-level
    Show system dump-level
show system log-level
    Show system log-level
show system session-limit
    Show system session-limit
show system status
    Show system status
show version
    Show current version of the SEMS


Request commands
----------------

request call disconnect <LOCAL-TAG>
    Disconnect call selected by its <LOCAL-TAG>
request media payloads
    Show value of payload for media-codecs
request media payloads benchmark
    Perform media-codecs benchmark and show results
request radius authorization profiles reload
    Force reloading RADIUS authorization profiles
request registrations reload
    Force reloading registrations on external SIP-registrars
request registrations renew <id>
    Force renew for specific registration by its <id>
request resolver clear
    Clean DNS cache
request resolver get <name>
    Perform DNS-request for specific <name>
    *Example: request resolver get example.com*
request resource invalidate
    Force invalidation for system resources of Yeti-node (For debbuging purposes)
request router cache clear
    Clean router cache
request router cdrwriter close-files
    Close CDR-files used by router
request router codec-groups reload 
    Force reloading router codec-groups
request router reload
    Force reloading router
request router resources reload
    Force reloading of system resource used by router
request router translations reload 
    Force reloading of router translations
request sensors reload
    Force reloading of sensors 
request stats clear
    Clean statistics
request system log dump
    Dump memory-log to file
request system shutdown
    Begin system shutdown process. In this mode Yeti send BYE/CANCEL requests to parties and wait for completion
request system shutdown cancel
    Cancel active shutdown process request
request system shutdown graceful
    Begin system shutdown process. In this mode Yeti wait as long as active calls complete, but reject new calls
request system shutdown immediate
    Begin immediate shutdown proccess. Active calls will be dropped without any messages





Set commands
------------
set system dump-level signalling
    Set system level of call-dump. In this mode signalling data only will be saved
set system dump-level rtp
    Set system level of call-dump. In this mode RTP data only will be saved

set system dump-level full
    Set system level of call-dump. In this mode all data will be saved
    
set system dump-level none
    Disable a call-dump saving
    
set system log-level di_log <log_level>
    Set the level for in-memory log. Where <log_level> might be 0-3 (0-Disable, 1-Error, 2-Warning, 3-Debug)
    
set system log-level syslog <log_level>
    Set the level for syslog log. Where <log_level> might be 0-3 (0-Disable, 1-Error, 2-Warning, 3-Debug)
    
set system session-limit <limit> <overload response code> <overload response reason> 
    Set the maximum amount of sessions
        


Run command on all nodes
------------------------
You can prepend command with word "all" to run it on all nodes


Command output filtering
------------------------
You can use | to filter command output
