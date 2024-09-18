
=============
Load balancer
=============

Yeti load balancer acts as SIP proxy and allows to distribute incoming calls across multiple SEMS nodes.

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



Packages installation
=====================

Install **kamailio** packages using system repository or https://deb.kamailio.org/ . Example kamailio configuration present at out yeti-lb repository: https://github.com/yeti-switch/yeti-lb/tree/master/src


.. warning:: You should register your Load balancer instance as trusted load balancer. See :ref:`System->Load balancers <load_balancers>` menu.


Launch
======

Launch load balancer:

.. code-block:: console

    root@server:~# systemctl start kamailio

Checks
======

Check kamailio running and listening desired sockets:

.. code-block:: console

    root@server:~# pgrep kamailio
    30853
    30854
    30855
    30856
    30857
    root@server:~# netstat -lpn | grep kamailio
    tcp 0 0 127.0.0.1:5060 0.0.0.0:* LISTEN 30857/kamailio 
    udp 0 0 127.0.0.1:5060 0.0.0.0:* 30853/kamailio
    raw 0 0 0.0.0.0:255 0.0.0.0:* 7 30853/kamailio
    unix 2 [ ACC ] STREAM LISTENING 2673337 30856/kamailio /var/run/kamailio//kamailio_ctl

Check for /var/log/syslog on possible errors.

Also you can run daemon in foreground
with logging to stderr for debugging purposes:

.. code-block:: console

    root@server:~# kamailio /etc/kamailio/kamailio.cfg
