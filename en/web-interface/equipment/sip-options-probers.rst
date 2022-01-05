
.. _sip_options_probers:

SIP Options probers
~~~~~~~~~~~~~~~~~~~

SIP Options probers allows to configure send SIP OPTIONS requests to remote gateways. This feature is usable to remote gateway monitoring.

Attributes
``````````
    Id
        Unique id.
    Name
	    Name of this SIP Option prober configuration
    Enabled
        Disabled probers will be ignored.
    Pop
        Point of presence for SIP OPTIONS requests.
    Node
        Node which will send SIP OPTIONS requests. 
    Transport protocol
        SIP transport protocol which will be used for send request.
    RURI Domain
        R-URI domain of outgoing SIP OPTIONS request
    RURI Username
        R-URI username of outgoing SIP OPTIONS request
    From URI
        From URI of outgoing SIP OPTIONS request
    To URI
        From URI of outgoing SIP OPTIONS request
    Auth username
        Authorization username.
    Auth password
        Authorization password.
    Proxy
        SIP Proxy to use for SIP OPTIONS. Proxy address should specified in **SIP URI** format eg sip:sip-proxy.example.com. See :ref:`SIP Flow example <registration_with_proxy>`
    Proxy transport protocol
        SIP transport protocol which will used for interaction with proxy.
    Contact uri
        Contact header. Should be in a SIP-URI format.
    Interval
        Requests sending interval in seconds
    Sip Interface Name
        Name of signalling interface from sems.conf that will be used to build outgoing OPTIONS request.
    Append headers
        Custom headers to append to outgoing request.
        


