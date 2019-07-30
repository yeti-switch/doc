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

.. _sems_conf_1.9:

/etc/sems/sems.conf
~~~~~~~~~~~~~~~~~~~

Add new node to the routing database using web interface
[ System -> Nodes -> New Node ].
Use id of newly created node as value for **node_id** parameter

node_id
    unique signaling node id.
    
.. warning:: You should create Node at web interface and use ID from web interface at **node_id** variable. See :ref:`System->Nodes <nodes>` menu.

Replace <SIGNALLING_IP>, <MEDIA_IP> with correct values for your server :

.. code-block:: c

    general {
        daemon = yes
        stderr = no
        syslog_loglevel = 3
        syslog_facility = LOCAL0

        node_id = 8

        shutdown_mode {
            code = 508
            reason = "Yeti node in shutdown mode"
            allow_uac = true
        }
        #~ pcap_upload_queue = pcap

        media_processor_threads = 1
        session_processor_threads = 1
        #sip_udp_server_threads = 1
        #sip_tcp_server_threads = 1

        dead_rtp_time=30
    }


    signaling-interfaces {
        interface input {
            default-media-interface = input
            ip4 {
                sip-udp {
                    address = <SIGNALLING_IP>
                    port = 5061
                    use-raw-sockets = off
                }
                sip-tcp {
                    address = <SIGNALLING_IP>
                    port = 5061
                    connect-timeout = 2000
                    static-client-port = on
                    idle-timeout=900000
                    use-raw-sockets = off
                }
            }
        }
    }

    media-interfaces {
        interface input {
            ip4 {
                rtp {
                    address = <SIGNALLING_IP>
                    low-port = 16384
                    high-port = 32767
                    dscp = 46
                    use-raw-sockets = off
                }
            }
        }
    }

    modules {
        module "di_log"{}
        module "mp3"{}
        module "opus"{}
        module "wav"{}
        module "gsm"{}
        module "ilbc"{}
        module "adpcm"{}
        module "l16"{}
        module "g722"{}
    
        module "registrar_client" {}
        module "sctp_bus"{}
        module "http_client"{}
        module "session_timer"{}
        module "jsonrpc"{
            listen{
                address = 127.0.0.1 
                port = 7080
            }
            server_threads=1
        }

        module-global "uac_auth" { }

        module "yeti" {
            management {
                address = 127.0.0.1
                port = 4444
                timeout = 60000
            }
            core_options_handling = yes
            registrations_enabled = yes
        }
    }

    routing { 
        application = yeti
    }



    
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
