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

.. _sems_conf_1.12:

/etc/sems/sems.conf
~~~~~~~~~~~~~~~~~~~

Add new :ref:`Point of Presensce <pops>` using web interface. Use id of newly created PoP as value for **pop_id** parameter.

Add new :ref:`Node <nodes>` using web interface. Use id of newly created Node as value for **node_id** parameter.

Replace <SIGNALLING_IP>, <MEDIA_IP> with correct values for your server :

.. code-block::

    general {
        stderr = no
        syslog_loglevel = 2
        syslog_facility = LOCAL0

        node_id = 8

        shutdown_mode {
            code = 508
            reason = "Yeti node in shutdown mode"
            allow_uac = true
        }

        media_processor_threads = 4
        rtp_receiver_threads = 4
        session_processor_threads = 20
        sip_udp_server_threads = 2
        sip_tcp_server_threads = 2

        dead_rtp_time=30

        default_bl_ttl=0

        symmetric_rtp_mode = packets
        symmetric_rtp_packets = 20
    }

    signaling-interfaces {
        interface internal {
            default-media-interface = internal
            ip4 {
                sip-udp {
                    address = <SIGNALLING_IP>
                    port = 5060
                    use-raw-sockets = off
                }
                sip-tcp {
                    address = <SIGNALLING_IP>
                    port = 5060
                    connect-timeout = 2000
                    static-client-port = on
                    idle-timeout=900000
                    use-raw-sockets = off
                }
            }
        }
    }

    media-interfaces {
        interface internal {
            ip4 {
                rtp {
                    address = <MEDIA_IP>
                    low-port = 16384
                    high-port = 32769
                    dscp = 46
                    use-raw-sockets = off
                }
            }
        }
    }

    modules {
        module "di_log" {}
        module "mp3" {}
        module "opus" {}
        module "wav" {}
        module "gsm" {}
        module "ilbc" {}
        module "adpcm" {}
        module "l16" {}
        module "g722" {}

        module "registrar_client" {}
        module "session_timer" {}
        module "jsonrpc" {
            listen{
                address = 127.0.0.1
                port = 7080
            }
            server_threads = 1
        }

        module "http_client" {}

        module-global "uac_auth" {}
        module "options_prober" {}

        module "radius_client" {}

        module "yeti" {
            pop_id = 4
            lega_cdr_headers {
                header(p-charge-info, string)
                header(diversion, array)
            }

            auth {
                realm = yeti-switch
            }

            msg_logger_dir = /var/spool/sems/dump
            audio_recorder_dir = /var/spool/sems/records
            audio_recorder_compress = true

            db_refresh_interval = 5
            ip_auth_reject_if_no_matched = true

            routing {
                schema = switch20
                function = route_release
                init = init
                master_pool {
                    host = 127.0.0.1
                    port = 5432
                    name = yeti
                    user = yeti
                    pass = somepassword
                    size = 4
                    check_interval = 10
                    max_exceptions = 0
                    statement_timeout=3000
                }
                failover_to_slave = false
                slave_pool {
                    host = 127.0.0.1
                    port = 5432
                    name = yeti
                    user = yeti
                    pass = somepassword
                    size = 4
                    check_interval = 10
                    max_exceptions = 0
                    statement_timeout=3000
                }
            }
            cdr {
                dir = /var/spool/sems/cdrs
                completed_dir = /var/spool/sems/cdrs/completed
                pool_size = 2
                schema = switch
                function = writecdr
                master {
                    host = 127.0.0.1
                    port = 5433
                    name = cdr
                    user = cdr
                    pass = somepassword
                }
                failover_to_slave = false
                slave {
                    host = 127.0.0.1
                    port = 5433
                    name = cdr
                    user = cdr
                    pass = somepassword
                }
                failover_requeue = true
                failover_to_file = false
                serialize_dynamic_fields = true
                batch_size = 1
                batch_timeout = 5000
            }
            resources {
                reject_on_error = false
                write {
                    host = 127.0.0.1
                    port = 6379
                    size = 2
                    timeout = 500
                }
                read {
                    host = 127.0.0.1
                    port = 6379
                    size = 2
                    timeout = 1000
                }
            }
            registrations {
                check_interval = 5000
            }
            registrar {
                enabled = true
                expires_min = 600
                expires_max = 7200
                expires_default = 1200
                redis {
                    host = 127.0.0.1
                    port = 6379
                }
            }
            rpc {
                calls_show_limit = 10000
            }
            core_options_handling = yes
        }
    }

    routing {
        application = yeti
    }


.. warning:: JRPC interface allows shutdown SEMS node or make it non-operational. JRPC interface should be secured by firewall to prevent connections from not trusted hosts. In YETI systems only two components should have ability to connect to RPC - WEB interface and yeti-cli console

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
