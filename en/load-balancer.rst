
=============
Load balancer
=============

Yeti load balancer acts as SIP proxy and allows to distribute incoming calls across multiple SEMS nodes. To implement load balancer you can use Kamailio or OpenSIP sip proxies with dispatcher module


Load balancer requirements
==========================


Load balancer should add headers to initial INVITE:

	- **X-ORIG-IP** with original call originator IP
	- **X-ORIG-PORT** with source port number of call originator
	- **X-ORIG-PROTO** with protocol number: 1 for UDP, 2 for TCP and 3 for TLS

Load balancer should add **Record-Route** headers to modify SIP route-set and stay on signaling path.


Load balancer IP should be registered in :ref:`System->Load balancers <load_balancers>`.



SIP flow with load-balancer
===========================

.. mermaid::

	sequenceDiagram
		participant O as Call originator<br/> IP 203.0.113.5
		participant LB as Yeti Load Balancer
		participant N as Yeti Node
		O->>LB: INVITE
		LB->>O: 100 Trying
		LB->>N: INVITE <br/> X-ORIG-IP:203.0.113.5 <br/> X-ORIG-PORT:5060  <br/> X-ORIG-PROTO:1
		N->>LB: 100 Trying
		Note over N: call routing
		N->>LB: 180 Ringing
		LB->>O: 180 Ringing
		N->>LB: 200 OK
		LB->>O: 200 OK
		O->>LB: ACK
		LB->>N: ACK
		N-->>O: RTP
		O-->>N: RTP
		N->>LB: BYE
		LB->>O: BYE
		O->>LB: 200 OK
		LB->>N: 200 OK
		N->>LB: ACK
		LB->>O: ACK
		Note over N: CDR writing
