
Routing Simulation
~~~~~~~~~~~~~~~~~~

Routing Simulation tool is used for debugging of call passing via Yeti. After filling necessary fields (attributes of call) and pushing "Simulate routing" button the result of call including disconnect code of call and full information about it and also log of call's processing will be provided.

**Routing Simulation**'s attributes:
````````````````````````````````````
    Transport protocol
        Transport protocol of call delivering:
            UDP - User Datagram Protocol
            TCP - Transmission Control Protocol
    Remote ip
        IP address of remote host that will be used as source of call during simulation.
    Remote port
        UDP/TCP port of remote host that will be used as source of call during simulation.
    Pop
        Point-of-Presence that will receive call during simulation.
    Src number
        Source number (A-number) of simulated call.
    Dst number
        Destination number (B-number) of simulated call.
    Uri domain
        Domain part of the URI for simulated call.
    From domain
        Domain part of the URI in the From header for simulated call.
    To domain
        Domain part of the URI in the To header for simulated call.
    X yeti auth
        Value of custom SIP-header **X-Yeti-Auth** for simulated call.
    Pai
        Value of P-Asserted-Identity (PAI) privacy field of SIP header for simulated call.
    Ppi
        Value of P-Preferred-Identity (PPI) privacy field of SIP header for simulated call.
    Privacy
        Value of SIP Privacy field of SIP header for simulated call.
    Rpid
        Value of Remote Party ID field of SIP header for simulated call.
    Rpid privacy
        Value of SIP RPID Privacy field of SIP header for simulated call.
    Release mode
        If this flag is enabled Yeti won't show debugging information together with result of call simulation.


