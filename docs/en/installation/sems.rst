.. :maxdepth: 2


======================
SEMS node installation
======================

Install packages
----------------

::

    # aptitude install sems sems-modules-yeti
    
Configuration files
-------------------

/etc/sems/sems.conf
~~~~~~~~~~~~~~~~~~~

Replace <SIGNALLING_IP>, <MEDIA_IP> with correct values for your server ::

    interfaces=intern
    sip_ip_intern=<SIGNALLING_IP> 
    sip_port_intern=5061 
    media_ip_intern=<MEDIA_IP> 
    rtp_low_port_intern=20000 
    rtp_high_port_intern=50000
    plugin_path=/usr/lib/sems/plug-in/ 
    load_plugins=wav;ilbc;speex;gsm;adpcm;l16;g722;yeti;session_timer;uac_auth;di_log;registrar_client;jsonrpc
    application = yeti
    plugin_config_path=/etc/sems/etc/
    fork=yes
    stderr=no
    syslog_loglevel=2
    max_shutdown_time = 10

    session_processor_threads=20
    media_processor_threads=2
    session_limit="4000;509;Node overloaded"
    shutdown_mode_reply="508 Node in shutdown mode"
    options_session_limit="900;503;Warning, server soon overloaded"
    # cps_limit="100;503;Server overload"
    use_raw_sockets=yes 
    sip_timer_B = 8000 
    default_bl_ttl=0
    registrations_enabled=no

/etc/sems/etc/yeti.conf
~~~~~~~~~~~~~~~~~~~~~~~

Add new node to the routing database using web interface
[ System -> Nodes -> New Node ].
Use id of newly created node as value for **node_id** parameter

node_id
    unique signaling node id
cfg_timeout
    timeout of waiting response from management node
cfg_urls
    list of comma separated names for management node addresses
cfg_url_<name>
    management node address to fetch configuration ([sub:/etc/yeti/management.cfg])

::

    node_id = <id of created node>
    
    cfg_timeout = 1000
    
    cfg_urls = main
    cfg_url_main = tcp://127.0.0.1:4444
    core_options_handling=yes
    

Other configuration files
~~~~~~~~~~~~~~~~~~~~~~~~~

Copy defaults for the rest of needed configuration files::

    # mv /etc/sems/etc/jsonrpc.conf.dist /etc/sems/etc/jsonrpc.conf

Edit this file to change listenging address if you are going to build a multi-node system

Launch traffic switch
---------------------

Launch configured traffic switch instance::

    # service sems start

In case of errors it's useful to use **sems -E -D3** command
which will launch daemon in foreground with debug logging level

Checks
------

Check if **sems** process exists and signaling/media/rpc sockets are opened::

    # pgrep sems
    29749
    # netstat -lpn | grep sems
    tcp 0    0 127.0.0.1:8090 0.0.0.0:*  LISTEN 29749/sems
    udp 0    0 127.0.0.1:5061 0.0.0.0:*         29749/sems
    raw 2688 0 0.0.0.0:17     0.0.0.0:*  7      29749/sems

Check logfile /var/log/sems/sems-main.log for possible errors
