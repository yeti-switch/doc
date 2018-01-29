=========
Equipment
=========

YETI WEB interface - Equipment menu description. This section describes Equipment entities.


.. _gateway_groups:

Gateway groups
~~~~~~~~~~~~~~

Gateway group allows to use multiple gateways for traffic termination to the same vendor if these gateways have similar billing configuration.

**Gateway group**'s attributes:
```````````````````````````````
    .. _gateway_id:

    Id
        Unique gateway group id.
    Name
        Unique gateways group name.
    Vendor
        Gateway group owner.

    .. _gateway_group_prefer_same_pop:
    
    Prefer same pop
        If enabled, firstly use termination gateways with the same POP as origination traffic has.

----

.. _gateways:

Gateways
~~~~~~~~

Gateways are used for sending VoIP traffic.

General **Gateway**'s attributes:
`````````````````````````````````

    Id
        Unique gateway id.

    .. _gateway_name:

    Name
        Friendly name of gateway.

    .. _gateway_external:

    External
        ID of Gateway that was initialized via API by external system. It used for associating internal unique Gateway ID with its ID on external system.
    Enabled
        Disabled gateways will be ignored.
    Contractor
        Gateway's owner.        
    Is shared       
        Allows gateway to be used as origination equipment for any customer.
    Gateway group
        gateways can be grouped.
        Choose group from the list to add gateway to the group.
        Gateways groups can be managed at *Billing->Gateway Groups*.            
    Priority
        Gateway priority in the gateway group.
        In case of termination to the group, gateways will be arranged according to this priority. If few gateways have same priority, calls will be  balanced between them.
    Pop
        Point of Presence of the gateway. It used to force prioritization when :ref:`prefer same POP <gateway_group_prefer_same_pop>` option enabled for gateway group.
    Allow origination
        Specifies if gateway allowed to originate calls.
    Allow termination
        Specifies if gateway allowed to accept calls from YETI.
    Origination capacity
        Origination capacity limit for this gateway. In case of gateway usage for termination this attribute will be ignored.
    Termination capacity
        Termination capacity limit for this gateway. In case of gateway usage for origination this attribute will be ignored.       
    Acd limit
        ACD threshold. If ACD for gateway traffic is below the threshold, the Dialpires that are used by this Gateway will be excluded from the routing in case of usage of routing plan with **ACD&ASR control**.
    Asr limit
        ASR threshold. If ASR for gateway traffic is below the threshold, the Dialpires that are used by this Gateway will be excluded from the routing in case of usage of routing plan with **ACD&ASR control**.
    Short Calls limit
        Threshold percentage of Short Calls. If the current value is below the threshold, the Dialpires that are used by this Gateway will be excluded from the routing in case of usage of routing plan with **ACD&ASR control**.


SST **Gateway**'s attributes:
`````````````````````````````
    SST Enabled
        Force to use SIP Session Timers, otherwise SST usage will be controlled by signaling of the remote gateway.
    SST Session Expires
        Default value (in seconds) of Expires header for SIP session timers mechanism.
    SST Minimum timer
        Minimum value (in seconds) of SIP Session Timer that will be accepted by Yeti.
    SST Maximum timer 
        Maximum value (in seconds) of SIP Session Timer that will be accepted by Yeti.
    Session refresh method
        Invite  -   re-INVITE will be used for a periodic refresh of SIP sessions.
        Update Request - UPDATE will be used for a periodic refresh of SIP sessions.
        Update Request and Invite if unsupported - UPDATE will be used for a periodic refresh of SIP sessions only in case of supporting UPDATE by remote side (it is included into Allow header), otherwise re-INVITE will be used.
    SST ACCEPT501
        If it is enabled (true) Yeti won't terminate a call in case of receiving "501 Not Implemented" on the answer on UPDATE request, otherwise (false) call will be terminated in case of receiving "501 Not Implemented" from remote side.

    Read more: `RFC 4028 Session Timers in the Session Initiation Protocol (SIP) <https://tools.ietf.org/html/rfc4028>`_

Sensor **Gateway**'s attributes:
````````````````````````````````
    Sensor level
        Traffic mirroring mode. Possible values:
            - Signaling
            - RTP
            - Signaling + RTP
    Sensor
        Sensor to mirror traffic. Mirroring is disabled if not set.

Signaling **Gateway**'s attributes:
```````````````````````````````````
    Relay options
        Transparent relay of In-dialog OPTIONS between call legs.
    Relay reinvite
        Transparent relay of In-dialog re-INVITE between call legs.
    Relay hold
        Transparent relay of In-dialog re-INVITE with hold/unhold requests between call legs.
    Relay prack
        Transparent relay of In-dialog PRACK between call legs.
    Rel100 mode
        ## Disabled
            * Reply with *420 Bad Extension* if *100rel* required and ignore it if supported in incoming INVITE.
            * Ignore 100rel related headers.
        ## Supported
            * Add *100rel* to *Supported* header for outgoing INVITE requests.
            * Process extension related things according to `RFC 3262 <https://www.ietf.org/rfc/rfc3262.txt>`_.
        ## Supported not announced
            * Doesn't add *100rel* to any header for outgoing INVITE requests,
              but enables *100rel* processing if reply contains *100rel* in *Require* header.
            * Process extension related things according to `RFC 3262 <https://www.ietf.org/rfc/rfc3262.txt>`_.
        # Require
            * Add *100rel* to *Require* header for outgoing INVITE requests.
            * Reply with *421 Extension Required* if *100rel* is not supported or required in incoming INVITE.
            * Hangup session if no *Rseq* in incoming reply.
            * Process extension related things according to `RFC 3262 <https://www.ietf.org/rfc/rfc3262.txt>`_.
        ## Ignored
            Completely ignore any headers related to 100rel extension.
    Relay UPDATE
        Transparent relay of SIP UPDATE between call legs.
    Transit headers from origination
	    Filter of headers in SIP requests which applies to origited calls. Look at :ref:`headers filtering <headers_fitering>`.
    Transit headers from termination
	    Filter of headers in SIP requests which applies to terminated calls. Look at :ref:`headers filtering <headers_fitering>`.
    Sip interface name
        The name of network interface which SEMS is listening on. It might be useful if it is necessary to route SIP-traffic from different IP-addresses.

Signaling (Origination) **Gateway**'s attributes:
`````````````````````````````````````````````````
    Orig next hop
        Network (IPv4 or IPv6) address or domain name that should be used as **SIP next hop** in case of using Gateway as Originator of calls. If this field doesn't specified - **SIP next hop** will be defined automatically by routing rules.
    Orig append headers req
        Additional SIP headers that Yeti should add to request to the Gateway (in case of using Gateway as Originator of calls). Additional header fields are lines composed of a field name, followed by a colon (:), followed by a field body, and terminated by followin set of characters ('\r\n'). A field name must be composed of printable US-ASCII characters (i.e., characters that have values between 33 and 126, inclusive), except colon.  A field body may be composed of any US-ASCII characters, except for carriage return character ('\r') and line feed character ('\n').
        Format of headers: field-name1: field-value1**\r\n**field-name1: field-value2..., where *field-name1 and field-name2* - names of the custom  fields, *field-value1 and field-value2* - values of the custom fields, **\r\n** - the carriage-return/line-feed pair.
    Orig use outbound proxy
        In case of enabling this checkbox Yeti will change destination of sending packets on Leg_A for initial SIP-requests (without remote_tag) to the address (URI) that is mentioned in the *Orig outbound proxy* field below.
    Orig force outbound proxy
        In case of enabling this checkbox Yeti will change destination of sending packets on Leg_A for in-dialog SIP-requests to the address (URI) that is mentioned in the *Orig outbound proxy* field below.
    Orig proxy transport protocol
         Transport protocol that is used for Origination proxy (User Datagram Protocol (UDP) or  Transmission Control Protocol (TCP)).
    Orig outbound proxy
       SIP Uniform Resource Indicator (URI) of SIP proxy for Gateway (in case of using Gateway as Originator of calls).
    Transparent dialog
        Not used yet.
    Dialog nat handling
       In case of enabling this field Yeti learns the proper remote address (port, transport,...) from the received message and uses that in following in-dialog requests. Enable this option when handling far end NATs.
    Orig disconnect policy
        :ref:`Disconnect policiy <disconnect_policy>` that is related to this Origination's attribute of the Gateway.

.. _incomming_auth_params:

    Incoming auth username
        This field should be filled by *username* for incoming authorization (if it necessary) of Gateway (in case of using Gateway as Originator of calls). Field is used only in case of enabling :ref:`Require incoming auth <require_incoming_auth>` flag from the General **Customers Auth**'s attributes (menu Routing).
        Call will be droped in case of receiving of different *username* from Gateway.
    Incoming auth password
        This field should be filled by *password* for incoming authorization (if it necessary) of Gateway (in case of using Gateway as Originator of calls). Field is used only in case of enabling :ref:`Require incoming auth <require_incoming_auth>` flag from the General **Customers Auth**'s attributes (menu Routing).
        Call will be droped in case of receiving of different *password* from Gateway.

.. _gateway_signaling_termination:

Signaling (Termination) **Gateway**'s attributes:
`````````````````````````````````````````````````
    Transport protocol
       Transport protocol that is used for Termination (User Datagram Protocol (UDP) or  Transmission Control Protocol (TCP)).
    Host
        IP address or DNS name of remote gateway to send SIP signaling (only for termination).
    Port
        Port of remote gateway to send SIP signaling.
        Leave it empty to enable DNS SRV resolving of name in **Host**.
    Resolve ruri
        Indicates necessity to rewrite RURI domain part with resolved IP

        for example: `domain.com` has IP 1.1.1.1 and you set **Host** to `domain.com`:

            - resolve ruri enabled => RURI will be `user@1.1.1.1`
            - resolve ruri disabled => RURI will be `user@domain.com`
    Auth enabled
        Enable authorization for outgoing calls.
    Auth user
        This field should be filled by *username* for outgoing authorization on Gateway (in case of using Gateway as Terminator of calls). Field is used only in case of enabling "Auth enabled" flag.
        Call will be dropped in case of failed authorization on Gateway.
    Auth password
        This field should be filled by *password* for outgoing authorization on Gateway (in case of using Gateway as Terminator of calls). Field is used only in case of enabling "Auth enabled" flag.
        Call will be dropped in case of failed authorization on Gateway.
    Auth from user
        Should be used for filling header "From" of SIP header during authorization (user part).
    Auth from domain
        Should be used for filling header "From" of SIP header during authorization (domain part).
    Term use outbound proxy
        Use outbound proxy for termination.
    Term force outbound proxy
        Force usage of outbound proxy for termination.
    Term proxy transport protocol
        Transport protocol that is used for Termination proxy (User Datagram Protocol (UDP) or Transmission Control Protocol (TCP)).
    Term outbound proxy
        Outbound proxy address.
    Term next hop
        Network (IPv4 or IPv6) address or domain name that should be used as **SIP next hop** in case of using Gateway as Terminator of calls. If this field doesn't specified - **SIP next hop** will be defined automatically by routing rules.
    Term disconnect policy
        :ref:`Disconnect policy <disconnect_policy>` that is related to this Termination's attribute of the Gateway.
    Term append headers req
        Headers list to append to the INITIAL invite.
    Sdp alines filter type
        Filter type to process alines in SDP. possible values: Transparent, Blacklist, Whitelist.
    Sdp alines filter list
        SDP alines comma-separated list.

    .. _gateway_ringing_timeout:

    Ringing timeout
        Timeout between `18x` and `200 OK` responses.
        In case of timeout: routing attempt will be canceled.
        and further processing (attempt to reroute or give up) depends from disconnect policy.
    Allow 1xx without to tag
        Allows behavior, which violates RFC, when YETI will process 1xx responses without To-tag.
    Max 30x redirects
        Amount of 301/302 SIP redirects that are allowed by Yeti for this Gateway (in case of using Gateway as Terminator of calls). Calls won't be redirected in case of filling this field by 0 (zero) value.
    Max transfers
        Amount of SIP transfers that are allowed by Yeti for this Gateway (in case of using Gateway as Terminator of calls). Calls won't be transfered in case of filling this field by 0 (zero) value.
    Sip timer B
        Overwrites the value of SIP timer B (transaction timeout).
        Call can be rerouted if this allowed by disconnect policy configuration.
    Dns srv failover timer
        SIP timer M (INVITE retransmit) override. Must have value less than timer B.
        Call can be rerouted if this allowed by disconnect policy configuration.
    Suppress early media
	    Allows to send 180 Ringing message without SDP to LegA when received 180/183 with SDP from LegB of gateway.

    .. _gateway_fake_180_timer:

    Fake 180 timer
        Allows to set up timer for 183 SIP messages with SDP. If there is no 183 message during this timer, SEMS would send 180 message forsibly.
    Send lnp information
        If this checkbox is enabled (in case of using Gateway as Terminator of calls) Yeti will include Local number portability information (LNP) to the outgoing INVITE-request (by adding npdi and rn parameters to the R-URI) only in case of availability of this LNP information (it means if LNP information was successfully received from :ref:`LNP Database <lnp_databases>`). Rules of receiving LNP information from LNP Database are regulated in the :ref:`Routing plan LNP rules <routing_plan_lnp_rules>`.


Translations **Gateway**'s attributes:
``````````````````````````````````````
    Diversion policy
        Policy to process Diversion header.
    Diversion rewrite rule
        Regular expression pattern for Diversion.
    Diversion rewrite result
        Regular expression replacement for Diversion.
    Src name rewrite rule
        Regular expression pattern for From display-name part.
    Src name rewrite result
        Regular expression replacement for From display-name part.
    Src rewrite rule
        Regular expression pattern for From user part.
    Src rewrite result
        Regular expression replacement for From user part.
    Dst rewrite rule
        Regular expression pattern for To and RURI user part.
    Dst rewrite result
        Regular expression replacement for To and RURI user part.

Media **Gateway**'s attributes:
```````````````````````````````
    Sdp c location
        Location of connection-line in SDP payloads which are generated by YETI.
        Possible values:

            - On media level
            - On session level
            - On session and media level
    Codec group
        Codecs group which will be used to interact with this gateway.
    Anonymize sdp
        Anonymize client's SDP session data ( session name, uri, origin user ).
    Proxy media
        Determines RTP processing mode. Must be enabled to have possibility of transcoding.
    Single codec in 200ok
        If enabled, YETI will leave only once codec in responses with SDP
        (Exception is only telephone-event.
        It will be added anyway if received in SDP offer and present in codecs group for this gateway).
    Transparent seqno
        Transparent transmission of the RTP SEQ number on RTP relay.
    Transparent ssrc
        Transparent transmission of the RTP SSRC number on RTP relay.
    Force symmetric rtp
        Ignore remote address negotiated in SDP.
        Use address gained from first received RTP/RTCP packet.
    Symmetric rtp nonstop
        By default, YETI allows to change address by symmetric RTP only one time.
        This option allows to disable this limitation.
        If enabled, YETI will change destination address every time when receives RTP/RTCP packet from another source.
    Symmetric rtp ignore rtcp
        Disable symmetric RTP for RTCP packets.
    Rtp ping
        Useful for cases: when gateways with enabled symmetric RTP wait for first packet before start sending,
        but gateway on other side doing the same.
        If enabled, YETI will send fake RTP packet to the gateway right after stream initialization.
    Rtp timeout
        If set, call will be dropped with appropriate disconnect reason in CDR if no RTP arrived during this interval.
    Filter noaudio streams
        Cut all streams except of 'audio' from SDP in INVITE to the termination gateway.
        Appropriate non-audio streams will be automatically inserted as disabled (port set to zero)
        into responses to the gateway which sent offer to comply with RFC.
        Useful for gateways which processes multiple streams in SDP incorrectly or/and rejects INVITES with non-audio streams.
    Rtp relay timestamp aligning
        Normalize timestamp for RTP packets on RTP relay.
        Useful for cases on RTP relay when remote side changes RTP streams
        without appropriate signaling (RTP mark or/and re-INVITE)
        and destination equipment is not ready to process such behavior correctly.
    Rtp force relay CN
        If enabled, YETI will relay CN packets on even if they were not negotiated in SDP.
    Force one way early media
        If this checkbox is enabled Early Media (the ability of two SIP User Agents to communicate before a SIP call is actually established) will be blocked on the way from LegA (Originator) to LegB (Terminator) of the call. It helps to prevent fraud with using Early Media features for making non-billed calls.
    Rtp interface name
        Attribute that is used for changing RTP interface name in the SEMS (SIP Express Media Server) configuration file (sems.conf).

Dtmf **Gateway**'s attributes:
``````````````````````````````
    Force dtmf relay
        Don't process telephone-event (RFC2833) packets and relay them 'as is'.
    Dtmf send mode
        The way to send dtmf to remote gateway. possible values:

            - Disable sending
            - RFC 2833 (telephone-event)
            - SIP INFO application/dtmf-relay
            - SIP INFO application/dtmf
    Dtmf receive mode
        Allowed ways to receive DTMF from remote gateway. If the way is not allowed it will be ignored.
        Possible values:

            - RFC 2833 (telephone-event)
            - SIP INFO application/dtmf-relay OR application/dtmf
            - RFC 2833 OR SIP INFO

Radius **Gateway**'s attributes:
````````````````````````````````
    Radius accounting profile
       :ref:`Radius accounting profile <radius_accounting_profile>` that is related to this Gateway.

----

.. _disconnect_policy:

Disconnect policies
~~~~~~~~~~~~~~~~~~~

Disconnect policy allows to override system default actions for each SIP disconnect code per gateway (rerouting, codes/reasons rewriting). Sometimes it is useful for compatibility between different VoIP platforms.

**Disconnect policy**'s attributes:
```````````````````````````````````
    Id
        Unique Disconnect policy's id.
    Name
        Unique Disconnect policy's name.

----

Disconnect policies codes
~~~~~~~~~~~~~~~~~~~~~~~~~

Code's overriding scenarios that are used by :ref:`Disconnect policies <disconnect_policy>`. More than one scenario can be used with one :ref:`Disconnect policy <disconnect_policy>`.

**Disconnect policy code**'s attributes:
````````````````````````````````````````
    Id
        Unique Disconnect policy code's id.
    Policy
        :ref:`Disconnect policy <disconnect_policy>` that is related to this Code.
    Code
        SIP Response Codes that are specified in the `RFC 3261 -  SIP: Session Initiation Protocol <https://tools.ietf.org/html/rfc3261#section-21>`_.
    Stop hunting
        If this checkbox is enabled re-routing won't be done in case of receiving this SIP Code.
    Pass reason to originator
        If this checkbox is enabled the Reason (text of Response Code) will be transferred to Originator without changing, even if Code was changed by scenario.
    Rewrited code
        Response Code that will be transferred to Originator instead of original Code. If this field is empty - original Response Code will be transferred to Originator.
    Rewrited reason
        Response Reason that will be transferred to Originator instead of original (deafult) Reason. If this field is empty - original (default) Response Reason will be transferred to Originator, even if Code was changed by scenario.

----

Registrations
~~~~~~~~~~~~~

YETI allows to use outgoing SIP registrations on remote vendor's or customer's equipment.

**Registration**'s attributes:
``````````````````````````````
    Id
        Unique Registration's id.
    Name
	    Name of this registration.
    Enabled
        Disabled registrations will be ignored.
    Pop
        Point of presence for registration requests.
    Node
        Node which will hold registration.
    Transport protocol
        SIP transport protocol which will be used for send request.
    Domain
        RURI,From domain part.
    Username
        RURI,From user part.
    Display username
        From display name part.
    Auth user
        Authorization username.
    Auth password
        Authorization password.
    Proxy
        SIP Proxy to use for registration.
    Proxy transport protocol
        SIP transport protocol which will used for interaction with proxy.
    Contact
        Contact header. Should be in a SIP-URI format.
    Expire
        Registration expiration time.
    Force expire
        Force re-registration after **Expire** interval even is server set another value in response.
    Retry delay
	    Set the delay before sending a new REGISTER request to a registrar, when received error code or timeout occured.
    Max attempts
	    Maximum amount of attempts for sending a REGISTER request, when an error code received from a registrar or timeout occured. In order to re-enable attempts of registration, you should disable the registration and then enable again.

----

Codec groups
~~~~~~~~~~~~

Codec groups allows to create arbitrary sets of media codecs and applies them to the Gateways. Groups can differ in the composition of codecs, their priority and traffic codes, which allows to process different scenarios when processing calls.

**Codec group**'s attributes:
`````````````````````````````
    Id
        Unique Codec group's id.
    Name
        Codec group's name.
    Codecs
        Each codec has the following attributes:

            Codec
                Codec's name. All available codecs are presented in drop-down list.
            Priority
                Codec priority in SDP. Less value means higher priority.
                Must be unique within group.
            Dynamic payload type
                Payload type override (allowed only values from dynamic range).
            Format parameters
                Non-standard value for fmt param SDP attribute.

----

.. _lnp_databases:

LNP databases
~~~~~~~~~~~~~
see https://en.wikipedia.org/wiki/Local_number_portability

Yeti supports interaction with LNP databases by SIP and HTTP REST protocols.
We welcome requests to implement additional protocols or LNP database specific formats.

**LNP database**'s attributes:
``````````````````````````````

    .. _lnp_database_id:

    Id
        Unique LNP database's id.
    Name
        Database name. Unique field.
    Driver
        Driver which will be used. Available options:
            UDP SIP 301/302 redirect
            thinQ RESR LRN driver
            In-memory hash
    Host
        Database host (will be ignored by In-memory hash driver).
    Port
        Database port.
    Timeout
        Maximum time to wait for response from database.
        Request will fail with appropriate code and reason.
    Thinq username
        Authorization username for thinQ API.
    Thinq token
        Authorization token for thinQ API.
    Csv file
        Path to the file with data to preload (for In-memory hash driver only).

----

RADIUS Auth Profiles
~~~~~~~~~~~~~~~~~~~~

Yeti supports additional authorization of incoming call on external RADIUS (Remote Authentication Dial-In User Service) server. RADIUS Auth Profile describes communication with that server.

.. note:: module **radius_client** should be loaded to use such feature

**RADIUS Auth Profile**'s attributes:
`````````````````````````````````````
    Id
        Unique RADIUS Auth Profile's id.
    Name
        Unique name of Auth profile.
        Uses for informational purposes and doesn't affect system behaviour.
    Server
        IP address or hostname of external RADIUS server.
    Port
        UDP port on which RADIUS server wait for requests.
    Secret
        Password for Authorization procedure on external RADIUS server.
    Reject on error
        If enabled, in case of error in communication with external RADIUS server (timeout, bad format of response, etc) a call will be considered as authorized and YETI will do further routing procedure.
        If disabled, in case of error in communication with external RADIUS server (timeout, bad format of response, etc) a call will be discarded with appropriate code.
    Timeout
        Timeout of request after which a request will be repeated (millisecond).
    Attempts
        Maximum amount of of requests for every call.

.. _auth_profile_attributes:

    Auth profile attributes
        RADIUS Attributes for including specific authentication, authorization, information and configuration details to the requests and replies. General amount of attributes is regulated by total length of the RADIUS packet (see: `RFC 2865:   Remote Authentication Dial In User Service (RADIUS) <https://tools.ietf.org/html/rfc2865>`_).

        -   Type
            The Type of the RADIUS attribute (decimal value between 0 and 255). Regarding to the `RFC 2865:  Remote Authentication Dial In User Service (RADIUS) <https://tools.ietf.org/html/rfc2865>`_ values 192-223 are reserved for experimental use, values 224-240 are reserved for implementation-specific use, and values 241-255 are reserved and should not be used. A RADIUS server and client MAY ignore Attributes with an unknown Type.
        -   Name
            Name of attribute. It uses for information only and doesn't transfer in the RADIUS packet.
        -   Is vsa
            If this checkbox is enabled it indicates that it is Vendor Specific Attribute and doesn't described by `RFC 2865 -  Remote Authentication Dial In User Service (RADIUS) <https://tools.ietf.org/html/rfc2865>`_.
        -   Vsa vendor
            Decimal value (between 0 and (2^32 - 1)) of the Vendor's ID in the attribute. In the `RFC 2865 -  Remote Authentication Dial In User Service (RADIUS) <https://tools.ietf.org/html/rfc2865>`_ - the high-order octet is 0 and the low-order 3 octets are the SMI Network Management Private Enterprise Code of the Vendor in network byte order.
        -   Vsa vendor type
            Decimal value (between 0 and 255) of the specific Vendor type of attribute.
        -   Value
            String that is used as template for filling value of RADIUS Attribute with using pre-defined placeholders (variables) that are described in note bellow. It is possible to combine several placeholders together with pre-defined text to one string. Resulting value will be converted to the data of necessary *Format* (see below). In case of impossibility to convert resulting value to necessary *Format* an error will be occurred.

        .. note:: Example of filling *Value* field: Destination ID: $destination_id$ ; DialPeer ID: $dialpeer_id$

        -   Format
            The resulting format of the *Value* field. It is one of six data types: string (1-253 octets containing binary data (values 0 through 255 decimal, inclusive) - often used for printable text strings), octets (1-253 octets containing binary data (values 0 through 255 decimal, inclusive) - often used for binary data), ipaddr (32 bit value, most significant octet first), integer (32 bit unsigned value, most significant octet first), date (32 bit unsigned value, most significant octet first -- seconds since 00:00:00 UTC, January 1, 1970), ip6addr (128 bit value, most significant octet first).
        -   Remove
            This control element can be used for removing existing Auth profile attribute. Auth profile attribute will be removed after saving changes (by clicking Update Auth profile) in case of enabling this checkbox.


    .. note:: Currently following variables (placeholders) are supported in the Yeti's auth profiles:

       -    $src_number_radius$ - Source (A) number (string) of current call.
       -    $dst_number_radius$ - Destination (B) number (string) of current call.
       -    $orig_gw_name$ - Value of the :ref:`*Name* <gateway_name>` attribute (string) of Gateway that is used as Originator for current call.
       -    $customer_auth_name$ - Value of the :ref:`*Name* <customer_auth_name>` attribute (string) of the Customer Auth.
       -    $customer_name$ - Value of the :ref:`*Name* <contractor_name>` attribute (string) of the Customer Contractor.
       -    $customer_account_name$ - Value of the :ref:`*Name* <account_name>` attribute (string) of Account that is associated with Customer for current call.
       -    $term_gw_name$ - Value of the :ref:`*Name* <gateway_name>` attribute (string) of Gateway that is used as Terminator for current call.
       -    $orig_gw_external_id$ - Value of the :ref:`*External* <gateway_external>` attribute (integer) of Gateway that is used as Originator for current call.
       -    $term_gw_external_id$ - Value of the :ref:`*External* <gateway_external>` attribute (integer) of Gateway that is used as Originator for current call.
       -    $fake_180_timer$ - Value (in ms) of the :ref:`*Fake 180 timer* <gateway_fake_180_timer>` attribute (integer) of Gateway that is used as Terminator for current call.
       -    $customer_id$ - Value of the :ref:`*ID* <contractor_id>` attribute (integer) of the Customer Contractor for current call.
       -    $vendor_id$ - Value of the :ref:`*ID* <contractor_id>` attribute (integer) of the Vendor Contractor for current call.
       -    $customer_acc_id$ - Value of the :ref:`*ID* <account_id>` attribute (integer) of Account that is associated with Customer for current call.
       -    $vendor_acc_id$ - Value of the :ref:`*ID* <account_id>` attribute (integer) of Account  that is associated with Vendor for current call.
       -    $customer_auth_id$ - Value of the :ref:`*ID* <customer_auth_id>` attribute (integer) of the Customer Auth.
       -    $destination_id$ - Value of the :ref:`*ID* <destination_id>` attribute (integer) of the Destination for current call.
       -    $destination_prefix$ - Value of the :ref:`*Prefix* <destination_prefix>` attribute (string) of the Destination for current call.
       -    $dialpeer_id$ - Value of the :ref:`*ID* <dialpeer_id>` attribute (integer) of the Dialpeer for current call.
       -    $dialpeer_prefix$ - Value of the :ref:`*Prefix* <dialpeer_prefix>` attribute (string) of the Dialpeer for current call.
       -    $orig_gw_id$ - Value of the :ref:`*ID* <gateway_id>` attribute (integer) of Gateway that is used as Originator for current call.
       -    $term_gw_id$ - Value of the :ref:`*ID* <gateway_id>` attribute (integer) of Gateway that is used as Terminator for current call.
       -    $routing_group_id$ - Value of the :ref:`*ID* <routing_group_id>` attribute (integer) of Routing Group for current call.
       -    $rateplan_id$ - Value of the :ref:`*ID* <rateplan_id>` attribute (integer) of Rateplan for current call.
       -    $destination_initial_rate$ - Value of the :ref:`*Initial Rate* <destination_initial_rate>` attribute (floating point number) of Destination for current call.
       -    $destination_next_rate$ -  Value of the :ref:`*Next Rate* <destination_next_rate>` attribute (floating point number) of Destination for current call.
       -    $destination_initial_interval$ - Value of the :ref:`*Initial Interval* <destination_initial_interval>` attribute (floating point number) of Destination for current call.
       -    $destination_next_interval$ - Value of the :ref:`*Next Interval* <destination_next_interval>` attribute (floating point number) of Destination for current call.
       -    $destination_rate_policy_id$ - Value of the :ref:`*Rate policy* <rate_policy_id>` attribute (integer) of Destination for current call (1 - Fixed, 2 - Based on used dialpeer, 3 - MIN(Fixed,Based on used dialpeer), 4 - MAX(Fixed,Based on used dialpeer)).
       -    $dialpeer_initial_interval$ - Value of the :ref:`*Initial Interval* <dialpeer_initial_interval>` attribute (floating point number) of Dialpeer for current call.
       -    $dialpeer_next_interval$ - Value of the :ref:`*Next Interval* <dialpeer_next_interval>` attribute (floating point number) of Dialpeer for current call.
       -    $dialpeer_next_rate$ - Value of the :ref:`*Next Rate* <dialpeer_next_rate>` attribute (floating point number) of Dialpeer for current call.
       -    $destination_fee$ - Value of the :ref:`*Connect fee* <destination_connect_fee>` attribute (floating point number) of Destination for current call.
       -    $dialpeer_initial_rate$ - Value of the :ref:`*Initial Rate* <dialpeer_initial_rate>` attribute (floating point number) of Dialpeer for current call.
       -    $dialpeer_fee$ - Value of the :ref:`*Connect fee* <dialpeer_connect_fee>` attribute (floating point number) of Dialpeer for current call.
       -    $dst_prefix_in$ - Destination number (B-number) that is received from Gateway that is used as Originator for current call (string).
       -    $dst_prefix_out$ - Destination number (B-number) that is sent to Gateway that is used as Terminator for current call (string).
       -    $src_prefix_in$ - Source number (A-number) that is received from Gateway that is used as Originator for current call (string).
       -    $src_prefix_out$ - Source number (A-number) that is sent to Gateway that is used as Terminator for current call (string).
       -    $src_name_in$ - Name of caller that is received in the "From" field of SIP header from Gateway that is used as Originator for current call (string).
       -    $src_name_out$ - Name of caller that is sent in the "From" field of SIP header to Gateway that is used as Terminator for current call (string).
       -    $diversion_in$ - Value of SIP Diversion header that is received from Gateway that is used as Originator for current call (string).
       -    $diversion_out$ - Value of SIP Diversion header that is sent to Gateway that is used as Terminator for current call (string).
       -    $auth_orig_protocol_id$ - Protocol (integer) that is used for interconnection with Gateway that is used as Originator for current call (1 - UDP, 2 - TCP).
       -    $auth_orig_ip$ - IP-address of Gateway (that was received during SIP AUTH stage) that is used as Originator for current call (string).
       -    $auth_orig_port$ - TCP or UDP port number that was used for sending of signaling information from Gateway that is used as Originator for current call (integer).
       -    $dst_country_id$ - Value of the :ref:`*ID* <country_id>` attribute (integer) of Country that is associated (via  Network Prefixes table) with the destination number (B-number) for current call.
       -    $dst_network_id$ - Value of the :ref:`*ID* <network_id>` attribute (integer) of Network that is associated (via  Network Prefixes table) with the destination number (B-number) for current call.
       -    $dst_prefix_routing$ - Prefix of the destination number (B-number) that was used for routing  for current call.
       -    $src_prefix_routing$ - Prefix of the source number (A-number) that was used for routing  for current call.
       -    $routing_plan_id$ - Value of the :ref:`*ID* <routing_plan_id>` attribute (integer) of Routing Plan for current call.
       -    $lrn$ - Routing number that was received from LNP database (in case of requesting) for current call.
       -    $lnp_database_id$ - Value of the :ref:`*ID* <lnp_database_id>` attribute (integer) of LNP Database that is used for current call.
       -    $from_domain$ - Domain of caller that is received in the "From" field of SIP header from Gateway that is used as Originator for current call (string).
       -    $to_domain$ - Domain of callee that is received in the "To" field of SIP header from Gateway that is used as Originator for current call (string).
       -    $ruri_domain$ - Domain that is received in the "R-URI" field of SIP header from Gateway that is used as Originator for current call (string).
       -    $src_area_id$ - Value of the :ref:`*ID* <area_id>` attribute (integer) of Area that is associated (via  Area Prefixes table) with the source number (A-number) for current call.
       -    $dst_area_id$ - Value of the :ref:`*ID* <area_id>` attribute (integer) of Area that is associated (via  Area Prefixes table) with the destination number (B-number) for current call.
       -    $routing_tag_id$ - Value of the :ref:`*ID* <routing_tag_id>` attribute (integer) of Routing tag that is associated (via Routing tag detection table) with both source and destination Areas for current call.
       -    $pai_in$ - P-Asserted-Identity (PAI) privacy field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $ppi_in$ - P-Preferred-Identity (PPI) privacy field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $privacy_in$ - SIP Privacy field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $rpid_in$ - Remote Party ID field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $rpid_privacy_in$ - SIP RPID Privacy field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $pai_out$ - P-Asserted-Identity (PAI) privacy field of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $ppi_out$ - P-Preferred-Identity (PPI) privacy field of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $privacy_out$ - SIP Privacy field of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $rpid_out$ - Remote Party ID field of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $rpid_privacy_out$ - SIP RPID Privacy of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $customer_acc_check_balance$ - State of :ref:`*Check account balance* <customer_check_account_balance>` flag (0 - disabled, 1 - enabled) of Customers Auth for current call.
       -    $destination_reverse_billing$ - State of :ref:`*Reverse billing* <destination_reverse_billing>` flag (0 - disabled, 1 - enabled) of Destination for current call.
       -    $dialpeer_reverse_billing$ - Value of the :ref:`*Reverse billing* <dialpeer_reverse_billing>` attribute (boolean) of Dialpeer for current call.

    To enable additional RADIUS authorization you should set Radius Auth Profile at Customer Auth object.

.. note:: YETI doesn't support interaction with external routing engines via RADIUS protocol.

----

.. _radius_accounting_profile:

RADIUS Accounting Profiles
~~~~~~~~~~~~~~~~~~~~~~~~~~

Yeti supports additional accounting of calls on external RADIUS server. RADIUS Accounting Profile describes communication with that server.

**RADIUS Accounting Profile**'s attributes:
```````````````````````````````````````````
    Id
       Unique RADIUS Accounting Profile's id.
    Name
        Unique name of Accounting profile.
        Uses for informational purposes and doesn't affect system behaviour.
    Server
        IP address or hostname of external RADIUS server.
    Port
        UDP port on which RADIUS server wait for requests.
    Secret
        Password for Authorization procedure on external RADIUS server.
    Timeout
        Timeout of request after which a request will be repeated (millisecond).
    Attempts
        Maximum amount of of requests for every call.
    Enable start accounting
        If enabled, YETI will send Start-accounting packets to external RADIUS server.
    Enable interim accounting
        If enabled, YETI will send Interim-accounting packets to external RADIUS server.
    Interim accounting interval
        Send Interim packets to external RADIUS server every **interval** seconds.
    Enable stop accounting
        If enabled, YETI will send Stop-accounting packets to external RADIUS server.
    Start packet attributes
        RADIUS Attributes for including specific authentication, authorization, information and configuration details into **Start-accounting packets**. Description of fields, principles of their filling and description of placeholders that can be used as variables in the *value* filed are described in the :ref:`Auth profile attributes <auth_profile_attributes>` section.
    Interim packet attributes
        RADIUS Attributes for including specific authentication, authorization, information and configuration details into **Interim packet attributes**. Description of fields, principles of their filling and description of placeholders that can be used as variables in the *value* filed are described in the :ref:`Auth profile attributes <auth_profile_attributes>` section.
    Stop packet attributes
        RADIUS Attributes for including specific authentication, authorization, information and configuration details into **Stop packet attributes**. Description of fields, principles of their filling and description of placeholders that can be used as variables in the *value* filed are described in the :ref:`Auth profile attributes <auth_profile_attributes>` section.
