.. :maxdepth: 2


======================
SEMS node installation
======================

Install packages
----------------

.. code-block:: console

    # apt update && apt install sems sems-modules-yeti
    
Configuration files
-------------------

.. _sems_conf:

/etc/sems/sems.conf
~~~~~~~~~~~~~~~~~~~

Add new node to the routing database using web interface
[ System -> Nodes -> New Node ].
Use id of newly created node as value for **node_id** parameter

node_id
    unique signaling node id.
    
.. warning:: You should create Node at web interface and use ID from web interface at **node_id** variable. See :ref:`System->Nodes <nodes>` menu.

Replace <SIGNALLING_IP>, <MEDIA_IP> with correct values for your server :

.. code-block:: ini

    node_id = <id of created node>

    interfaces=intern
    sip_ip_intern=<SIGNALLING_IP> 
    sip_port_intern=5061 
    media_ip_intern=<MEDIA_IP> 
    rtp_low_port_intern=20000 
    rtp_high_port_intern=50000
    plugin_path=/usr/lib/sems/plug-in/ 
    load_plugins=wav;ilbc;speex;gsm;adpcm;l16;g722;sctp_bus;yeti;session_timer;uac_auth;di_log;registrar_client;jsonrpc
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
    
.. _yeti_conf:

/etc/sems/etc/yeti.conf
~~~~~~~~~~~~~~~~~~~~~~~



cfg_timeout
    timeout of waiting response from management node
cfg_host
    IP address of management node
cfg_port
    SCTP port of management node

.. code-block:: ini

    cfg_timeout = 1000
    cfg_host = 127.0.0.1
    cfg_port = 4444
    core_options_handling=yes
    

.. _jsonrpc:

/etc/sems/etc/jsonrpc.conf
~~~~~~~~~~~~~~~~~~~~~~~~~~    

Such file used for RPC configuration

.. code-block:: ini

    jsonrpc_listen=127.0.0.1 
    jsonrpc_port=7080
    server_threads=1
    
RPC socket should be available from WEB interface server. You should place your real IP address if you run SEMS node on dedicated server.

.. warning:: RPC allows shutdown SEMS node or make it non-operational. RPC interface should be secured by firewall to prevent connections from not trusted hosts. In YETI systems only two components should have ability to connect to RPC - WEB interface and yeti-cli console

Launch traffic switch
---------------------

Launch configured traffic switch instance:

.. code-block:: console

    # service sems start

In case of errors it's useful to use **sems -E -D3** command
which will launch daemon in foreground with debug logging level

Checks
------

Check if **sems** process exists and signaling/media/rpc sockets are opened:

.. code-block:: console

    # pgrep sems
    29749
    # netstat -lpn | grep sems
    tcp 0    0 127.0.0.1:8090 0.0.0.0:*  LISTEN 29749/sems
    udp 0    0 127.0.0.1:5061 0.0.0.0:*         29749/sems
    raw 2688 0 0.0.0.0:17     0.0.0.0:*  7      29749/sems

Check logfile /var/log/sems/sems-main.log for possible errors
