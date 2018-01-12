Contents:

.. toctree::
    :maxdepth: 3

==================
YETI WEB interface
==================

:Site: https://yeti-switch.org/

.. warning::
    Elements of configuration marked by symbol * should be filled.

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

Billing
-------
This section describes billing and accounting entities

----

Contractors
~~~~~~~~~~~

Contractor is a company which will interact with the system.

Contractor may act as **Customer** - Use provided call termination service and **Vendor** - Provide call termination service. Same contractor can be either customer and vendor.

**Contractor** has the following attributes:
    Id
        Unique contractor id.
    Name
        Unique contractor name.
    Enabled
        Self-descriptive.
        If flag is off (contractor disabled) this contractor will not be used for routing and billing.
    Vendor
        If enabled contractor can act as vendor and system may terminate calls to it.
    Customer
        If enabled contractor can act as customer and originate calls to the system.
    Description
        Optional description of the contractor.
    Address
        Optional contractor address.
    Phones
        List of phone numbers to contact with contractor.
    Smtp Connection
        Connection to the mail server which will be used to send mails, invoices and notifications
        (SMTP connection must be configured previously in *System->SMTP connections*)

.. note:: Fields **Description**, **Address**, **Phones** are informational and not used in routing or billing logic.

----

Contacts
~~~~~~~~

Contact:
    Address information about contractor or system operator (contact belongs to the contractor or to the system operator).
    All email notification and reports use only addresses which were added to the contacts.

**Contact** has the following attributes:
    Id
        Unique contract id.
    Contractor
        Choose Contractors if this contact belongs to them.
    Admin user
        Administrative user which may own contact.
        Contractors names or admin user name must be entered.
    E-mail
        Address for notifications, invoices and other emails.
    Notes
        Optional notes.

----

Accounts
~~~~~~~~

**Account**'s attributes:
    Id
        Unique account id.
    Name
        Unique account name.
    Contractor
        Contractor who own this account.
    Balance
        Current account balance.
    Min balance
        If account balance become less than this limit, then traffic for this account will be blocked.
    Max balance
        If account balance become greater than this limit, then routes, which are belongs to this account, will not be used for calls termination.
    Balance low threshold
        If account balance become less than this limit, notification will be send by email.
    Balance high threshold    
        If account balance become greater than this limit, notification will be send by email.
    Origination capacity
        Maximum capacity which can be originated for this account.
        If incoming calls number exceed origination capacity, then traffic will be blocked.
    Termination capacity
        Maximum capacity which can be terminated for this account.
        If outgoing calls number exceed origination capacity, then routes, which are belongs to this account, will not be used for new calls.
    Vendor invoice period
        Automatic invoices generation period in case when account acts as vendor.
    Customer invoice period
        Automatic invoices generation period in case when account acts as customer.
    Vendor invoice template
        Template for generation of PDF invoices for vendor.
        (Templates can be configured at *Billing->Invoice templates*)
    Customer invoice template
        Template for generation of PDF invoices for customer.
        (Templates can be configured at *Billing->Invoice templates*)
    Sent invoices to
        Contacts list to send invoices that were generated.
    Timezone
        Timezone which will be used for invoices generation and statistics for this account.

Initial balance for newly created account is always zero.
Balance can be changed as result of calls billing or new payments.

For each call:
account balance will be **decreased** on call cost if it uses account for **origination** (customer)
and **increased** if it uses account for **termination** (vendor)

----

Payments
~~~~~~~~

Payments intended to change account balance.

**Payment**'s attributes:
    Id
        Unique payment id.
    Amount
        Amount of payment in the monetary units.
    Notes            
        Additional information about payment transactions.
    Created at
        Date and time of the payment creation.
----

Invoices
~~~~~~~~

Invoice provides possibility to summarize billing information for mutual settlements with customers and vendors.

**Invoice**'s attributes:
    Id
        Unique invoice id.
    Contractor
        Contractor that is related to this invoice.
    Account
        Account that is related to this invoice.
    State
        Status of the invoice. New invoices are created with status *Pending*.
        After changing status of invoice to *Approve*, it is considered confirmed and is sent to the contragent's email (configured in account settings).
        If account has invoice template, system also will generate PDF document.
    Start date
        Date and time of beginning of the billing period in the invoice.
    End date
        Date and time of ending of the billing period in the invoice.
    Amount
        Total amount of invoice in the monetary units.
    Calls count
        Count of calls that are billed in the invoice.
    Successful calls count
        Count of successful calls that are billed in the invoice.
    Calls duration
        Duration (in seconds) of successful calls that are billed in the invoice.
    Type
        Generation of the invoice can be performed manually or automatically, if invoices autogeneration period for account was choosen.
        Three types of invoices are available: Auto, Auto partial and Manual.
    Direction
        The invoice can have on the two possible directions: Vendor or Customer.
    Created at
        Date and time of the invoice creation.
    First call at
        Date and time of of the first call from all calls that are billed in the invoice.
    Last call at
        Date and time of of the last call from all calls that are billed in the invoice.
    First successful call at
        Date and time of of the first successful call from all calls that are billed in the invoice.
    Last successful call at
        Date and time of of the last successful call from all calls that are billed in the invoice.
            
Invoice Templates
~~~~~~~~~~~~~~~~~

PDF document templates which will be used to generate invoice.
Template - it is the file in .odt format with special placeholders.
Placeholders will be replaced with actual data during PDF document generation.
System can store many different templates and you can choose desired template for each account independently.

**Invoice Template**'s attributes:
    Id
        Unique invoice temlpate id.
    Name
        Unique invoice template name.
    Filename 
        Name of file in .odt format with invoice template.
    Sha1
        Result of calculation of Secure Hash Algorithm 1 (SHA1) for the file with invoice template.
    Created at
        Date and time of the invoice template creation.

.. note:: Currently following placeholders are supported in the invoice templates:
.. note:: [ACC_NAME]	Account name
.. note:: [ACC_BALANCE]	Account balance
.. note:: [ACC_BALANCE_DECORATED]	Account balance rounded
.. note:: [ACC_MIN_BALANCE]	Account minimal balance threshold
.. note:: [ACC_MIN_BALANCE_DECORATED]	Account minimal balance threshold rounded
.. note:: [ACC_MAX_BALANCE]	Account minimal balance threshold
.. note:: [ACC_MAX_BALANCE_DECORATED]	Account minimal balance threshold rounded
.. note:: [ACC_INV_PERIOD]	Account invoice period
.. note:: [CONTRACTOR_NAME]	Contractor name
.. note:: [CONTRACTOR_ADDRESS]	Contractor address
.. note:: [CONTRACTOR_PHONES]	Contractor phones
.. note:: [INV_ID]	ID of generated invoice
.. note:: [INV_CREATED_AT]	Date and time of the invoice creation
.. note:: [INV_START_DATE]	Begin of the invoice period
.. note:: [INV_END_DATE]	End of invoice period
.. note:: [INV_AMOUNT]	Invoice total amount
.. note:: [INV_AMOUNT_DECORATED]	Invoice total amount in human format
.. note:: [INV_CALLS_COUNT]	Total count of calls that are billed in the invoice
.. note:: [INV_SUCCESSFUL_CALLS_COUNT]	Count of successful calls that are billed in the invoice
.. note:: [INV_CALLS_DURATIONM]	Duration (in minutes) of successful calls that are billed in the invoice
.. note:: [INV_CALLS_DURATION_DEC]	****TODO****
.. note:: [INV_CALLS_DURATION]	Duration (in seconds) of successful calls that are billed in the invoice
.. note:: [INV_FIRST_CALL_AT]	Date and time of of the first call from all calls that are billed in the invoice
.. note:: [INV_FIRST_SUCCESSFUL_CALL_AT]	Date and time of of the first successful call from all calls that are billed in the invoice
.. note:: [INV_LAST_CALL_AT]	Date and time of of the last call from all calls that are billed in the invoice
.. note:: [INV_LAST_SUCCESSFUL_CALL_AT]	Date and time of of the last successful call from all calls that are billed in the invoice

    
----

Equipment
---------

Gateway groups
~~~~~~~~~~~~~~

Gateway group allows to use multiple gateways for traffic termination to the same vendor if this gateways have similar billing configuration.

**Gateway group** attributes:
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

Gateways
~~~~~~~~

General **Gateway** attributes:

    Id
        Unique gateway id.
    Name
        Friendly name of gateway.
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
    Acd limit  ****TODO**** Poor English
        ACD threshold. If ACD for gateway traffic will drop below threshold, then dialpeers, which are use this gateway,
        will be excluded from routing in case of usage of routing plan with **ACD&ASR control**
    Asr limit ****TODO**** Poor English
        ASR threshold. If ASR for gateway traffic will drop below threshold, then dialpeers, which are use this gateway,
        will be excluded from routing in case of usage of routing plan with **ACD&ASR control**
    Short Calls limit
        ****TODO**** 
        then dialpeers, which are use this gateway,
        will be excluded from routing in case of usage of routing plan with **ACD&ASR control**

SST **Gateway** attributes:
    SST Enabled
        Force to use SIP Session Timers, otherwise SST usage will be controlled by signaling of the remote gateway.
    SST Session Expires
        Default value of Expires header for SIP session timers mechanish
    SST Minimum timer
        ****TODO****
    SST Maximum timer 
        ****TODO****
    Session refresh method
        ****TODO****
    SST ACCEPT501
        ****TODO****

Sensor **Gateway** attributes:
    Sensor level
        Traffic mirroring mode. Possible values:
            - Signaling
            - RTP
            - Signaling + RTP
    Sensor
        Sensor to mirror traffic. Mirroring is disabled if not set.

Signaling **Gateway** attributes:
    Relay options
        Transparent relay of In-dialog OPTIONS between call legs.
    Relay reinvite
        Transparent relay of In-dialog re-INVITE between call legs.
    Relay hold
        Transparent relay of In-dialog re-INVITE with hold/unhold requests between call legs.
    Relay prack
        Transparent relay of In-dialog PRACK between call legs
    Rel100 mode
        ****TODO****
    Relay UPDATE
        Transparent relay of SIP UPDATE between call legs.
    Transit headers from origination
	    Filter of headers in SIP requests which applies to origited calls. Look at :ref:`headers filtering <headers_fitering>`.
    Transit headers from termination
	    Filter of headers in SIP requests which applies to terminated calls. Look at :ref:`headers filtering <headers_fitering>`.
    Sip interface name
        The name of network interface which SEMS is listening on. It might be useful if it is necessary to route SIP-traffic from different IP-addresses.
    Orig next hop
        ****TODO****
    Orig append headers req
        ****TODO****
    Orig use outbound proxy
        ****TODO****
    Orig force outbound proxy
        ****TODO****
    Orig proxy transport protocol
        ****TODO****
    Orig outbound proxy
        ****TODO****
    Transparent dialog
        ****TODO****
    Dialog nat handling
        ****TODO****
    Orig disconnect policy
        ****TODO****
    Transport protocol
        ****TODO****
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
    Incoming auth username
        ****TODO****
    Incoming auth password
        ****TODO****
    Auth enabled
        Enable authorization for outgoing calls.
    Auth user
        Auth username.
    Auth password
        Auth password.
    Auth from user
        From user-part for auth.
    Auth from domain
        From domain-part for auth.
    Term use outbound proxy
        Use outbound proxy for termination.
    Term force outbound proxy
        Force usage of outbound proxy for termination.
    Term proxy transport protocol
        ****TODO****
    Term outbound proxy
        Outbound proxy address.
    Term next hop
        ****TODO****
    Term disconnect policy
        ****TODO****
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
        ****TODO****
    Max transfers
        ****TODO****
    Sip timer B
        SIP timer B (transaction timeout) override. Must be less than         ****TODO****
        Call can be rerouted if this allowed by disconnect policy configuration.
    Dns srv failover timer
        SIP timer M (INVITE retransmit) override. Must have value less than timer B.
        Call can be rerouted if this allowed by disconnect policy configuration.
    Suppress early media
	    Allows to send 180 Ringing message without SDP to LegA when received 180/183 with SDP from LegB of gateway.
    Fake 180 timer
        Allows to set up timer for 183 SIP messages with SDP. If there is no 183 message during this timer, SEMS would send 180 message forsibly.
    Send lnp information
        ****TODO****

Translations **Gateway** attributes:
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

Media **Gateway** attributes:
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
        ****TODO****
    Rtp interface name
        ****TODO****

Dtmf **Gateway** attributes:
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

Radius **Gateway** attributes:
    Radius accounting profile
       ****TODO****


----

Disconnect policies
~~~~~~~~~~~~~~~~~~~

Disconnect policy allows to override system default actions for each SIP disconnect code per gateway (rerouting, codes/reasons rewriting).

**Disconnect policy** attributes:
    Id
        Unique Disconnect policy's id.
    Name
        Unique Disconnect policy's name.
----

Disconnect policies codes
~~~~~~~~~~~~~~~~~~~~~~~~~

**Disconnect policy code** attributes:
    Id
        Unique Disconnect policy code's id.
    Policy
        ****TODO****
    Code
        ****TODO****
    Stop hunting
        ****TODO****
    Pass reason to originator
        ****TODO****
    Rewrited code
        ****TODO****
    Rewrited reason
        ****TODO****

----

Registrations
~~~~~~~~~~~~~

YETI allows to use outgoing SIP registrations on remote vendor's or customer's equipment.

**Registration** attributes:
    Id
        Unique Registration's id.
    Name
	    Name of this registration.
    Enabled
        disabled registrations will be ignored.
    Pop
        Point of presence for registration requests.
    Node
        Node which will hold registration.
    Transport protocol.
        SIP transport protocol which will used for send request.
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

**Codec group** attributes:
    Id
        Unique Codec group's id.
    Name
        Codec group name.
    Codecs
        Each codec has the following attributes:

            Codec
                Codec name. All available codecs are presented in drop-down list.
            Priority
                Codec priority in SDP. Less value means higher priority.
                Must be unique within group.
            Dynamic payload type
                Payload type override (allowed only values from dynamic range).
            Format parameters
                Non-standard value for fmt param SDP attribute.

----

LNP database
~~~~~~~~~~~~
see https://en.wikipedia.org/wiki/Local_number_portability

Yeti supports interaction with LNP databases by SIP and HTTP REST protocols.
We welcome requests to implement additional protocols or LNP database specific formats.

Name
    Database name. Unique field.
Driver
    Driver which will be used. Available options

        - UDP SIP 301/302 redirect
        - thinQ RESR LRN driver
        - In-memory hash
Host
    Database host (will be ignored by In-memory hash driver)
Port
    Database port
Timeout
    Maximum time to wait for response from database.
    Request will fail with appropriate code and reason.
Thinq username
    Authorization username for thinQ API
Thinq token
    Authorization token for thinQ API
Csv file
    Path to file with data to preload (for In-memory hash driver only)

----

RADIUS Auth Profiles
~~~~~~~~~~~~~~~~~~~~

Yeti supports additional authorization of incoming call on external RADIUS server. RADIUS Auth Profile describes communication with that server.

.. note:: module **radius_client** should be loaded to use such feature

**RADIUS Auth Profiles** attributes:

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
    
To enable additional RADIUS authorization you should set Radius Auth Profile at Customer Auth object. 

.. note:: YETI don't support interaction with external routing engines via RADIUS protocol

----

RADIUS Accounting Profiles
~~~~~~~~~~~~~~~~~~~~~~~~~~

Yeti supports additional accounting of calls on external RADIUS server. RADIUS Accounting Profile describes communication with that server.

**RADIUS Accounting Profiles** attributes:

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

----

Routing
-------

Customers Auth
~~~~~~~~~~~~~~

This entity authenticates calls from customers or gateways, applies them to
routing table and has some useful filters and options.

Customer Auth form is splitted to 3 tabs and each one is described below.

*General* tab
`````````````
    Name
        Unique name of Accounting profile.
        Uses for informational purposes and doesn't affect system behaviour.
    Enabled
        Disabled records will be ignored
    Customer
        Customer, who this Customer Auth belongs to
    Account
        Accout of Customer, which this Customer Auth belongs to
    Gateway
        Gateway which related to this Customer Auth. That gateway(its parameters),
        will be used for media handling on the A-leg of a call.
    Rateplan
        Rateplan, which this Customer Auth belongs to
    Routing Plan
        Routing Plan, which this Customer Auth belongs to
    Dst Numberlist
        You may apply Dst Numberlist (Destination) and check B-numbers, by prefix or
        full-match, then reject it or allow.
    Src Numberlist
        You may apply Src Numberlist (Source) and check B-numbers, by prefix or
        full-match, then reject it or allow.
    Dump Level
        It is possible to capture calls to PCAP files, using this option.
        You may choose what kind of information should be captured.
        Possible values are:
        
            - Capture nothing
            - Capture signalling traffic
            - Capture RTP traffic
            - Capture all traffic
            
    Enable Audio Recording
        If checked, the media for calls passing through this Customer Auth will be stored
        in WAV files.
    Capacity
        The capacity of the Customer Auth, i.e. how many calls it accepts at the moment.
    Allow Receive Rate Limit
        A Customer may send special SIP-header in which he send the price for this call he wants to pay.
        And YETI will rely on this price on the routing stage if we allow such a behaviour.
    Send Billing Information
        If enabled, YETI adds the special SIP-header into 200 SIP-message, which contains
        current price for calls, in order to a Customer should be informed.

Match condition options
```````````````````````
    This part is crucial for authentication process of incoming calls. You should note that a one
    customer may have many of Customer Auth with almost the same parameters, so pay
    attention to parameters besides Ip address.

    Transport Protocol
        Transport protocol TCP/UDP, which the customer uses for sending calls to YETI.
    Ip
        IP address of the originator(customer).
    Pop
        Point of precense, which recieves calls from the customer. If a call will come
        on the different PoP (a node which recieves calls belongs to different a PoP), such calls
        will be dropped.
    Src Prefix
        You can define a prefix which necessarily should be presented in a Src-number for every
        call from the customer. If not - a call will be dropped. Just a prefix must be used here, not a
        regular expression.
    Dst Prefix
        You can define a prefix which necessarily should be presented in a Dst-number for every
        call from the customer. If not - a call will be dropped. Just a prefix must be used here, not a
        regular expression.
    Uri Domain
        If specified, YETI checks the domain part of the URI for every call, and drop calls
        if the domain part is not the same as specified.
    From Domain
        If specified, YETI checks the domain part of the URI in the From header for every call, and drop calls
        if presented domain mismatches.
    To Domain
        If specified, YETI checks the domain part of the URI in the To header for every call, and drop calls
        if presented domain mismatches.
    X Yeti Auth
        It's possible to define the custom SIP-header **X-Yeti-Auth** for the customer's calls and specify its value in
        YETI. In case they match, YETI passes such calls through.

*Number translation* tab
````````````````````````

    Diversion policy
        Defines what to do with Diversion header within SIP-signalization.
        Default value is "Clear header", so this header will be deleted.
    Diversion rewrite rule
        This option should contain a regular expression for changing a Diversion header
    Diversion rewrite result
        The result of changing a Diversion header, using the Rewrite Rule above
    Src name rewrite rule
        This field should contain a regular expression for changing the Name field in the
        Source-number within SIP-signalization
    Src name rewrite result
        The result of changing the Name field in the Source-number, using the
        Src name rewrite rule above
    Src rewrite rule
        This field should contain a regular expression for changing the Source-number
        within SIP-signalization
    Src rewrite result
        The result of changing the Name field in the Source-number, using the Src rewrite rule above
    Dst rewrite rule
        This field should contain a regular expression for changing the Destination-number
        within SIP-signalization
    Dst rewrite result
        The result of changing the Name field in the Source-number, using the Dst rewrite rule above

*Radius* tab
````````````

    Radius auth profile
        Must be specified if the additional radius authentication is required
    Src number radius rewrite rule
        Should contain regular expression for changing Source-number which will be sent
        to Radius-server if it's required
    Src number radius rewrite result
        The result of applying the Src number radius rewrite rule to Source-number
    Dst number radius rewrite rule
        Should contain regular expression for changing Destination-number which will be sent
        to Radius-server if it's required
    Dst number radius rewrite result
        The result of applying the Dst number radius rewrite rule to Destination-number
    Radius accounting profile
        Must be specified if the radius accounting is required
    
----

..

Rateplan
~~~~~~~~

Name
    A-Z-Plan
Profit Control Mode
    No Control
Send Quality Alarms To
    TODO
    
----

Destination
~~~~~~~~~~~

Enabled
Prefix
Country
Network
Reject Calls
Quality Alarm
Rateplan
Routing Tag
Valid From
Valid Till
Rate Policy
Initial Interval
Next Interval
Use Dp Intervals
External Id


Initial Rate
Next Rate
Connect Fee
Profit Control Mode

Dp Margin Fixed
Dp Margin Percent

Asr Limit
Acd Limit
Short Calls Limit

Routing Group
~~~~~~~~~~~~~

Name
    Friendly name of object

    
----

Dialpeer
~~~~~~~~

Prefix
Country
Network
Enabled
Locked
Routing Group
Routing Tag
Vendor
Account
Priority
Force Hit Rate
Exclusive Route
Initial Interval
Initial Rate
Next Interval
Next Rate
Lcr Rate Multiplier
Connect Fee
Gateway
Gateway Group
Valid From
Valid Till
Capacity
Src Name Rewrite Rule
Src Name Rewrite Result
Src Rewrite Rule
Src Rewrite Result
Dst Rewrite Rule
Dst Rewrite Result
Acd Limit
Asr Limit
Short Calls Limit
Created At
External
Current Rate

----


Routing Plan
~~~~~~~~~~~~

Name
Sorting
Use Lnp
Rate Delta Max
Routing Groups

----

Routing plan static routes
~~~~~~~~~~~~~~~~~~~~~~~~~~

Routing Plan
Prefix
Country
Network
Priority
Vendor

----

Routing Plan LNP rules
~~~~~~~~~~~~~~~~~~~~~~

Routing plan
Dst prefix￼
Req dst rewrite rule￼
Req dst rewrite result￼
Database
Lrn rewrite rule￼
Lrn rewrite result￼

----

LNP Cache
~~~~~~~~~

TODO

----

Numberlist
~~~~~~~~~~

TODO

----

Numberlist item
~~~~~~~~~~~~~~~

TODO

----

Routing Tag
~~~~~~~~~~~

TODO

----


Area
~~~~

TODO

----

Area prefixes
~~~~~~~~~~~~~

TODO

----

Routing Tags detection
~~~~~~~~~~~~~~~~~~~~~~

TODO

----

Routing Simulation
~~~~~~~~~~~~~~~~~~

TODO

----


CDR
---

Tables
~~~~~~

CDR History
~~~~~~~~~~~

CDR Archive
~~~~~~~~~~~

Reports
-------

Custom CDR report
~~~~~~~~~~~~~~~~~


Customer traffic
~~~~~~~~~~~~~~~~

Vendor traffic
~~~~~~~~~~~~~~

Interval CDR report
~~~~~~~~~~~~~~~~~~~

Termination Distribution
~~~~~~~~~~~~~~~~~~~~~~~~

Origination performance
~~~~~~~~~~~~~~~~~~~~~~~

Bad routing
~~~~~~~~~~~

Not authentificated attempts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Realtime Data
-------------

Active calls
~~~~~~~~~~~~

Nodes
~~~~~

Outgoing Registrations
~~~~~~~~~~~~~~~~~~~~~~


Logs
----

API Log
~~~~~~~

Audit Log
~~~~~~~~~

Logic Log
~~~~~~~~~

Email Log
~~~~~~~~~

Events
~~~~~~

        

System
------

Global configuration
~~~~~~~~~~~~~~~~~~~~

The page contains global parameters of YETI.

**Global configuration** attributes:

Rows Per Page
    This option affords to change drop-down 'Per page' element, which is exists on every list-type page in YETI.
    You can add additional values to that drop-down list if default values '30,50,100' are not sufficient.
CDR Unload Dir
    Directory where YETI unload CDR tables on the *CDR -> Tables* page.
CDR Unload URI
    URL for external CDR viewer program. YETI redirects to that program from *CDR -> Tables* page when user press **Unloaded files** button.
CDR Archive Delay
    Move CDRs to archive table after **N** months.
CDR Remove Delay
    Remove archived tables after **N** months.
Max Records
    Maximum amount of records which YETI can save to CSV file on every list-type page (*Download: CSV* button at the bottom of page).
Import Max Threads
    Number of threads for import from CSV proccess.
Import Helpers Dir
    Helper directory where YETI saves temporary files durring import from CSV process.
Active Calls Require Filter
    Requre any filter on the *RT data -> Active Calls* page.
Registrations Require Filter
    Require any filter on the *RT data -> Outgoing Registrations* page.
Active Calls Show Chart
    If **true** YETI shows chart of active calls on the *RT data -> Active Calls* page.
Active Calls Autorefresh Enable
    If **true** YETI will refresh *RT data -> Active Calls* page every 20 seconds.
Max Call Duration
    Global parameter of maximum call duration (seconds).
Random Disconnect Enable
    If **true** YETI will randomly disconnect calls whose duration more than **Random Disconnect Length** by sendind BYE message to parties.
Random Disconnect Length
    Duration of calls (seconds) which YETI will disconnect if **Random Disconnect Enable** enabled.
Drop Call If LNP Fail
    If **true** YETI drops calls if request to LNP database is not successfull.
LNP Cache TTL
    Time to life of LNP cache (seconds).
LNP E2E Timeout
    Timeout for requests to LNP database (seconds). YETI will drop calls if **Drop Call If LNP Fail** enabled and timeout expired or bad response returned.
Short Call Length
    User may decide which calls are 'short' by this settings (seconds). It involves **Short Calls** filter button on the *CDR -> CDR History* page.
Termination Stats Window
    Interval (hours) for generating of stats for gateway or dialpeer (*Short Window Stats* panel on page of every gateway or dialpeer).
Quality Control Min Calls
    Minimum number of calls for building **Quality Control** statistics.
Quality Control Min Duration
    Total duration of calls for building **Quality Control** statistics.

----

Nodes
~~~~~

List of YETI nodes connected to current cluster.
Every node represents independent installation of YETI-SEMS, which communicate to management interface via RPC protocol.

Attributes:

Name
        Node name.
Pop
        Point of presence. Might be useful for logic grupping of nodes (different data-centers, as example).
Signalling ip
        IP address of node.
Signaling port
        Network port for sending SIP-packets (dafault value 5060).
Rpc endpoint
        IP address and port on which YETI-SEMS is waiting for RPC connections.

In view mode user can use next tabs:

Details
        Common information about node.
Active Calls Chart
        Show the next graphs:
        - Active calls for 24 hours.
        - Calls count for month.
Comments
        Comments of user for current node.

----

Networks
~~~~~~~~

Catalogue of carriers. It contains names of carriers and uses in **Network prefixes** then.

----

Network Prefixes
~~~~~~~~~~~~~~~~

Catalogue of phone prefixes, which contains:

    - Prefix
    - Operator network name
    - Country this prefix belongs to

Yeti database contains preloaded data of prefixes. User could edit them or add another.

----

Sensors
~~~~~~~

System supports mirroring of signaling and media traffic.
This functionality can be used for Lawful Interception.
Currently system supports two encapsulation methods:

    - IP-IP tunnel
        Original packets will be encapsulated into additional IP-IP tunnel header.
        This mode allows to route mirrored traffic,
        it's especially useful when destination equipment not available in the same broadcast domain.
    - IP over Ethernet
        In this mode original packets will be encapsulated directly into Ethernet frame using raw sockets.
        Intended to use for cases when destination equipment is in the same L2 domain.

Sensor and logging level can be chosen in gateway settings.
Sensor configuration is separate for A and B leg,
thus for both legs mirroring - sensors must be configured for both termination and origination gateway.

----

SMTP connections
~~~~~~~~~~~~~~~~

It is necessary to have an SMTP connection in order to YETI can send invoices and alerts to customers. Then user can choose SMTP connection for Customer.

**SMTP connections** attributes:

Name
    Unique name of SMTP connection.
    Uses for informational purposes and doesn't affect system behaviour.
Host
    IP address or hostname of SMTP server.
Port
    TCP port on which SMTP server wait for requests (*default value: 25*).
From address
    E-mail address of sender.
Auth user
	Username for Authorization procedure on external SMTP server.
Auth password
    Password for Authorization procedure on external SMTP server.
Global
	Set as global for all customers.
