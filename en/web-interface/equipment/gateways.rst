
.. _gateways:

Gateways
~~~~~~~~

Gateways are used for configuring parameters of sending VoIP traffic to the Vendor.
For configure *Gateway* it is necessary to configure :ref:`Contractor's <contractors>` record. Also it is necessary to choose some :ref:`Codec group <codec_groups>`.

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

    .. _gateway_enabled:

    Enabled
        Disabled gateways will be ignored.

    .. _gateway_contractor:

    Contractor
        Gateway's owner.

    .. _gateway_is_shared:

    Is shared       
        Allows *Gateway* to be used as origination equipment for any customer or as termination equipment for any vendor.
    Gateway group
        Gateways can be grouped.
        Choose group from the list to add gateway to the group.
        Gateways groups can be managed at *Billing->Gateway Groups*.

    .. _gateway_priority:

    Priority
        Gateway priority in the gateway group.
        In case of termination to the group, gateways will be arranged according to this priority. If few gateways have same priority, calls will be  balanced between them.

    .. _gateway_weight:

    Weight
         Value of this field (numeric) is used during randomized making decision about *Gateway* that will be used for  routing the call in case of selecting :ref:`Gateway group <gateway_groups>` that contains two or more *Gateways* with same :ref:`Priority <gateway_priority>`. Probability to choose the *Gateway* is bigger for routes where *Weight* value is bigger.


    .. note:: Example:

       During routing algorithm :ref:`Dialpeer <dialpeers>` that is associated with :ref:`Gateway group A <gateway_groups>` was selected.  At same time :ref:`Gateway group A <gateway_groups>` contains four *Gateway*'s records:

            -   Gateway 1 (Priority 100, Weight 0);
            -   Gateway 2 (Priority 101, Weight 40);
            -   Gateway 3 (Priority 101, Weight 50);
            -   Gateway 4 (Priority 101, Weight 10).

        The algorithm of sorting *Gateways* (within selected :ref:`Dialpeer <dialpeers>`) for terminating the call will consist from the following steps:

        1.  With using generator of random numbers the first *Gateway* will be selected from the *Gateways* with same (biggest) priorities. Because Gateway 2, Gateway 3 and Gateway 4 have biggest priority (101) they will be used for choosing three first possible termination *Gateways*. For example: the probability of choosing Gateway 3 is 50% (via relation of weight value for the Gateway 2 to the sum of weights of all Gateways with same priorities (50/(40+50+10)*100% = 50%)); the probability of choosing Gateway 2 is 40%; and the probability of choosing Gateway 4 is 10%.
        2.  In case of choosing (by generator of random numbers) Gateway 3 it will be put on the top of rating for the selected :ref:`Dialpeer <dialpeers>`. The second Gateway will be chosen between Gateway 2 or Gateway 4. During this choosing probabilities will be recalculated without already chosen Gateway. For example: the probability of choosing Gateway 2 is 80% (via relation of weight value for the Gateway 2 to the sum of weights of all rest Gateways with same priorities (40/(40+10)*100% = 80%)); the probability of choosing Gateway 4 is 20%.
        3.  In case of choosing (by generator of random numbers) Gateway 2 this Gateway will be put on the second place of rating (for the selected :ref:`Dialpeer <dialpeers>`) and Gateway 4 will be put on the third place of rating.
        4.  On the last (fourth) place of rating will be Gateway 1 because it has lowest priority 100.

        The final view of Gateway's rating in our example could be following:

        1.  Gateway 3
        2.  Gateway 2
        3.  Gateway 4
        4.  Gateway 1

    .. _gateway_pop:

    Pop
        Point of Presence of the gateway. Allows forcing prioritization based on gateway location depending on :ref:`Balancing mode <gateway_group_balancing_mode>` chosen for gateway group.
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
         Transport protocol that is used for Origination proxy (User Datagram Protocol (UDP) or Transmission Control Protocol (TCP)).
    Orig outbound proxy
       SIP Uniform Resource Indicator (URI) of SIP proxy for Gateway (in case of using Gateway as Originator of calls).
    Transparent dialog
        Not used yet.
    Dialog nat handling
       In case of enabling this field Yeti learns the proper remote address (port, transport,...) from the received message and uses that in following in-dialog requests. Enable this option when handling far end NATs.
    Orig disconnect policy
        :ref:`Disconnect policiy <disconnect_policy>` that is related to this Origination's attribute of the Gateway.

.. _incoming_auth_params:

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
       .. seealso:: SEMS interfaces should be properly configured , see :ref:`SEMS signaling interfaces configuration <sems_signaling_interfaces>`
       
    Host
        IP address or DNS name of remote gateway to send SIP signaling (only for termination).
    Port
        Port of remote gateway to send SIP signaling.
        Leave it empty to enable DNS SRV resolving of name in **Host**.
    Use registered aor
        Used for gateway with dynamic IP address (for termination only). YETI sends call to R-URI received from remote UA during registration procedure. For incoming REGISTER request authentification YETI uses credentials specified in :ref:`Incoming auth username <incoming_auth_params>` and :ref:`Incoming auth password <incoming_auth_params>` fields.
    Resolve ruri
        Indicates necessity to rewrite R-URI domain part with resolved IP

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

    .. _gateways_number_translation:
        
Translations **Gateway**'s attributes:
``````````````````````````````````````
    Diversion policy
        Policy to process Diversion header.
    Diversion rewrite rule
        Regular expression pattern for Diversion.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Diversion rewrite result
        Regular expression replacement for Diversion.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src name rewrite rule
        Regular expression pattern for From display-name part.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src name rewrite result
        Regular expression replacement for From display-name part.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src rewrite rule
        Regular expression pattern for From user part.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src rewrite result
        Regular expression replacement for From user part.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst rewrite rule
        Regular expression pattern for To and RURI user part.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst rewrite result
        Regular expression replacement for To and RURI user part.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

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
        Allows to force **Media interface** that will process RTP traffic from/to gateway. Interface with such name should be defined at :doc:`SEMS configuration <../../sems/index>`
        
    Media encryption mode
        Defines RTP encryption mechanism, possible values:
            
            - Disable - Plain RTP will be used(no encryption)
            - SRTP SDES - SRTP with `SDES <https://en.wikipedia.org/wiki/SDES>`_ key negotiation mechanism. In this mode SRTP keys will be sent in SIP SDP payload so it is important to secure SIP signalling by TLS or other secure transport.
            - SRTP DTLS - SRTP with `DTLS <https://en.wikipedia.org/wiki/Datagram_Transport_Layer_Security>`_ key negotiation mechanism. DTLS is RTP inband mechanism and it doesn't requeire secured SIP signalling.
            - SRTP ZRTP - SRTP with `ZRTP <https://en.wikipedia.org/wiki/ZRTP>`_ key negotiation mechanism. ZRTP is not standard but sill widely used.
        
        .. seealso:: SEMS should be properly configured to support SRTP, see :ref:`SEMS media interfaces configuration <sems_media_interfaces>`
    

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

    .. _rx_inband_dtmf_filtering_mode:

    Rx inband dtmf filtering mode
        Could be used for setting mode of processing of the inband DTMF signals (DTMF audio tones in the RTP stream) in the incoming RTP-flow that is received from this *Gateway*. Could have following values:

        -   Inherit configuration from other call's leg. Will be used :ref:`Tx inband dtmf filtering mode <tx_inband_dtmf_filtering_mode>` value from the *Gateway* that is associated with other call leg. F.e. for termination Gateway - value from origination Gateway will be used.
        -   Disable. DTMF signals will be ignored and will be forwarded as is.
        -   Remove DTMF. DTMF signals will be replaced by "silence" signal in the incoming RTP-flow that is received from this *Gateway*.


    .. _tx_inband_dtmf_filtering_mode:


    Tx inband dtmf filtering mode
        Could be used for setting mode of processing of the inband DTMF signals (DTMF audio tones in the RTP stream) in the outgoing RTP-flow that will be sent to this *Gateway*. Could have following values:

        -   Inherit configuration from other call's leg. Will be used :ref:`Rx inband dtmf filtering mode <rx_inband_dtmf_filtering_mode>` value from the *Gateway* that is associated with other call leg. F.e. for termination Gateway - value from origination Gateway will be used.
        -   Disable. DTMF signals will be ignored and will be forwarded as is.
        -   Remove DTMF. DTMF signals will be replaced by "silence" signal in the outgoing RTP-flow that will be sent to this *Gateway*.

     .. note::

        This features (Rx/Tx inband dtmf filtering mode) are useful when it necessary to remove DTMF transmission, or when remote Gateway sends DTMF to both inband and as RTP-event simultaneously. Enabling the corresponding function will remove duplicate information from inband.


Radius **Gateway**'s attributes:
````````````````````````````````
    Radius accounting profile
       :ref:`Radius accounting profile <radius_accounting_profile>` that is related to this Gateway.

