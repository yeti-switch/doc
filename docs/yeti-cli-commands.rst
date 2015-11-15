.. :maxdepth: 2

========================================
YETI CLI commands
========================================

:Site: https://yeti-switch.org/

Internal commands
-----------------

exit
    exit from console
formatting disable
    disable output autoformattin mode
formatting enable
    enable output autoformattin mode
list
    show node list
use <Node-id>
    switch to node
    
show commands
-------------

show calls
    
show calls <LOCAL-TAG>
    
show calls count
show calls fields
show calls filtered
show calls filtered WHERE
show configuration
show interfaces
show media streams
show registrations
show resource types
show resource state <type>/-1 <id>/-1
show resource state <type>/-1 <id>/-1 used
show router cache
show router cdrwriter opened-files
show sensors
show sessions 
show stats
show system alarms
show system dump-level
show system log-level
show system session-limit
show system status
show version

request commands
----------------

request call disconnect <LOCAL-TAG>
request media payloads
request media payloads benchmark
request registrations reload
request registrations renew
request resolver clear
request resolver get <name>
request resource invalidate
request router cache clear
request router cdrwriter close-files
request router codec-groups reload 
request router reload
request router resources reload
request router translations reload 
request sensors reload
request stats clear
request system log dump
request system shutdown
request system shutdown cancel
request system shutdown graceful
request system shutdown immediate


set commands
------------
set system dump-level signalling
    
set system dump-level rtp
    
set system dump-level full
    
set system dump-level none
    
et system log-level di_log <log_level>
    
set system log-level syslog <log_level>
    
set system session-limit <limit> <overload response code> <overload response reason> 
        


Run command on all nodes
------------------------

Command output filtering
------------------------

You can use | to filter command output