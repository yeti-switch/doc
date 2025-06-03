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

.. _sems_conf_1.14:

/etc/sems/sems.conf
~~~~~~~~~~~~~~~~~~~

Add new :ref:`Point of Presensce <pops>` using web interface. Use id of newly created PoP as value for ``pop_id`` parameter.

Add new :ref:`Node <nodes>` using web interface. Use id of newly created Node as value for ``node_id`` parameter.

Replace ``<SIGNALLING_IP>``, ``<MEDIA_IP>`` with correct values for your server :

.. code-block::

    general {
        stderr = no
        syslog_loglevel = 2
        syslog_facility = LOCAL0

        node_id = 8

        shutdown_mode {
            code = 508
            reason = "Yeti node in shutdown mode"
            allow_uac = no
        }

        media_processor_threads = 4
        rtp_receiver_threads = 4
        session_processor_threads = 20
        sip_udp_server_threads = 2
        sip_tcp_server_threads = 2

        dead_rtp_time = 30

        default_bl_ttl = 0

        symmetric_rtp_mode = packets
        symmetric_rtp_packets = 20
    }

    signaling-interfaces {
        interface primary {
            default-media-interface = primary
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
        interface primary {
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
        module "postgresql" {}

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

        module "redis" {
            max_batch_size = 10
            batch_timeout = 100
            max_queue_size = 1000
        }

        module "registrar" {
            redis {
                use_functions = no
                write {
                    hosts = { 127.0.0.1:6379 }
                }
                read {
                    hosts = { 127.0.0.1:6379 }
                }
           }
        }

        module "yeti" {
            pop_id = <POP_ID>

            lega_cdr_headers {
                header(p-charge-info, string)
                header(diversion, array)
            }

            auth {
                # realm = hostname
                # skip_logging_invite_success = no
                # skip_logging_invite_challenge = no
            }

            audio_recorder_compress = no

            db_refresh_interval = 5
            ip_auth_reject_if_no_matched = yes

            routing {
                master_pool {
                    host = 127.0.0.1
                    port = 5432
                    name = yeti
                    user = yeti
                    pass = somepassword
                    size = 4
                    check_interval = 10
                    statement_timeout = 3000
                }
                failover_to_slave = no
                slave_pool {
                    host = 127.0.0.1
                    port = 5432
                    name = yeti
                    user = yeti
                    pass = somepassword
                    size = 4
                    check_interval = 10
                    statement_timeout = 3000
                }
            }

            cdr {
                pool_size = 2
                auth_pool_size = 2

                batch_size = 1
                batch_timeout = 5000
                auth_batch_size = 1
                auth_batch_timeout = 20000

                master {
                    host = 127.0.0.1
                    port = 5432
                    name = cdr
                    user = cdr
                    pass = somepassword
                }

                failover_to_slave = no
                slave {
                    host = 127.0.0.1
                    port = 5432
                    name = cdr
                    user = cdr
                    pass = somepassword
                }
            }

            resources {
                reduce_operations = true
                write {
                    hosts = { 127.0.0.1:6379 }
                    timeout = 500
                }
                read {
                    hosts = { 127.0.0.1:6379 }
                    timeout = 1000
                }
            }

            rpc {
                calls_show_limit = 10000
            }
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

    # systemctl start sems

In case of errors it's useful to use ``sems -E -D3`` command
which will launch daemon in foreground with debug logging level

Checks
------

Check if ``sems`` process exists and signaling/media/rpc sockets are opened:

.. code-block:: console

    # systemctl status sems
    ● sems.service - SEMS for YETI project
         Loaded: loaded (/lib/systemd/system/sems.service; enabled; preset: enabled)
         Active: active (running) since Thu 2024-12-05 20:21:52 UTC; 5 days ago
           Docs: https://yeti-switch.org/docs/
       Main PID: 68166 (sems)
          Tasks: 84 (limit: 154132)
         Memory: 3.3G
            CPU: 2d 18h 15min 51.113s
         CGroup: /system.slice/sems.service
                 └─68166 /usr/bin/sems -f /etc/sems/sems.conf
    # pgrep sems
    29749
    # netstat -lpn | grep sems
    tcp 0    0 127.0.0.1:8090 0.0.0.0:*  LISTEN 29749/sems
    udp 0    0 127.0.0.1:5061 0.0.0.0:*         29749/sems
    raw 2688 0 0.0.0.0:17     0.0.0.0:*  7      29749/sems

Check logs using for possible errors:

.. code-block:: console

    # journalctl -u sems



