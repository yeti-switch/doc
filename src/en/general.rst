.. :maxdepth: 2

===================
General information
===================

:Site: https://yeti-switch.org/


Features and technical characteristics
======================================

YETI — class4 SIP softswitch with integrated billing and intelligent routing subsystem.
Solution is intended to act as distributed SBC on the networks of the service providers which are working using protocol SIP.
System supports a variety of intelligent routing algorythms.

Softswitch handles SIP signalling and RTP traffic. Supports transcoding, detailed CDRs (more than 100 fields) allows to save all parameters which are needed for billing, debugging and analytic reports.
Yeti supports intelligent LCR/ASR/ACD routing by various criteria. Below is short list of supported features.

Signalling and RTP processing
-----------------------------
- SIP v.2.0 over UDP, TCP and TLS transports
- IPv6 support. Flexible resolving configuration
- SRTP with DTLS and SDES mechanisms
- sending/receiving DTMF (SIP INFO application/dtmf, SIP INFO application/dtmf-relay, RTP telephone-event) with ability to transcode between them in any combination.
- Automatic call disconnect on RTP timeout configurable per gateway
- SIP Session timers
- SIP UPDATE method
- Flexible configuration for NAT traversal (various symmetric RTP modes, RTP ping)
- DNS SRV failover and load-balancing 
- Disconnect codes rewriting for replies from vendor to customer.
- RTP transcoding.
- RTCP/RTP statistics saving.
- Smart codecs negotiation - SDP sorting, non-audio streams filtering, normalization of the connection line location, e.t.c
- RTP streams normalization (sequence and timestamp aligning).
- in-dialog OPTIONS/ UPDATE/re-INVITE/PRACK local processing or relay.
- Special settings to work with systems which use non-standard SIP implementations.
- Fax T.38
- Outgoing SIP registrations.
- Incoming SIP registrations(Registrar). Call termination to gateways with dynamic IP is supported


Supported Codecs
----------------

- g711 alaw/ulaw
- g722
- g723.1
- g729
- iLBC
- speex
- gsm
- adpcm
- OPUS


Authorization
-------------

- Originator IP address
- Username/Password Authorization
- DST, SRC prefixes
- SIP R-URI domain
- Custom SIP header
- Geolocation of the signalling node
- External RADIUS server

Routing
-------

- Re-routing which is transparent for the client.
  Flexible configuration for the conditions when to use next route
- Rewriting or transparent passing of the disconnect codes for the client
- Flexible LCR configuration (quiality control, prices limit).
  Possibility of the fast implementation of the any desired alternative algorithm
- Capacity control for gateways, destinations, companies, accounts
- Source and Destination number based Blacklisting and per number translation rules
- Possibility to rewrite/modify caller-id, DNIS at the any routing stage
- Time-based routing
- Statistic and quality control for the each destination
- Gateways grouping and load-balancing for cases when supplier provides several gateways for the termination
- Possibility to silently reject unauthorized SIP INVITEs
  (Reduces parasitic traffic from  bots which are search for the vulnerabilities in telephone systems — actual for the work through Internet network)
- Tag based routing to building flexible rules like origin-based routing and billing

Billing
-------

- Realtime CDR writing. Possibility to skip CDR write for specific disconnect codes
- Realtime traffic blocking when balance limit reached
- Flexible rateplanes configuration and routing policies to provide optimal profitability
- Configurable billing intervals, support of the connect fee
- Invoices and documents generation from templates
- Dynamic price calculation for client from real termination price.
  This mode useful to   sell traffic for the trusted clients at the minimum cost price
- Integration with external systems
- Possibility to send CDRs to the external systems (e.g for antifraud analysis)
- REST API for data modification (in development)
- Lawful interception sensors.
  Allows to configure traffic mirroring to the external equipment without affecting on system work.
  It's possible to configure different sensors for different call legs and gateways.
  At this moment system supports IP-IP and IP over Ethernet incapsulation.
- Support to receive information about upper limit for the rate for the each call from the custom SIP header from the client.
- Ability to show information about real termination cost (supplier rates) to the trusted clients, and information about cost for the client ( useful in case of dynamic rate calculation)

Reports
-------

- Realtime capacity utilization for companies, gateways, destinations
- Reports on destinations, clients, suppliers, time
- Displaying of the active calls which are going through the system.
  Ability to end any active call from the web-interface

Administration
--------------

- Zero downtime upgrade.
  All components can be updated without traffic processing interruption and billing violations.
- Clusterization.
  Scaling of the system is performed with adding of servers to the cluster.
- Possibility of geo-distributed setup which is controlled from single interface.
  Such configuration is fault tolerant to the network and hardware issues, and provides correct CDR billing after reconnection between system parts.
- Convenient web-interface with possibility to find simply any system entities. Interface operators modifications logging allows to provide a high level of security. Supported export and import for all system configuration base objects.
- Time-consuming tasks are performed in background to prevent blocking of the web-interface.
- All components are developed and packaged for single platform (Debian GNU/Linux) and can be setup/upgraded using standart package manager (apt).
- CLI interface for routing system. Allows to manage all routing nodes and use extended debugging tools.
- Recording of the PCAP dumps for the calls to provide simple debugging. Recorded dumps are available through web-interface.
- CDRs have big amount of the debugging info.
- RTP statistic saving for each stream.
- Automatic data retention.


Components
==========

Yeti consists of the following components:

- Traffic routing server (SEMS + YETI module)
- Management daemon - used as configuration storage across cluster
- Incoming traffic balancer (Kamailio)
- Routing database (Postgresql)
- CDR database (Postgresql)
- Realtime data storage(Redis)
- Web-interface (RoR, ruby)
- CLI interface (python) [optional]
- CDRs billing and statistics calculation daemons based on PGQ

YETI designed as cluster system, but you can run all components  on the one server, as well as on the different hosts.
Supported OS is **Debian GNU/Linux**, the only supported architecture is **amd64**

