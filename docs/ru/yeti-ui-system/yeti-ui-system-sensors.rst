
Sensors
~~~~~~~

System supports mirroring of signaling and media traffic.
This functionality can be used for Lawful Interception.
Currently system supports three encapsulation methods:

    - IP-IP tunnel
        Original packets will be encapsulated into additional IP-IP tunnel header.
        This mode allows to route mirrored traffic,
        it's especially useful when destination equipment not available in the same broadcast domain.
    - IP over Ethernet
        In this mode original packets will be encapsulated directly into Ethernet frame using raw sockets.
        Intended to use for cases when destination equipment is in the same L2 domain.
    - HEPv3
        Homer Encapsulation Protocol or HEP is a protocol used to send data from a tracing node to a capturing node. The          latest version of HEP is version 3 which came with a major improvement changing HEP protocol from a header based          encapsulation protocol, that is each field had it's well known position in the header as it is for the TCP              header for example, to a more flexible chunk-based protocol.

Sensor and logging level can be chosen in gateway settings.
Sensor configuration is separate for A and B leg, thus for both legs mirroring - sensors must be configured for both termination and origination gateway.

**Sensor**'s attributes:
````````````````````````
    Id
       Sensor's id.
    Name
        Sensor's name.
    Mode
        IP-IP encapsulation
        IP-Ethernet encapsulation
        HEPv3
    Source Interface
        The name of the source interface of this *Sensor*. This field is used for "IP-Ethernet encapsulation" mode.
    Target MAC
        MAC address of target gateway. This field is used for "IP-Ethernet encapsulation" mode.
    Source IP
        IP address of source interface of this *Sensor*. This field is used for "IP-IP encapsulation" mode.
    Target IP
        IP address of target gateway. This field is used for "IP-IP encapsulation" and for "HEPv3" modes.
    Target Port
        Port number of target gateway. This field is used for "HEPv3" mode.
    Hep Capture
        Value of HEP_CAPTURE_ID. Leave it empty to use YETI Node ID as HEP_CAPTURE_ID. This field is used for "HEPv3" mode.


