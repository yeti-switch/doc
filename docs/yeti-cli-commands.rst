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
    
Show commands
-------------

show calls
    Отображает список активных звонков
show calls <LOCAL-TAG>
    Отображает детали одного активного звонка с соответствующим local_tag
show calls count
    Отображает количество активных звонков
show calls fields
    Отображает поля звонка для данной системы
show calls filtered
    Отображает список активных звонков с выводом только запрошенных полей
show calls filtered WHERE
    Отображает список активных звонков с фильтром
show configuration
    Вывод текущей конфигурации
show interfaces
    Вывод конфигурации сетевых интерфейсов и режимов их работы
show media streams
    Вывод активных RTP потоков
show radius authorization profiles
    показывает загруженные профайлы
show radius authorization statistic
    показывает статистику
show registrations
    none
show resource types
    none
show resource state <type>/-1 <id>/-1
    none
show resource state <type>/-1 <id>/-1 used
    none
show router cache
    none
show router cdrwriter opened-files
    none
show sensors
    none
show sessions 
    none
show stats
    none
show system alarms
    none
show system dump-level
    none
show system log-level
    none
show system session-limit
    none
show system status
    none
show version
    none


Request commands
----------------

request call disconnect <LOCAL-TAG>
    none
request media payloads
    none
request media payloads benchmark
    none
request radius authorization profiles reload
    force reloading RADIUS authorization profiles
request registrations reload
    none
request registrations renew
    none
request resolver clear
    none
request resolver get <name>
    none
request resource invalidate
    none
request router cache clear
    none
request router cdrwriter close-files
    none
request router codec-groups reload 
    none
request router reload
    none
request router resources reload
    none
request router translations reload 
    none
request sensors reload
    none
request stats clear
    none
request system log dump
    none
request system shutdown
    none
request system shutdown cancel
    none
request system shutdown graceful
    none
request system shutdown immediate
    none





Set commands
------------
set system dump-level signalling
    none
set system dump-level rtp
    none

set system dump-level full
    none
    
set system dump-level none
    none
    
set system log-level di_log <log_level>
    none
    
set system log-level syslog <log_level>
    none
    
set system session-limit <limit> <overload response code> <overload response reason> 
    none
        


Run command on all nodes
------------------------
You can prepend command with word "all" to run it on all nodes


Command output filtering
------------------------

You can use | to filter command output