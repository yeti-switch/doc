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

        dead_rtp_time=300

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

node_id (default: 0)
    Unique node identifier. Value should be unique across cluster.

log_dump_path (default: /var/spool/sems/logdump)
    Directory to save **di_log** module dumps on *core.request.log.dump* jsonrpc method call

rsr_path (default: /var/spool/sems/rsr)
    Directory to save Raw SEMS Record files

pcap_upload_queue (default: empty)
    destination name in the **http_client** module to automatically upload PCAP files

max_shutdown_time (default: 10)
    max time in seconds to wait for sessions to cleanly end on shutdown

logging
^^^^^^^

syslog_loglevel (default: info)
    Min log level for syslog log destination. allowed values: 0-5, error, warn, info, debug, debug2, debug3

syslog_facility (default: DAEMON)
    Syslog **facility** value. allowed values: DAEMON, USER, LOCAL[0-7]

stderr (default: false)
    Enable logging to stderr. Usable for debug purposes. Could be enabled by opt **-E**

stderr_loglevel (default: info)
    Min log level for stderr log destination. allowed values: 0-5, error, warn, info, debug, debug2, debug3. Could be overridden by opt **-D <level>**

log_parsed_messages (default: true)
    Whether to log parsed SIP requests in SipCtrlInterface at the DBG1 level

log_raw_messages (default: debug)
    How to log raw SIP messages on send/recv. allowed values: error, warn, info, debug, debug2, debug3, no

unhandled_reply_loglevel (default: error)
    How to log unhandled SIP provisional and success replies. allowed values: error, warn, info, debug, debug2, debug3, no

log_events (default: false)
    Log events processing stages at the debug level

log_sessions (default: false)
    Log new UAC/UAS sessions at the info level

signalling/media
^^^^^^^^^^^^^^^^

force_outbound_if (default: false)
    Force interface index for outgoing SIP and RTP packets. Uses IPPROTO_IP/IP_PKTINFO.ipi_ifindex, IPPROTO_IPV6/IPV6_PKTINFO.ipi6_ifindex for sendmsg

use_raw_sockets (default: false)
    Global switch to use SOCK_RAW for outgoing SIP/UDP and RTP packets

ssl_key_log_file (default: empty)
    Write TLS and SRTP secrets to the specified file in SSLKEYLOG format. Useful to decrypt signalling and media in the traces collected by the external tools.

signalling
^^^^^^^^^^

session_processor_threads (default: 10)
    Session processor threads count. Session processor threads handle events from the sessions events queues

sip_udp_server_threads (default: 4)
    SIP UDP transport workers threads count. UDP transport workers receive UDP signalling traffic

sip_tcp_server_threads (default: 4)
    SIP TCP transport workers threads count. TCP transport workers handle TCP/TLS/WS/WSS signalling traffic

sip_nat_handling (default: false)
    Force SIP dialog Next Hop to be remote ip/port/trsp on requests with single Via header

proxy_sticky_auth (default: false)
    Force **uac_auth** plugin to always send SIP request to the same endoint that sent auth challenge (avoid DNS and DNS SRV balancing/failover)

ignore_notify_lower_cseq (default: false)
    Ignore lower CSeq value for NOTIFY requests. fixes subscription dialog usage for implementations which follow 3265 instead of 5057

accept_forked_dialogs (default: false)
    Use Via-branch to match dialogs in addition to the callid+remote_tag. By default requests with different Via-branch will be matched with the same dialog.

shutdown_mode
    Subsection to define behavior in shutdown mode

shutdown_mode.code (default: 503)
    SIP error code for new initial INVITES in shutdown mode

shutdown_mode.reason (default: Server shutting down)
    SIP error reason for new initial INVITES in shutdown mode

shutdown_mode.allow_uac (default: false)
    Allow new LegB creation in shutdown mode.

max_forwards (default: 70)
    default value for the Max-Forwards header in the outgoing requests. allowed values: 1-70

session_limit.limit (default: 0)
    limit active sessions count. reject incoming initial INVITES with **session_limit.code** (default: 503) **session_limit.reason** (default: Server overload). will increase **sems_sessions_limit_rejects** metric on rejects.

options_session_limit.limit (default: 0)
    Reply with **options_session_limit.code** (default: 503) **options_session_limit.reason** (default: Server overload) for OPTIONS requests if active sessions count is greater than specified limit

cps_limit.limit (default: 0)
    limit CPS. reject incoming initial INVITES with **cps_limit.code** (default: 503) **cps_limit.reason** (default: Server overload)

sip_timer_{name}
    Override SIP timer default value in milliseconds. supported timers: A,B,D,E,F,K,G,H,I,J,L,M,C,BL

outbound_proxy (default: empty)
    Use outbound proxy for all outgoing SIP requests

force_outbound_proxy (default: false)
    Whether to appply **outbound_proxy** for in-dialog requests. will put outbound proxy URI at the top of the existent Route Set

force_cancel_route_set (default: false)
    Add SIP dialog Route Set to CANCEL requests if true

next_hop (default: empty)
    Force endpoint for SIP outgoing requests. Overrides message Next Hop lookup rules

next_hop_1st_req (default: false)
    Apply **next_hop** for the first SIP request in the dialog

udp_rcvbuf (default: -1)
    Set SIP/UDP socket recv buffer size (SO_RCVBUF)

100rel (default: supported)
    Set rel100 behavior. allowed values: disabled, supported, require

media processing
^^^^^^^^^^^^^^^^

media_processor_threads (default: 1)
    Media processor threads count. Media processor threads handle audio in the transcoding mode

rtp_receiver_threads (default: 1)
    RTP receiver threads count. RTP receiver threads handle incoming RTP packets

dead_rtp_time (default: 300)
    RTP timeout value in seconds. 0 means no timeout. will terminate session if no RTP packets received within **dead_rtp_time** interval

enable_srtp (default: false)
    Global switch to enable SRTP processing. required for SRTP-SDES, SRTP-DTLS, SRTP-ZRTP

enable_zrtp (default: true)
    Global switch to enable ZRTP processing.

enable_ice (default: true)
    Enable ICE support. will reject SDP with ICE candidates otherwise

symmetric_rtp_mode (default: packets)
    Symmetric RTP endpoint learning mode. allowed values: packets, delay

symmetric_rtp_packets (default: 0)
    Minimal RTP packets count to leave passive mode in the 'packets' symmetric RTP endpoint learning mode

symmetric_rtp_delay (default: 250)
    Minimal timeout in milliseconds to leave passive mode in the 'delay' symmetric RTP endpoint learning mode

force_symmetric_rtp (default: false)
    Always create RTP streams in passive mode. By the default we use passive mode only if remote SDP contains 'direction' or 'setup' media aline with the 'active' value

force_symmetric_candidate (default: false)
    Enable symmetric RTP for ICE candidates

detect_inband_dtmf (default: false)
    Enable inband DTMF detection

dtmf_offer_multirate (default: false)
    Add all supported rates for **telephone-event** payload in SDP offer

dtmf_default_volume (default: 20)
    Volume level field value for **telephone-event** packets

Section **signaling-interfaces**
--------------------------------

.. _sems_signaling_interfaces:

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

.. _sems_media_interfaces:

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


