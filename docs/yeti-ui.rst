Contents:

.. toctree::
    :maxdepth: 3

==================
YETI WEB interface
==================

:Site: https://yeti-switch.org/

.. note::

    Default credentials to login on web-interface after software installation:

    - *login*: **admin**, 
    - *password*: **111111**

Configuration Objects
=====================

Dashboard
---------
Displays different various indicators of the system state:

- active calls graph
- profitability and duration of the calls
- billing status
- state of the system replication

Billing. Contractors
--------------------
Contractor:
    company wich will interact with the system.

Contractor may act as:

    Customer
        Use provided call termination service.
    Supplier
        Provide call termination service.

One contractor can be either customer and supplier.

**Contractor** has the following attributes:

    Name
        Unique contractor name.
    Enabled
        Self-descriptive.
        If flag is off (contractor disabled) this contractor will not be used for routing and billing.
    Vendor
        If enabled contractor can act as supplier and system may terminate calls to it.
    Customer
        If enabled contractor can act as customer and originate calls to the system.
    Description
        Optional description of the contractor.
    Adress
        Optional contractor address.
    Phones
        list of phone numbers to contact with contractor.
    Smtp Connection
        connection to the mail server which will be used to send mails, invoices and notifications
        (SMTP connection must be configured previously in *System->SMTP connections*)

.. note:: Fields **Description**, **Adress**, **Phones** are informational and not used in routing or billing logic.

Billing. Contacts
-----------------
Contact:
    Address information about contractor or system operator (contact belongs to the contractor or to the system operator).
    All email notification and reports use only addresses which were added to the contacts.

**Contact** has the following attributes:

    Contractors:
        Choose Contractors if this contact belongs to them
    Admin user:
        Administrative user which may own contact.
        Contractors names or admin user name must be entered 
    E-mail:
        Address for notifications, invoices and other emails
    Notes:
        Optional notes

Billing. Accounts
-----------------

**Acccount** attributes:

    Name
        unique account name
    Contractors
        Contractors who own this account.
    Min balance
        If account balance become less than this limit, then traffic for this account will be blocked.
    Max balance
        If account balance become greater than this limit, then routes, which are belongs to this account, will not be used for calls termination.
    Origination capacity
        Maximum capacity which can be originated for this account.
        If incoming calls number exceed origination capacity, then traffic will be blocked.
    Termination capacity
        Maximum capacity which can be terminated for this account.
        If outgoing calls number exceed origination capacity, then routes, which are belongs to this account, will not be used for new calls.
    Vendor invoice period
        Automatic invoices generation period in case when account acts as supplier.
    Customer invoice period
        Automatic invoices generation period in case when account acts as customer.
    Vendor invoice template
        Template for generation of PDF invoices for vendor.
        (Templates can be configured at *Billing->Invoice templates*)
    Customer invoice template
        Template for generation of PDF invoices for customer.
        (Templates can be configured at *Billing->Invoice templates*)
    Sent invoices to
        Contacts list to send generated invoices
    Timezone
        Timezone which will be used for invoices generation and statistics for this account

Initial balance for newly created account is always zero.
Balance can be changed as result of calls billing or new payments.

For each call:
account balance will be **decreased** on call cost if it uses account for **origination** (customer)
and **increased** if it uses account for **termination** (vendor)

Billing. Payments
-----------------

Payments intended to change account balance.

All payment attributes are self-descriptive (destination account, amount, description and date of payment)

Equipment. Gateways
-------------------

**Gateway** attributes:
    Enabled
        disabled gateways will be ignored
    Gateway group 
        gateways can be grouped.
        Choose group from the list to add gateway to the group.
        Gateways groups can be managed at *Billing->Gatewat Groups*
    Priority
        Gateway priority in the group.
        In case of termination to the group, gateways will be arranged according to this priority.
    Pop
        Point of presence of the gateway
    Contractor
        Gateway owner
    Allow origination
        Specifies if gateway allowed to originate calls
    Allow termination
        Specifies if gateway allowed to accept calls from YETI
    Sst enabled
        Force to use SIP Session Timers, otherwise SST usage will be controled by signalling of the remote gateway.
    Capacity
        Termination capacity limit for this gateway. In case of gateway usage for origination this attribute will be ignored.
    Acd limit
        ACD threshold. if ACD for gateway traffic will drop below threshold,
        then dialpeers, which are use this gateway,
        will be excluded from routing in case of usage of routing plan with **ACD&ASR control**
    Asr limit
        ASR threshold. if ASR for gateway traffic will drop below threshold,
        then dialpeers, which are use this gateway,
        will be excluded from routing in case of usage of routing plan with **ACD&ASR control**
    Sensor
        Sensor to mirror traffic. Mirroring disabled if not set.
    Sensor level
        Traffic mirroring mode. Possible values:

            - Singnaling
            - RTP
            - Signaling + RTP
    Host
        IP address or DNS name of remote gateway to send SIP signalling.
        (only for usage for termination)
    Port
        Port of remote gateway  to send SIP signalling.
        Leave it empty to enable DNS SRV resolving of name in **Host**
    Resolve ruri
        Indicates necessity to rewrite RURI domain part with resolved IP

        for example: `domain.com` has IP 1.1.1.1 and you set **Host** to `domain.com`:

            - resolve ruri enabled => RURI will be `user@1.1.1.1`
            - resolve ruri disabled => RURI will be `user@domain.com`
    Diversion policy
        Policy to process Diversion header
        
    Diversion rewrite rule
        regular expression pattern for Diversion
    Diversion rewrite result
        regular expression replacement for Diversion
    Src name rewrite rule
        regular expression pattern for From display-name part
    Src name rewrite result
        regular expression replacement for From display-name part
    Src rewrite rule
        regular expression pattern for From user part
    Src rewrite result
        regular expression replacement for From user part
    Dst rewrite rule
        regular expression pattern for To and RURI user part
    Dst rewrite result
        regular expression replacement for To and RURI user part
    Auth enabled
        enable authorization for outgoing calls
    Auth user
        auth username
    Auth password
        auth password
    Auth from user
        From user-part for auth
    Auth from domain
        From domain-part for auth
    Term use outbound proxy
        use outbound proxy for termination
    Term force outbound proxy
        force usage of outbound proxy for terminaton
    Term outbound proxy
        outbound proxy address
    Term next hop for replies
        ..
    Term next hop
        ..
    Term disconnect policy
        ..
    Term append headers req
        headers list to append to the INITIAL invite
    Sdp alines filter type
        Filter type to process alines in SDP. possible values: Transparent, Blacklist, Whitelist
    Sdp alines filter list
        SDP alines comma-separated list
    Ringing timeout
        Timeout between `18x` and `200 OK` respones. 

        In case of timeout: routing attempt will be canceled
        and further processing (attempt to reroute or give up) depends from disconnect policy.
    Relay options
        Transparent relay of In-dialog OPTIONS between call legs
    Relay reinvite
        Transparent relay of In-dialog re-INVITE between call legs
    Relay hold
        Transparent relay of In-dialog re-INVITE with hold/unhold requests between call legs
    Relay prack
        Transparent relay of In-dialog PRACK between call legs
    Allow 1xx without to tag
        allows behavior, which violates RFC, when YETI will process 1xx responses without To-tag.
    Sip timer B
        SIP timer B (transaction timeout) override. must be less than 
        Call can be rerouted if this allowed by disconnect policy configuration.
    Dns srv failover timer
        SIP timer M (INVITE retransmit) override. Must have value less than timer B.
        Call can be rerouted if this allowed by disconnect policy configuration.
    Sdp c location
        Location of connection-line in SDP payloads which are generated by YETI.
        Possible values:

            - On media level
            - On session level
            - On session and media level
    Codec group
        Codecs group which will be used to interact with this gateway.
    Anonymize sdp
        Anonymize client's SDP session data ( session name, uri, origin user )
    Proxy media
        Determines RTP processing mode. Must be enabled to have possibility of transcoding.
    Single codec in 200ok
        If enabled, YETI will leave only once codec in responses with SDP
        (exception is only telephone-event.
        it will be added anyway if received in SDP offer
        and present in codecs group for this gateway)
    Transparent seqno
        Transparent transmission of the RTP SEQ number on RTP relay
    Transparent ssrc
        Transparent transmission of the RTP SSRC number on RTP relay
    Force symmetric rtp
        Ignore remote address negotiated in SDP.
        Use address gained from first received RTP/RTCP packet.
    Symmetric rtp nonstop
        By default, YETI allows to change address by symmetric RTP only one time.
        This option allows to disable this limitation.
        If enabled, YETI will change destination address every time when receives RTP/RTCP packet from another source.
    Symmetric rtp ignore rtcp
        Disable symmetric RTP for RTCP packets
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
    Rtp ping
        Useful for cases: when gateways with enabled symmetric RTP wait for first packet before start sending,
        but gateway on other side doing the same.
        If enabled, YETI will send fake RTP packet to the gateway right after stream initialization.
    Rtp timeout
        If set, call will be dropped with appropriate disconnect reason in CDR if no RTP arrived during this interval
    Filter noaudio streams
        Cut all streams except of 'audio' from SDP in INVITE to the termination gateway.
        Appropriate non-audio streams will be automatically inserted as disabled (port set to zero)
        into responses to the gateway which sent offer to comply with RFC.
        Useful for gateways which processes multiple streams in SDP incorrectly or/and rejects INVITES with non-audio streams.
    Rtp relay timestamp aligning
        Normalize timestamp for RTP packets on RTP relay.
        Useful for cases on RTP relay when remote side changes RTP streams
        without appropriate signalling (RTP mark or/and re-INVITE)
        and destination equipment is not ready to process such behavior correctly
    Rtp force relay CN
        If enabled, YETI will relay CN packets on even if they were not negotiated in SDP

Equipment. Gateway groups
-------------------------
Gateway group allows to use multiple gateways for traffic termination to the same vendor
if this gateways have similar billing configuration.

**Gateway group** attributes:

    Name
        Unique gateways group name
    Vendor
        Gateway group owner
    Prefer same pop
        If enabled, firstly use termination gateways with the same POP as origination traffic has

Equipment. Disconnect policies
------------------------------

Disconnect policy allows to configure rules for each SIP disconnect code per gateway (rerouting, codes/reasons rewriting)

Equipment. Registrations
------------------------

YETI allows to use outgoing SIP registrations on remote supplier or customer equipment.

**Registration** attributes:

    Enabled
        disabled registrations will be ignored
    Pop
        Point of presence for registration requests
    Node
        Node which will hold registration
    Domain
        RURI,From domain part
    Username
        RURI,From user part
    Display username
        From display name part
    Auth user
        Authorization username
    Auth password
        Authorization password
    Proxy
        SIP Proxy to use for registration
    Contact
        Contact header
    Expire
        Registration expiration time
    Force expire
        Force reregistration after **Expire** interval even is server set another value in response

Equipment. Codec groups
-----------------------

**Codec group** attributes:

    Name
        Codec group name.
    List of codecs
        Each codec has the following attributes:

            Codec
                Codec name. All available codecs are presented in drop-down list
            Priority
                Codec priority in SDP. Less value means higher priority.
                Must be unique within group.
            Dynamic payload type
                Payload type override. (allowed only values from dynamic range)
            Format parameters
                Non-standard value for fmt param SDP attribute.

System. Sensors
---------------

System supports mirroring of signalling and media traffic.
This functionality can be used for Lawful Interception.
Currently system supports two incapsulation methods:

    - IP-IP tunnel
        Original packets will be incapsulated into additional IP-IP tunnel header.
        This mode allows to route mirrored traffic,
        it's especially useful when destination equipment not available in the same broadcast domain.
    - IP over Ethernet
        In this mode original packets will be incapsulated directly into ethernet frame using raw sockets.
        Intended to use for cases when destination equipment is in the same L2 domain.

Sensor and logging level can be choosen in gateway settings.
Sensor configuration is separate for A and B leg,
thus for both legs mirroring - sensors must be configured for both termination and origination gateway.
