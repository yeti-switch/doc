
.. |br| raw:: html

   <br />

.. _gateways:

========
Gateways
========

Gateway object defines SIP and RTP stacks behavior for interaction with remote systems. Gateway that defines LegA behavior called origination gateway. Gateway that defines LegB behavior called termination gateway. 



.. mermaid::

    graph LR
        gw1[Call originator]
        gw2[Termination provider]
               
        
        gw1 -->|legA SIP initial INVITE| sip-session1
        sip-session2 -->|legB SIP initial INVITE| gw2
        
        gw1 <-->|RTP| media-session1
        media-session2 <-->|RTP| gw2
        
        sip-session1 <--> sip-session2
        media-session1 <--> media-session2
        
        subgraph yeti[Yeti SBC]
            subgraph gw1-conf[Origination gateway]
                sip-session1
                media-session1
            end
            subgraph gw2-conf[Termination gateway]
                sip-session2
                media-session2
            end
        end
        




For configure gateway it is necessary to configure :ref:`Contractor's <contractors>` record. Also it is necessary to choose some :ref:`Codec group <codec_groups>`.

General attributes
==================

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
    Concurrent calls limit for this gateway when it acts as origination gateway.
        
.. note:: When Origination gateway capacity/CPS overloaded system will reject call. CDR will be saved.
        
Termination capacity
    Concurrent calls limit for this gateway when it acts as termination gateway.
        
Termination subscriber capacity
    How many concurrent calls allowed to single destination number via this gateway.
        
Termination CPS limit
    How many new calls allowed within **Termination CPS wsize** interval via this gateway.

Termination CPS wsize
    Window size for **Termination CPS limit** in seconds.

Termination subscriber CPS limit
    How many new calls allowed within **Termination subscriber CPS wsize** time interval via this gateway to single destination number.

Termination subscriber CPS wsize
    Window size for **Termination subscriber CPS limit** in seconds.
        
.. note:: When termination gateway capacity/CPS overloaded system will try to reroute call to other routes if possible.
        
.. warning:: **Termination subscriber capacity**, **Termination CPS limit**, **Termination subscriber CPS limit** are experimental features and not enabled by default.
        
    
        
Acd limit
    ACD threshold. If ACD for gateway traffic is below the threshold, the Dialpeers that are used by this Gateway will be excluded from the routing in case of usage of routing plan with **ACD&ASR control**.
Asr limit
    ASR threshold. If ASR for gateway traffic is below the threshold, the Dialpeers that are used by this Gateway will be excluded from the routing in case of usage of routing plan with **ACD&ASR control**.
Short Calls limit
    Threshold percentage of Short Calls. If the current value is below the threshold, the Dialpeers that are used by this Gateway will be excluded from the routing in case of usage of routing plan with **ACD&ASR control**.


SST attributes
==============

SST is SIP session timers


SST Enabled
    Force to use SIP Session Timers, otherwise SST usage will be controlled by signaling of the remote gateway.
        
SST Session Expires
    Default value (in seconds) of Expires header for SIP session timers mechanism.
        
SST Minimum timer
    Minimum value (in seconds) of SIP Session Timer that will be accepted by Yeti.
        
SST Maximum timer 
    Maximum value (in seconds) of SIP Session Timer that will be accepted by Yeti.
        
Session refresh method
    - **Invite** - re-INVITE request will be used for a periodic refresh of SIP sessions.
    - **Update Request** - UPDATE request will be used for a periodic refresh of SIP sessions.
    - **Update Request and Invite if unsupported** - UPDATE request will be used for a periodic refresh of SIP sessions only in case of supporting UPDATE by remote side (it is included into Allow header), otherwise re-INVITE request will be used.
    
SST Accept501
    If it is enabled Yeti won't terminate a call in case of receiving "501 Not Implemented" on the answer on UPDATE request, otherwise call will be terminated in case of receiving "501 Not Implemented" from remote side.

Read more: `RFC 4028 Session Timers in the Session Initiation Protocol (SIP) <https://tools.ietf.org/html/rfc4028>`_

Sensor attributes
=================

Sensor level
    Traffic mirroring mode. Possible values:
        
        - Signaling
        - RTP
        - Signaling + RTP
Sensor
    Sensor to mirror traffic. Mirroring is disabled if not set.

Signaling attributes
====================

Relay options
    Transparent relay of In-dialog OPTIONS between call legs.
        
Relay reinvite
    Transparent relay of In-dialog re-INVITE between call legs.
        
Relay hold
    Transparent relay of In-dialog re-INVITE with hold/unhold requests between call legs.

Relay PRACK
    Transparent relay of In-dialog PRACK between call legs.
        
Rel100 mode
    Reliability of Provisional Responses mechanism mode. Read more in `RFC 3262 <https://datatracker.ietf.org/doc/html/rfc3262>`_. Possible values:
        
        - Disabled
            * Reply with *420 Bad Extension* if *100rel* required and ignore it if supported in incoming INVITE.
            * Ignore 100rel related headers.
        - Supported
            * Add *100rel* to *Supported* header for outgoing INVITE requests.
            * Process extension related things according to RFC 3262.
        - Supported not announced
            * Doesn't add *100rel* to any header for outgoing INVITE requests,
              but enables *100rel* processing if reply contains *100rel* in *Require* header.
            * Process extension related things according to RFC 3262.
        - Require
            * Add *100rel* to *Require* header for outgoing INVITE requests.
            * Reply with *421 Extension Required* if *100rel* is not supported or required in incoming INVITE.
            * Hangup session if no *Rseq* in incoming reply.
            * Process extension related things according to RFC 3262.
        - Ignored - Completely ignore any headers related to 100rel extension.
                
Relay UPDATE
    Transparent relay of SIP UPDATE between call legs.
        
Transit headers from origination
    Filter of headers in SIP requests which applies to originated calls. Look at :ref:`headers filtering <headers_fitering>`.
        
Transit headers from termination
    Filter of headers in SIP requests which applies to terminated calls. Look at :ref:`headers filtering <headers_fitering>`.
        
Sip interface name
    SEMS interface to use for SIP communications. It might be useful to force specific IP address for SIP transport.
        
.. seealso:: SEMS interfaces should be properly configured , see :ref:`SEMS signaling interfaces configuration <sems_signaling_interfaces>`

Signaling (Origination) attributes
==================================

Orig next hop
    Network (IPv4 or IPv6) address or domain name that should be used as **SIP next hop** in case of using Gateway as Originator of calls. If this field doesn't specified - **SIP next hop** will be defined automatically by routing rules.
        
Orig append headers req
    Additional SIP headers that Yeti should add to request to the Gateway (in case of using Gateway as Originator of calls). Additional header fields are lines composed of a header name, followed by a colon (:), followed by a header value, and separated by newline.

Orig use outbound proxy
    In case of enabling this checkbox Yeti will change destination of sending packets on Leg_A for initial SIP-requests to the address (URI) that is mentioned in the **Orig outbound proxy** field below.
        
Orig force outbound proxy
    In case of enabling this checkbox Yeti will change destination of sending packets on Leg_A for in-dialog SIP-requests to the address (URI) that is mentioned in the *Orig outbound proxy* field below.
        
Orig proxy transport protocol
    Transport protocol that is used for communication with Origination proxy.
         
Orig outbound proxy
    SIP URI of SIP proxy for Gateway (in case of using Gateway as Originator of calls).
       
Transparent dialog
    Not used yet.
        
Dialog nat handling
    In case of enabling this field Yeti learns the proper remote address (port, transport,...) from the received message and uses that in following in-dialog requests. Enable this option when handling far end NATs.
       
Orig disconnect policy
    :ref:`Disconnect policiy <disconnect_policy>` that is related to this Origination's attribute of the Gateway.

.. _incoming_auth_params:

Incoming auth username
    Username for additional username/password authentication of incoming requests if required.
        
Incoming auth password
    Password for additional username/password authentication of incoming requests.
    
.. warning:: It is **strongly** recommended to use build-in random generator for both username and password. You should not use usernames that looks like phone numbers.

.. warning:: **Incoming auth username** and **Incoming auth password** will enable incoming INVITE and REGISTER requests username/password authentication procedure. INVITE request username/password authentication is additional step(after IP authentication) and it should be enabled in **Customer Auth**, see :ref:`Require incoming auth <require_incoming_auth>`. For REGISTER requests authentication applied automatically.
        
        

.. _gateway_signaling_termination:

Signaling (Termination) attributes
==================================

Settings in this sections only works when gateways acts as termination gateway for call.


Dump Level
    Dump Level for call tracing mechanism. Read more in :ref:`Call tracing feature documentation <troubleshooting_tracing>`.

Transport protocol
    Transport protocol that is used
       
Host
    IP address or DNS name of remote gateway to send SIP signaling (only for termination).
        
Port
    Port of remote gateway to send SIP signaling.
    Leave it empty to enable DNS SRV resolving of name in **Host**.
        
Registered aor mode
    Used for call termination to gateways with dynamic IP addresses. When enabled YETI sends call to R-URI received from remote UA(in Contact header) during registration procedure. For incoming REGISTER request authentication YETI uses credentials specified in :ref:`Incoming auth username <incoming_auth_params>` and :ref:`Incoming auth password <incoming_auth_params>` fields.
        
    Supported modes:
        
        - **Do not use** - feature disabled. INVITE will be sent do static IP/DNS name defined in **Host**
        - **Use AOR as is** - INVITE R-URI will be set to Contact received during registration procedure.
        - **Use AOR, replace userpart with dst number** - INVITE R-URI will be set to Contact, but user-part will be replaced with destination number. This mode is useful when remote system send maintain single registration but expect to receive call to multiple DST numbers(in R-URI).
        
Resolve ruri
    Indicates necessity to rewrite R-URI domain part with resolved IP

    for example: `domain.com` has IP 1.1.1.1 and you set **Host** to `domain.com`:

        - resolve ruri enabled => RURI will be `user@1.1.1.1`
        - resolve ruri disabled => RURI will be `user@domain.com`
            
Auth enabled
    Enable authorization for outgoing calls when remote peer require it(using 401 or 407 SIP responses)
        
Auth user
    Username provided by remote peer.
        
Auth password
    Password provided by remote peer.
        
Auth from user
    Should be used for filling header "From" of SIP header during authorization (user part).
        
Auth from domain
    Should be used for filling header "From" of SIP header during authorization (domain part).
        
Term use outbound proxy
    Use outbound proxy for termination.
        
Term force outbound proxy
    Force usage of outbound proxy for termination.
        
Term proxy transport protocol
    Transport protocol that is used for communication with Termination proxy.
        
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

A-lines filtering mechanism allows to filter SDP A-lines received sent to gateway.

.. mermaid::

    flowchart LR

        gw1[Call originator]

        subgraph yeti[Yeti SBC]
            direction BT
            subgraph gw1-conf[Origination gateway]
                filter1
            end
            subgraph gw2-conf[Termination gateway]
                filter2
            end
            gw1-conf ~~~ gw2-conf
        end

        gw2[Termination provider]

        gw1 -->|legA SDP Offer| filter2
        filter2 -->|legB SDP Offer| gw2

        gw2 -->|legB SDP Answer| filter1
        filter1 -->|legA SDP Answer| gw1



.. _gateway_ringing_timeout:

Ringing timeout
    Timeout between `18x` and `200 OK` responses. In case of timeout: routing attempt will be canceled and further processing (attempt to reroute or give up) depends from disconnect policy.
        
    .. _gateway_fake_180_timer:

Fake 180 timer
    Allows to set up timer for 183 SIP messages with SDP. If there is no 183 message during this timer, SEMS would send 180 message forcibly.

Allow 1xx without to tag
    Allows behavior, which violates RFC, when YETI will process 1xx responses without To-tag.
        
Max 30x redirects
    Amount of 301/302 SIP redirects that are allowed by Yeti for this Gateway (in case of using Gateway as Terminator of calls). Calls won't be redirected in case of filling this field by 0 (zero) value.
        
Max transfers
    Amount of SIP transfers(using REFER mechanism) that are allowed by Yeti for this Gateway (in case of using Gateway as Terminator of calls). Calls won't be transferred in case of filling this field by 0 (zero) value.
        
Sip timer B
    Overwrites the value of SIP timer B (transaction timeout). Call can be rerouted if this allowed by disconnect policy configuration.
        
Dns srv failover timer
    SIP timer M (INVITE retransmit) override. Must have value less than timer B. 
    Call can be rerouted if this allowed by disconnect policy configuration.
        
Suppress early media
    Allows to send 180 Ringing message without SDP to LegA when received 180/183 with SDP from LegB of gateway.

        
Send lnp information
    If enabled (in case of using Gateway as Terminator of calls) Yeti will include Local number portability information (LNP) to the outgoing INVITE-request (by adding **npdi** and **rn** parameters to the R-URI) only in case of availability of this LNP information (it means if LNP information was successfully received from :ref:`LNP Database <lnp_databases>`).
    Rules of receiving LNP information from LNP Database are regulated in the :ref:`Routing plan LNP rules <routing_plan_lnp_rules>`.


.. _gateways_number_translation:
        
Translations attributes
=======================

Privacy mode
    Mode of privacy processing for calls terminated to gateway. Available options:

    - **Do nothing**
    - **Skip for private calls** - gateway will be excluded from routeset during private call routing.
    - **Skip for critical private calls** - gateway will be excluded from routeset during private **critical** call routing.
    - **Not trusted gw. Apply** - Private call will be anonymized before sending call to gateway in order to hide private information.
    - **Trusted gw. Forward** - Private call will be sent to termination gw. PAI, PPI and From headers will ne not anonymized.
    - **Trusted gw. Forward. Anonymize From** - Private call will be sent to termination gw, From header will be anonymized.

Termination SRC Numberlist
    TODO

Termination DST Numberlist
    TODO

.. _gateways_diversion_send_mode:

Diversion send mode
    TODO
    - Do not send
    - Send as SIP URI
    - Send as Tel URI
    
Diversion domain
    Domain part of **Diversion** header generated by **Diversion Send mode** logic.
        
Diversion rewrite rule
    Regular expression pattern for Diversion.
    See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
        
Diversion rewrite result
    Regular expression replacement for Diversion.
    See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    
    
PAI Send mode
    Mode of **P-Asserted-Identity** header transmission to termination gateway. Available options:

    - **Do not send** - Do not send **P-Asserted-Identity** header
    - **Build TEL URI from Source Number** - Generate **P-Asserted-Identity** as `tel URI <https://datatracker.ietf.org/doc/html/rfc3966>`_ header using Source number as user-part.
    - **Build SIP URI from Source Number** - Generate **P-Asserted-Identity** as **sip URI** header using Source number as user-part. **PAI Domain** should be defined.
    - **Build SIP URI from Source Number with user=phone** - Generate **P-Asserted-Identity** as `sip URI with user=phone paramerer <https://datatracker.ietf.org/doc/html/rfc3261#section-19.1.6>`_ using Source number as user-part. **PAI Domain** should be defined.
    - **Relay PAI/PPI as is** - Relay **P-Asserted-Identity** and **P-Preferred-Identity** headers from call legA.
    - Relay PAI/PPI as TEL uri
        Build **P-Asserted-Identity** and **P-Preferred-Identity** as `tel URI <https://datatracker.ietf.org/doc/html/rfc3966>`_  based on P-Asserted-Identity and P-Preferred-Identity received from call legA.

    - Relay PAI/PPI as SIP uri
        Build **P-Asserted-Identity** and **P-Preferred-Identity** as **sip URI**  based on P-Asserted-Identity and P-Preferred-Identity received from call legA. If PAI and PPI headers received on legA have sip URI format, domain will be preserved. Otherwise **PAI Domain** will be used.

    - Relay PAI/PPI as SIP uri. Replace domain
        Build **P-Asserted-Identity** and **P-Preferred-Identity** as **sip URI**  based on P-Asserted-Identity and P-Preferred-Identity received from call legA. Domain part will be replaced with **PAI Domain** value.

    .. warning:: **Relay PAI/PPI as TEL uri**, **Relay PAI/PPI as SIP uri**, **Relay PAI/PPI as SIP uri. Replace domain** are experimental featured.  Disabled by default.

    Modes that relays headers from call legA also require proper :ref:`PAI Policy <customers_auth_pai_policy>` configuration at CustomersAuth object. **P-Asserted-Identity** and **P-Preferred-Identity** values sent to termination gateway will be saved in :ref:`CDR attributes PAI Out and PPI OUT <cdr_pai>`

PAI Domain
    Domain part of **P-Asserted-Identity** and **P-Preferred-Identity** headers generated by **PAI Send mode** logic.
        
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
    
To rewrite rule
    TODO
    
To rewrite result
    TODO


Media attributes
================

SDP c location
    The SDP c location parameter specifies the placement of the connection line (c=) in SDP payloads generated by Yeti.

    Possible values:

        On media level
            The connection line is included inside each media description (m= section).

            .. code-block::

                v=0
                o=yeti-switch 1122334455 1122334455 IN IP4 10.0.0.10
                s=yeti-switch
                t=0 0
                m=audio 40000 RTP/AVP 0 8
                c=IN IP4 10.0.0.10
                a=rtpmap:0 PCMU/8000
                a=rtpmap:8 PCMA/8000

        On session level
            A single connection line is included at the session level, applying to all media streams.

            .. code-block::

                v=0
                o=yeti-switch 1122334455 1122334455 IN IP4 10.0.0.10
                s=yeti-switch
                c=IN IP4 10.0.0.10
                t=0 0
                m=audio 40000 RTP/AVP 0 8
                a=rtpmap:0 PCMU/8000
                a=rtpmap:8 PCMA/8000

        On session and media level
            The connection line is present at both the session level and within each media description.

            .. code-block::

                v=0
                o=yeti-switch 1122334455 1122334455 IN IP4 10.0.0.10
                s=yeti-switch
                c=IN IP4 10.0.0.10
                t=0 0
                m=audio 40000 RTP/AVP 0 8
                c=IN IP4 10.0.0.10
                a=rtpmap:0 PCMU/8000
                a=rtpmap:8 PCMA/8000

Codec group
    Codecs group which will be used to interact with this gateway.

Proxy media
    Determines RTP processing mode. Must be enabled to have possibility of transcoding.
        
Single codec in 200ok
    The Single Codec in 200 OK option controls codec selection in SDP responses generated by Yeti.
    When enabled, Yeti includes only one codec in the SDP answer.

        - The selected codec is determined by the negotiated codec set for the gateway.
        - The only exception is telephone-event, which is always added if it was present in the incoming offer and allowed in the gateway’s codec group.

    When disabled, Yeti responds with the full set of negotiated codecs.

        
Force symmetric rtp
    Ignore remote address negotiated in SDP. Use address gained from first received RTP/RTCP packet.
        
Symmetric rtp nonstop
    By default, YETI allows to change address by symmetric RTP only one time.
    This option allows to disable this limitation.
    If enabled, YETI will change destination address every time when receives RTP/RTCP packet from another source.


Symmetric rtp ignore rtcp
    When enabled, Yeti will not update or learn the remote RTP address from incoming RTCP packets. Only RTP packets will be considered for determining the remote address.


RTP Ping
    The RTP Ping mechanism is designed to resolve situations where both gateways(origination and termination), operating with symmetric RTP enabled, are waiting for the first incoming packet before transmitting their own RTP stream.

    When this option is enabled, Yeti proactively transmits a dummy (fake) RTP packet to the remote gateway immediately after the RTP stream initialization. This ensures that media exchange can be established even when both endpoints are configured to await the first packet.


RTP Timeout
    The RTP Timeout parameter defines the maximum allowable interval without receiving RTP packets before a call is forcibly terminated. When the timeout condition is met, the call is disconnected, and the corresponding disconnect reason is recorded in the CDR.

    Yeti applies a single RTP timeout value for both call legs. This value is computed as the maximum of ``origination_gateway.rtp_timeout`` and ``termination_gateway.rtp_timeout``.

    If the computed RTP timeout value equals 0, the timeout mechanism is disabled, and Yeti does not terminate calls in the absence of RTP packets.

    .. warning:: In SEMS versions prior to 1.170.1, the RTP Timeout is not reset upon the reception of RTCP packets. Beginning with version 1.170.1, SEMS behavior was updated: if RTCP packets are received, the call will not be disconnected even in the absence of RTP packets.


.. spelling:word-list::
    noaudio
        
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
    If enabled, YETI will relay Comfort Noise packets on even if they were not negotiated in SDP.
        
Force one way early media
    If this checkbox is enabled Early Media (the ability of two SIP User Agents to communicate before a SIP call is actually established) will be blocked on the way from LegA (Originator) to LegB (Terminator) of the call. It helps to prevent fraud with using Early Media features for making non-billed calls.
        
Rtp interface name
    Allows to force **Media interface** that will process RTP traffic from/to gateway. Interface with such name should be defined at :doc:`SEMS configuration <../../sems/index>`
        
Media encryption mode
    Defines RTP encryption mechanism, possible values:
            
        - **Disable** - Plain RTP will be used(no encryption)
        - **SRTP SDES** - SRTP with `SDES <https://en.wikipedia.org/wiki/SDES>`_ key negotiation mechanism. In this mode SRTP keys will be sent in SIP SDP payload so it is important to secure SIP signalling by TLS or other secure transport.
        - **SRTP DTLS** - SRTP with `DTLS <https://en.wikipedia.org/wiki/Datagram_Transport_Layer_Security>`_ key negotiation mechanism. DTLS is RTP inband mechanism and it doesn't require secured SIP signalling.
        - **SRTP ZRTP** - SRTP with `ZRTP <https://en.wikipedia.org/wiki/ZRTP>`_ key negotiation mechanism. ZRTP is not standard but sill widely used.
        
    .. seealso:: SEMS should be properly configured to support SRTP, see :ref:`SEMS media interfaces configuration <sems_media_interfaces>`

RTP Acl:
    List for networks where RTP receiving allowed from. Example: 10.20.30.0/24, 192.168.0.0/16
    

DTMF attributes
===============

DTMF data-path displayed on diagram:
        
.. mermaid::

    graph LR
        gw1[Remote Peer 1]
        gw2[Remote Peer 2]
        
        
        
        gw1 -->|SIP| sip-session1
        sip-session2 -->|SIP| gw2
        
        gw1 -->|RTP| media-session1
        media-session2 -->|RTP| gw2
        
        
        
      
        
        media-session1 -->|RTPEvent| dtmf-relay1
        dtmf-relay1 -->|RTPEvent| media-session2
        
        media-session1 -->|RTP| dtmf-filter1
        
       
        
        media-session1 -->|RTPEvent| dtmf-processor1
        media-session1 -->|Inband DTMF| dtmf-processor1
        sip-session1 -->|SIP INFO| dtmf-processor1
      
        
        dtmf-processor2 -->|SIP INFO| sip-session2
        dtmf-processor2 -->|RTPEvent| media-session2
        
        dtmf-processor1 -->|Events| dtmf-processor2
        
        
        dtmf-filter1 -->|RTP| dtmf-filter2
        dtmf-filter2 -->|RTP| media-session2
        
        subgraph yeti[Yeti SBC]
            subgraph gw1-conf[Gateway 1 configuration]
                sip-session1
                media-session1
                dtmf-processor1[DTMF receiver<br>Controlled by **gw1.dtmf_receive_mode**]
                dtmf-filter1[DTMF filter<br>Controlled by **gw1.RX_inband_dtmf_filtering_mode**]
                dtmf-relay1[DTMF relay<br> fastpath controlled by **gw1.force_dtmf_relay**]
            end
            subgraph gw2-conf[Gateway 2 configuration]
                sip-session2
                media-session2
                dtmf-processor2[DTMF sender<br>Controlled by **gw2.dtmf_send_mode**]
                dtmf-filter2[DTMF filter<br>Controlled by **gw2.TX_inband_dtmf_filtering_mode**]
            end
        end
        
        
.. note:: This diagram is not represent internal processing implementation. This is just explanation of DTMF-related behavior of Yeti-Switch depends on gateway configuration.


.. warning::
    To receive/send DTMF using RTPEvent mechanism appropriate payload type should be negotiated first.
    
        - Ensure **telephone-event** payload present in codec group.
        - Ensure **telephone-event** payload correctly negotiated with remote gateway after SDP offer/answer procedure.

Force dtmf relay
    Relay telephone-event (RFC2833) packets 'as is' to other leg. DTMF relay mechanism is deprecated and should not be used.
        
Dtmf send mode
    The way to send dtmf to remote gateway. possible values:
        
        - **Disable sending**
        - **RFC 2833 (telephone-event)**
        - **SIP INFO application/dtmf-relay** - Send SIP INFO requests with **Content-Type: application/dtmf-relay**
        - **SIP INFO application/dtmf** - Send SIP INFO requests with **Content-Type: application/dtmf**
            
Dtmf receive mode
    Allowed ways to receive DTMF from remote gateway. If the way is not allowed it will be ignored.
    Possible values:

        - **RFC 2833 (telephone-event)**
        - **SIP INFO application/dtmf-relay OR application/dtmf**
        - **RFC 2833 OR SIP INFO**
        - **Inband**
        - **Inband OR RFC 2833**

    .. _rx_inband_dtmf_filtering_mode:

Rx inband dtmf filtering mode
    Could be used for to remove inband DTMF signals (DTMF audio tones in the RTP stream) in the incoming RTP-flow that is received from this gateway. Could have following values:

        - **Inherit configuration from other call's leg** - :ref:`Tx inband dtmf filtering mode <tx_inband_dtmf_filtering_mode>` value from the gateway that is associated with other call leg will be used. F.e. for termination Gateway - value from origination Gateway will be used.
        - **Disable** - DTMF signals will be ignored and will be forwarded as is.
        - **Remove DTMF** - DTMF signals will be replaced by "silence" signal in the incoming RTP-flow that is received from this gateway.


    .. _tx_inband_dtmf_filtering_mode:


Tx inband dtmf filtering mode
    Could be used for setting mode of processing of the inband DTMF signals (DTMF audio tones in the RTP stream) in the outgoing RTP-flow that will be sent to this *Gateway*. Could have following values:

        - **Inherit configuration from other call's leg** - :ref:`Rx inband dtmf filtering mode <rx_inband_dtmf_filtering_mode>` value from the gateway that is associated with other call leg will be used. F.e. for termination Gateway - value from origination Gateway will be used.
        - **Disable** - DTMF signals will be ignored and will be forwarded as is.
        - **Remove DTMF** - DTMF signals will be replaced by "silence" signal in the outgoing RTP-flow that will be sent to this *Gateway*.

.. note:: **Rx/Tx inband dtmf filtering** features are useful when it necessary to remove DTMF transmission, or when remote Gateway sends DTMF to both inband and as RTP-event simultaneously. Enabling the corresponding function will remove duplicate information from inband.
        
.. warning:: **Rx/Tx inband dtmf filtering** affects CPU utilization and should not be enabled with care.
         


Radius attributes
=================

Radius accounting profile
       :ref:`Radius accounting profile <radius_accounting_profile>` that is related to this Gateway. When profile attached to gateway, accounting data related to call leg will be sent to RADIUS server.

       
       
STIR/SHAKEN attributes
======================

.. _gateway_stir_shaken:

STIR/SHAKEN mode
    STIR/SHAKEN behavior when gateway used for call termination. Possible values:
    
        - **Disable** - Do not process incoming Identity header.
        - **Relay valid identity or insert our identity(routing numbers)** - if valid Identity received from legA - relay it, elseif **stir/shaken certificate** is defined - inject our own signature using dst_number_routing as **dest tn**
        - **Relay valid identity or insert our identity(out numbers)**- if valid Identity received from legA - relay it, elseif **stir/shaken certificate** is defined - inject our own signature using dst_number_out as **dest tn**
        
STIR/SHAKEN crt
    STIR/SHAKEN certificate to use for Identify signing.

    
.. warning:: **STIR/SHAKEN** mechanisms are experimental features and not enabled by default.
