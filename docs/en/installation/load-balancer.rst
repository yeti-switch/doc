.. :maxdepth: 2

==========================
Load balancer installation
==========================

SIP flow with load-balancer
--------------------------------

.. raw:: html

	<embed>
	 <pre class='code xu mscgen_js' data-language='xu' data-named-style='basic'>
	msc {
  
	  arcgradient=0, hscale=2;
 
	  C[label="Call originator\n11.11.11.11"],
	  L[label="YETI Load balancer\n12.12.12.12"],
	  S[label="SEMS Node\n13.13.13.13"];
  
	  L alt S [label="POP", textbgcolor="#f7fff7"] {
	  C => L [label="INVITE"];
	  L => C [label="100 Trying"];
	  L => S [label="INVITE\nX-ORIG-IP:11.11.11.11.11\nX-ORIG-PORT:5060\nX-ORIG-PROTO:1"];
	  S rbox S [label= "Routing procedures"];
	  S => L [label="100 Trying"];
	  S => L [label="180 Ringing"];
	  L => C [label="180 Ringing"];
	  S => L [label="200 OK"];
	  L => C [label="200 OK"];
	  C >> S [label="RTP from originator"];
	  S >> C [label="RTP to originator"];
	  C => L [label="ACK"];
          L => S [label="ACK"];
          C => L [label="BYE"];
          L => S [label="BYE"];
          S => L [label="200 OK"];
	  L => C [label="200 OK"];
	  S rbox S [label= "CDR writing"];
	  };
	}

    </pre>
    </embed>


Packages installation
---------------------

.. code-block:: console

    root@server:~# apt update && apt install yeti-lb
    
.. note:: On package configuration stage you will be asked to specify address of previously installedsignaling node and address for load balancer to listen on.

After installation you can change any parameters by editing files:
/etc/kamailio/dispatcher.list and /etc/kamailio/lb.conf






Launch
------

Launch load balancer:

.. code-block:: console

    root@server:~# service kamailio start

Checks
------

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
