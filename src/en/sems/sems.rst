.. :maxdepth: 2


==================
SEMS configuration
==================


Yeti uses modified SEMS that has other configuration file format than `mainstream version <https://github.com/sems-server/sems>`_
Configuration located at  /etc/sems/sems.conf. 

Section **general**
-------------------

Section **general** contains some global daemon parameters:

.. code-block:: c
   :caption: general section example
   
    general {
        node_id = 8
        daemon = yes
        stderr = no
        syslog_loglevel = 2
        syslog_facility = LOCAL0

        shutdown_mode {
            code = 508
            reason = "Node in shutdown mode"
            allow_uac = true
        }
        #~ pcap_upload_queue = pcap

        media_processor_threads = 1
        session_processor_threads = 1
        rtp_receiver_threads=1
        sip_udp_server_threads = 1
        sip_tcp_server_threads = 1

        dead_rtp_time=30

        max_shutdown_time = 10
        max_forwards = 70 

        session_limit {
            limit = 4000
            code = 509
            reason = "Node overloaded"
        }

        enable_srtp = yes
        enable_zrtp = yes        
    }
    
node_id
    Unique node identifier. Value should be unique across cluster.

daemon
    To daemonize SEMS or not
    
stderr
    Enable logging to stderr. Usable for debug purposes.

syslog_loglevel
    Logs level for syslog log destination.
  
syslog_facility
    Syslog **facility** value
    
shutdown_mode
    Subsection to define behavior in shutdown mode

shutdown_mode->code
    SIP error code for new initial INVITES in shutdown mode
    
shutdown_mode->reason
    SIP error reason for new initial INVITES in shutdown mode
  
shutdown_mode->allow_uac
    Allow new LegB creation in shutdown mode.
    
pcap_upload_queue
    TODO

media_processor_threads
    TODO

session_processor_threads
    TODO

sip_udp_server_threads
    TODO
    
sip_tcp_server_threads
    TODO

dead_rtp_time
    TODO



Section **signaling-interfaces**
--------------------------------

.. code-block:: c
   :caption: signaling-interfaces configuration example

    signaling-interfaces {
        interface input {
            default-media-interface = input
            ip4 {
                sip-udp {
                    address = 193.186.15.24
                    port = 5061
                    use-raw-sockets = off
                    origination-acl {
                        whitelist = { 193.186.15.0/24 } 
                        method = drop
                    }
                    register-acl {
                        whitelist = { 193.186.15.0/24 } 
                        method = drop 
                    }
                }
                sip-tcp {
                    address = 193.186.15.24
                    port = 5061
                    connect-timeout = 2000
                    static-client-port = on
                    idle-timeout=900000
                    use-raw-sockets = off
                    origination-acl {
                        whitelist = { 193.186.15.0/24 } 
                        method = drop
                    }
                    register-acl {
                        whitelist = { 193.186.15.0/24 } 
                        method = drop 
                    }
                }
                sip-tls {
                    address = 193.186.15.24
                    port = 5061
                    static-client-port = on
                    connect-timeout = 2000
                    idle-timeout = 900000
                    client {
                        protocols =  { TLSv1, TLSv1.1, TLSv1.2 }
                        certificate = /etc/sems/ssl/demo.yeti-switch.org.crt_bundle
                        certificate_key = /etc/sems/ssl/demo.yeti-switch.org.key.pkcs8
                        verify_certificate_chain = false
                        verify_certificate_cn = false
                    }
                    server {
                        protocols =  { TLSv1, TLSv1.1, TLSv1.2 }
                        certificate = /etc/sems/ssl/demo.yeti-switch.org.crt_bundle
                        certificate_key = /etc/sems/ssl/demo.yeti-switch.org.key.pkcs8
                        ciphers = {ChaCha20Poly1305, AES-256/GCM, AES-128/GCM, AES-256/CCM, AES-128/CCM, AES-256, AES-128}
                        macs = {AEAD, SHA-256, SHA-384, SHA-1}
                        verify_client_certificate = false
                        require_client_certificate = false
                    }
                }
            }
            ip6 {
                sip-udp {
                    address = 2001:67c:1324:101::24
                    port = 5061
                    use-raw-sockets = off
                    origination-acl {
                        whitelist = { 2001:67c:1324:101::/64 }
                        method = drop 
                    }
                    register-acl {
                        whitelist = { 2001:67c:1324:101::/64 }
                        method = drop 
                    }
                }
                sip-tcp {
                    address = 2001:67c:1324:101::24
                    port = 5061
                    connect-timeout = 2000
                    static-client-port = on
                    idle-timeout=900000
                    use-raw-sockets = off
                    origination-acl {
                        whitelist = { 2001:67c:1324:101::/64 }
                        method = drop 
                    }
                    register-acl {
                        whitelist = { 2001:67c:1324:101::/64 }
                        method = drop 
                    }
                }
                sip-tls {
                    address = 2001:67c:1324:101::24
                    port = 5061
                    static-client-port = on
                    connect-timeout = 2000
                    idle-timeout = 900000
                    client {
                        protocols =  { TLSv1, TLSv1.1, TLSv1.2 }
                        certificate = /etc/sems/ssl/demo.yeti-switch.org.crt_bundle
                        certificate_key = /etc/sems/ssl/demo.yeti-switch.org.key.pkcs8                       
                        verify_certificate_chain = false
                        verify_certificate_cn = false
                    }
                    server {
                        protocols =  { TLSv1, TLSv1.1, TLSv1.2 }
                        certificate = /etc/sems/ssl/demo.yeti-switch.org.crt_bundle
                        certificate_key = /etc/sems/ssl/demo.yeti-switch.org.key.pkcs8                   
                        ciphers = {ChaCha20Poly1305, AES-256/GCM, AES-128/GCM, AES-256/CCM, AES-128/CCM, AES-256, AES-128}
                        macs = {AEAD, SHA-256, SHA-384, SHA-1}
                        verify_client_certificate = false
                        require_client_certificate = false
                    }
                }
            }
        }
    }


Section **media-interfaces**
----------------------------

.. code-block:: c
   :caption: media-interfaces configuration example

    media-interfaces {
        interface intern {
            ip4 {
                rtp {
                    address = 2001:67c:1324:101::24
                    low-port = 16383
                    high-port = 32767
                    dscp = 46
                    use-raw-sockets = off
                    srtp {
                        enable_srtp=yes
                        sdes {
                            profiles = { AES_256_CM_HMAC_SHA1_80, AES_256_CM_HMAC_SHA1_32, AES_CM_128_HMAC_SHA1_80, AES_CM_128_HMAC_SHA1_32 }
                        }
                        dtls {
                            client {
                                protocols =  { DTLSv1, DTLSv1.2 }
                                certificate = /etc/sems/ssl/demo.yeti-switch.org.crt_bundle
                                certificate_key = /etc/sems/ssl/demo.yeti-switch.org.key.pkcs8
                                profiles = { AES_256_CM_HMAC_SHA1_80, AES_256_CM_HMAC_SHA1_32, AES_CM_128_HMAC_SHA1_80, AES_CM_128_HMAC_SHA1_32 }
                                verify_certificate_chain = false
                                verify_certificate_cn = false
                            }
                            server {
                                protocols =  { DTLSv1, DTLSv1.2 }
                                certificate = /etc/sems/ssl/demo.yeti-switch.org.crt_bundle
                                certificate_key = /etc/sems/ssl/demo.yeti-switch.org.key.pkcs8
                                profiles = { AES_256_CM_HMAC_SHA1_80, AES_256_CM_HMAC_SHA1_32, AES_CM_128_HMAC_SHA1_80, AES_CM_128_HMAC_SHA1_32 }
                                ciphers = {ChaCha20Poly1305, AES-256/GCM, AES-128/GCM, AES-256/CCM, AES-128/CCM, AES-256, AES-128}
                                macs = {AEAD, SHA-256, SHA-384, SHA-1}
                                verify_client_certificate = false
                                require_client_certificate = false
                            }
                        }
                    }
                }
            }
            ip6 {
                rtp {
                    address = 2001:67c:1324:101::24
                    low-port = 16383
                    high-port = 32767
                    dscp = 46
                    use-raw-sockets = off
                    srtp {
                        enable_srtp=yes
                        sdes {
                            profiles = { AES_256_CM_HMAC_SHA1_80, AES_256_CM_HMAC_SHA1_32, AES_CM_128_HMAC_SHA1_80, AES_CM_128_HMAC_SHA1_32 }
                        }
                        dtls {
                            client {
                                protocols =  { DTLSv1, DTLSv1.2 }
                                certificate = /etc/sems/ssl/demo.yeti-switch.org.crt_bundle
                                certificate_key = /etc/sems/ssl/demo.yeti-switch.org.key.pkcs8
                                profiles = { AES_256_CM_HMAC_SHA1_80, AES_256_CM_HMAC_SHA1_32, AES_CM_128_HMAC_SHA1_80, AES_CM_128_HMAC_SHA1_32 }
                                verify_certificate_chain = false
                                verify_certificate_cn = false
                            }
                            server {
                                protocols =  { DTLSv1, DTLSv1.2 }
                                certificate = /etc/sems/ssl/demo.yeti-switch.org.crt_bundle
                                certificate_key = /etc/sems/ssl/demo.yeti-switch.org.key.pkcs8
                                profiles = { AES_256_CM_HMAC_SHA1_80, AES_256_CM_HMAC_SHA1_32, AES_CM_128_HMAC_SHA1_80, AES_CM_128_HMAC_SHA1_32 }
                                ciphers = {ChaCha20Poly1305, AES-256/GCM, AES-128/GCM, AES-256/CCM, AES-128/CCM, AES-256, AES-128}
                                macs = {AEAD, SHA-256, SHA-384, SHA-1}
                                verify_client_certificate = false
                                require_client_certificate = false
                            }
                        }
                    }
                }
            }
        }
    }


Section **modules**
-------------------

Section modules describles which modules should be loaded. Module can optionally accept configuration.

.. code-block:: c
   :caption: modules configuration example

    modules {
        module "Module1" {
            /* Module1 configuration */
        }
        
        module "Module2" {
            /* Module2 configuration */
        }
    }
    
SEMS will lookup modules(.so binary libraries) at ``/usr/lib/sems/plug-in/`` directory.


Section **routing**
-------------------

SEMS is application server so it is possible to load multiple application at same time and route incoming requests/sessions based on some conditions. **Routing** section allows to configure rules how to route incoming requests/dialogs.

.. code-block:: c
   :caption: routing configuration example
   
    routing {
        application = yeti
    }


