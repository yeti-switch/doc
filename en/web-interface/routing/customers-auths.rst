
.. _customer_auth:

Customers Auths
~~~~~~~~~~~~~~~

This entity authenticates calls from customers or gateways, applies them to
routing table and has some useful filters and options.
Authentication process is based on using following parameters:

-   **PoP** - Point of presence that received the call;
-   **Remote IP address** – IP address from which the call was received;
-   **Transport protocol** - Protocol (TCP or UDP) that was used for transferring signaling information to Yeti;
-   **URI name** – Destination number;
-   **From name** – Source number;
-   **URI domain** – Domain part of the URI;
-   **From domain** – Domain part of the URI in the From header;
-   **To domain** – Domain part of the URI in the To header;
-   **X-Yeti-Auth** - Custom SIP-header value.

.. _customer_auth_algorithm:

Authentication algorithm is represented on the picture below:

 .. graphviz:: ../graphviz/auth.dot

On the first step of authentication algorithm Yeti is looking into :ref:`Load Balancers <load_balancers>` table for the records where :ref:`Signaling IP <load_balancers_signalling_ip>` is equal **Remote IP address**. If call was received from :ref:`Load Balancer <load_balancers>`  Yeti will use special headers (X-ORIG-IP, X-ORIG-PORT and X-ORIG-PROTO) that were received from :ref:`Load Balancer <load_balancers>`  for receiving information about real **Remote IP address**, port and **Transport protocol**. If call was received from IP address that isn't specified in the :ref:`Load Balancers <load_balancers>`  table the original network parameters (**Remote IP address** and **Transport protocol**) will be used for future authentication process.

On the second step of authentication algorithm Yeti is looking into *Customer Auth* table for the records that are matching **ALL** following conditions:

-   :ref:`IP address <customer_auth_ip_address>` of *Customer Auth* record contains or equals **Remote IP address**;

    .. note:: Examples:

       -    IP address of *Customer Auth* record = *0.0.0.0/0* ; **Remote IP address** = *8.8.8.8* => **TRUE**
       -    IP address of *Customer Auth* record = *192.168.1/24* ; **Remote IP address** = *192.168.1.1* => **TRUE**
       -    IP address of *Customer Auth* record = *192.168.1/24* ; **Remote IP address** = *192.168.2.1* => **FALSE**
       -    IP address of *Customer Auth* record = *192.168.1/24, 192.168.2.1* ; **Remote IP address** = *192.168.2.1* => **TRUE**
       -    IP address of *Customer Auth* record = *192.168.1/24, 192.168.2.1* ; **Remote IP address** = *195.5.30.10* => **FALSE**

-   :ref:`Dst Prefix <customer_auth_dst_prefix>` of *Customer Auth* record is in the prefix range of **URI name**;

    .. note:: Examples:

       -    Dst Prefix of *Customer Auth* record = ** ; **URI name** = *0662296132* => **TRUE**
       -    Dst Prefix of *Customer Auth* record = *066* ; **URI name** = *0662296132* => **TRUE**
       -    Dst Prefix of *Customer Auth* record = *066[1-3]* ; **URI name** = *0662296132* => **TRUE**
       -    Dst Prefix of *Customer Auth* record = *066[1-3]* ; **URI name** = *0665296132* => **FALSE**
       -    Dst Prefix of *Customer Auth* record = *066[1-3], 0665* ; **URI name** = *0665296132* => **TRUE**
       -    Dst Prefix of *Customer Auth* record = *066[1-3], 0665* ; **URI name** = *0666296132* => **FALSE**

-   :ref:`Src Prefix <customer_auth_src_prefix>` of *Customer Auth* record is in the prefix range of **From name**;

    .. note:: Examples:

       -    Src Prefix of *Customer Auth* record = ** ; **From name** = *0662296132* => **TRUE**
       -    Src Prefix of *Customer Auth* record = *066* ; **From name** = *0662296132* => **TRUE**
       -    Src Prefix of *Customer Auth* record = *066[1-3]* ; **From name** = *0662296132* => **TRUE**
       -    Src Prefix of *Customer Auth* record = *066[1-3]* ; **From name** = *0665296132* => **FALSE**
       -    Src Prefix of *Customer Auth* record = *066[1-3], 0665* ; **From name** = *0665296132* => **TRUE**
       -    Src Prefix of *Customer Auth* record = *066[1-3], 0665* ; **From name** = *0666296132* => **FALSE**

-   :ref:`PoP <customer_auth_pop>` of *Customer Auth* record (if chosen) equals **PoP** that received the call;

    .. note:: Examples:

       -    PoP of *Customer Auth* record = *Any* ; **PoP** = *ONAT.EDU.UA DC* => **TRUE**
       -    PoP of *Customer Auth* record = *ONAT.EDU.UA DC* ; **PoP** = *ONAT.EDU.UA DC* => **TRUE**
       -    PoP of *Customer Auth* record = *City* ; **PoP** = *ONAT.EDU.UA DC* => **FALSE**


-   :ref:`X-Yeti-Auth <customer_auth_x_yeti_auth>` of *Customer Auth* record (if not empty) equals **X-Yeti-Auth**;

    .. note:: Examples:

       -    X-Yeti-Auth of *Customer Auth* record = ** ; **X-Yeti-Auth** = *18unID* => **TRUE**
       -    X-Yeti-Auth of *Customer Auth* record = *18unID* ; **X-Yeti-Auth** = *18unID* => **TRUE**
       -    X-Yeti-Auth of *Customer Auth* record = *18unID* ; **X-Yeti-Auth** = ** => **FALSE**
       -    X-Yeti-Auth of *Customer Auth* record = *18unID, 20Pd4A* ; **X-Yeti-Auth** = *20Pd4A* => **TRUE**
       -    X-Yeti-Auth of *Customer Auth* record = *18unID, 20Pd4A* ; **X-Yeti-Auth** = *24578* => **FALSE**

-   :ref:`URI domain <customer_auth_uri_domain>` of *Customer Auth* record (if not empty) equals **URI domain**;

    .. note:: Examples:

       -    URI domain of *Customer Auth* record = ** ; **URI domain** = *onat.edu.ua* => **TRUE**
       -    URI domain of *Customer Auth* record = *onat.edu.ua* ; **URI domain** = *onat.edu.ua* => **TRUE**
       -    URI domain of *Customer Auth* record = *onat.edu.ua* ; **URI domain** = *yeti-switch.org* => **FALSE**
       -    URI domain of *Customer Auth* record = *onat.edu.ua, yeti-switch.org* ; **URI domain** = *yeti-switch.org* => **TRUE**
       -    URI domain of *Customer Auth* record = *onat.edu.ua, yeti-switch.org* ; **URI domain** = *demo.yeti-switch.org* => **FALSE**

-   :ref:`To domain <customer_auth_to_domain>` of *Customer Auth* record (if not empty) equals **To domain**;

    .. note:: Examples:

       -    To domain of *Customer Auth* record = ** ; **To domain** = *onat.edu.ua* => **TRUE**
       -    To domain of *Customer Auth* record = *onat.edu.ua* ; **To domain** = *onat.edu.ua* => **TRUE**
       -    To domain of *Customer Auth* record = *onat.edu.ua* ; **To domain** = *yeti-switch.org* => **FALSE**
       -    To domain of *Customer Auth* record = *onat.edu.ua, yeti-switch.org* ; **To domain** = *yeti-switch.org* => **TRUE**
       -    To domain of *Customer Auth* record = *onat.edu.ua, yeti-switch.org* ; **To domain** = *demo.yeti-switch.org* => **FALSE**

-   :ref:`From domain <customer_auth_from_domain>` of *Customer Auth* record (if not empty) equals **From domain**;

    .. note:: Examples:

       -    From domain of *Customer Auth* record = ** ; **From domain** = *onat.edu.ua* => **TRUE**
       -    From domain of *Customer Auth* record = *onat.edu.ua* ; **From domain** = *onat.edu.ua* => **TRUE**
       -    From domain of *Customer Auth* record = *onat.edu.ua* ; **From domain** = *yeti-switch.org* => **FALSE**
       -    From domain of *Customer Auth* record = *onat.edu.ua, yeti-switch.org* ; **From domain** = *yeti-switch.org* => **TRUE**
       -    From domain of *Customer Auth* record = *onat.edu.ua, yeti-switch.org* ; **From domain** = *demo.yeti-switch.org* => **FALSE**

-   :ref:`Transport protocol <customer_auth_transport_protocol>` of *Customer Auth* record (if chosen) equals **Transport protocol**;

    .. note:: Examples:

       -    Transport protocol of *Customer Auth* record = *TCP* ; **Transport protocol** = *TCP* => **TRUE**
       -    Transport protocol of *Customer Auth* record = *Any* ; **Transport protocol** = *UDP* => **TRUE**
       -    Transport protocol of *Customer Auth* record = *UDP* ; **Transport protocol** = *TCP* => **FALSE**

-   Length of **URI name** is between :ref:`Dst number min and max length <customer_auth_dst_number_min_length>` values of *Customer Auth* record;

    .. note:: Examples:

       -    Dst number min length of *Customer Auth* record = *3* ; Dst number max length of *Customer Auth* record = *15* ; **URI name** = *380662296132* => **TRUE**
       -    Dst number min length of *Customer Auth* record = *7* ; Dst number max length of *Customer Auth* record = *7* ; **URI name** = *7050460* => **TRUE**
       -    Dst number min length of *Customer Auth* record = *0* ; Dst number max length of *Customer Auth* record = *7* ; **URI name** = *0487050460* => **FALSE**

-   *Customer Auth* record is enabled;
-   :ref:`Contractor <contractors>` that is associated with *Customer Auth* record has :ref:`Customer <contractor_customer>` status.

If no records were found on previous step the procedure of Authentication will be exited with **Disconnect Code 110** (Can’t find Customer or Customer locked).

On the third step of authentication algorithm Yeti sorts of *Customer Auth* records (if any were found on the previous step) with following rules:

-   records with the longest mask of :ref:`IP address <customer_auth_ip_address>` first;

    .. note:: Examples:

       -    Record with :ref:`IP address <customer_auth_ip_address>` = *192.168.30.1* will be higher than record with :ref:`IP address <customer_auth_ip_address>` = *192.168.30.0/24*
       -    Record with :ref:`IP address <customer_auth_ip_address>` = *192.168.30.0/24* will be higher than record with :ref:`IP address <customer_auth_ip_address>` = *0.0.0.0/0*
       -    Record with :ref:`IP address <customer_auth_ip_address>` = *192.168.30.0/24* will be on same level with record with :ref:`IP address <customer_auth_ip_address>` = *195.5.30.0/24*


-   records with chosen :ref:`Transport protocol <customer_auth_transport_protocol>`, :ref:`PoP <customer_auth_pop>` and with entered :ref:`URI domain <customer_auth_uri_domain>`, :ref:`To domain <customer_auth_to_domain>` and :ref:`From domain <customer_auth_from_domain>` values first;

-   records with longest :ref:`Dst Prefix <customer_auth_dst_prefix>` and :ref:`Src Prefix <customer_auth_src_prefix>` first.


After sorting of *Customer Auth* records routing procedure will be continued with using first record from the sorted list of *Customer Auth* records that was received.

Customer Auth form contains few tabs and each one is described below.

General attributes
``````````````````

    .. _customer_auth_id:

    Id
       Unique Customers Auth's id.

    .. _customer_auth_name:

    Name
        Unique name of Accounting profile.
        Uses for informational purposes and doesn't affect system behavior.
    Enabled
        Disabled records will be ignored.
    Customer
        Customer, who this Customer Auth belongs to.
    Account
        Account of Customer, which this Customer Auth belongs to.

    .. _customer_check_account_balance:

    Check account balance
        If this flag is enabled Yeti will check current :ref:`Balance <account_balance>` of :ref:`Account <accounts>` that is associated with this Customer Auth record. If current balance is less than :ref:`Min balance <account_min_balance>` call will dropped with *Disconnect code 8000 (No enought customer balance)*.
    Gateway
        Gateway which related to this Customer Auth. That gateway (its parameters),
        will be used for media handling on the A-leg of a call.

    .. _require_incoming_auth:

    Require incoming auth
        In case of enabling this checkbox incoming authorization of Gateway (in case of using Gateway as Originator of calls) will be required.
        :ref:`Authorization parameters <incoming_auth_params>` (username and password) are available in the Signaling tab (Origination section) of **Gateway**'s attributes (Equipment menu).
        Call will be dropped in case of incorrect authorization.
    Rateplan
        Rateplan, which this Customer Auth belongs to.
    Routing Plan
        :ref:`Routing Plan <routing_plan>` that is associated with this *Customer Auth*. Only :ref:`Dialpeers <dialpeers>` that are related to this :ref:`Routing Plan <routing_plan>` could be used for routing of the calls that were received in the framework of this *Customer Auth*.
    Dst Numberlist
        You may apply Dst Numberlist (Destination) and check B-numbers, by prefix or
        full-match, then reject it or allow.
    Src Numberlist
        You may apply Src Numberlist (Source) and check B-numbers, by prefix or
        full-match, then reject it or allow.

    .. _customer_auth_dump_level:

    Dump Level
        It is possible to capture calls to PCAP files, using this option.
        You may choose what kind of information should be captured.
        Possible values are: Capture nothing, Capture signalling traffic, Capture RTP traffic, Capture all traffic.
    Enable Audio Recording
        If checked, the media for calls passing through this Customer Auth will be stored
        in WAV files.
    Capacity
        The capacity of the Customer Auth, i.e. how many calls it accepts at the moment.
    Allow Receive Rate Limit
        A Customer may send special SIP-header in which he sends the price for this call he wants to pay.
        And YETI will rely on this price on the routing stage if we allow such a behavior.
    Send Billing Information
        If enabled, YETI adds the special SIP-header into 200 SIP-message, which contains
        current price for calls, in order to a Customer should be informed.

Match condition options
```````````````````````
    This part is crucial for authentication process of incoming calls. You should note that a one
    customer may have many of Customer Auth with almost the same parameters, so pay
    attention to parameters besides Ip address.

    .. _customer_auth_transport_protocol:

    Transport Protocol
        Transport protocol (Any/TCP/UDP), which the customer uses for sending calls to YETI.

    .. _customer_auth_ip_address:

    Ip
        IP address or array of IP-addresses (separated by comma(,)) of the originator (Customer).

    .. _customer_auth_pop:

    Pop
        Point of presence (PoP), which receives calls from the Customer. If a call will come
        to the different PoP (a node which receives calls belongs to different PoP), such call
        will be processed with other Customer Auth entity.

    .. _customer_auth_src_prefix:

    Src Prefix
        You can define a prefix or array of prefixes (separated by comma(,)) which necessarily should be presented in Src-number for every call from the customer. Just a prefix (or prefixes) must be used here, not a regular expression.

    .. _customer_auth_dst_prefix:

    Dst Prefix
        You can define a prefix or array of prefixes (separated by comma(,)) which necessarily should be presented in a Dst-number for every call from the customer. Just a prefix (or prefixes) must be used here, not a regular expression.

    .. _customer_auth_dst_number_min_length:

    Dst number min length
        Minimum length of destination number allowed for this Customer Auth. In case of receiving destination number that is less than this minimal value other Customer Auth entity will be used (if any) for authentication.

    .. _customer_auth_dst_number_max_length:

    Dst number max length
        Maximum length of destination number allowed for this Customer Auth.
        In case of receiving destination number that is longer than this maximum value call other Customer Auth entity will be used (if any) for authentication.

    .. _customer_auth_uri_domain:

    Uri Domain
        If specified, YETI checks the domain part of the URI for every call. If the domain part is not the same as specified other Customer Auth entity will be used (if any) for authentication. You can specify more than one *Uri Domain* (separated by comma(,)).

    .. _customer_auth_from_domain:

    From Domain
        If specified, YETI checks the domain part of the URI in the From header for every call.
        If presented domain mismatches other Customer Auth entity will be used (if any) for authentication. You can specify more than one *From Domain* (separated by comma(,)).

    .. _customer_auth_to_domain:

    To Domain
        If specified, YETI checks the domain part of the URI in the To header for every call. If presented domain mismatches other Customer Auth entity will be used (if any) for authentication. You can specify more than one *To Domain* (separated by comma(,)).

    .. _customer_auth_x_yeti_auth:

    X Yeti Auth
        It's possible to define the custom SIP-header **X-Yeti-Auth** or array of headers (separated by comma(,)) for the customer's calls and specify its value in YETI. In case they match, YETI passes such calls with using this Customer Auth entity for authentication.

    .. _customers_auth_number_translation:

Number translation options
``````````````````````````

Privacy mode
    Processing mode for :ref:`Private calls <sip_headers_privacy>`. Available options:

    - Allow any calls
    - Reject private calls - Private calls will be rejected
    - Reject critical private calls - Critical private calls will be rejected
    - Reject anonymous calls(no CLI/PAI/PPI) - Private calls with anonymous From, PAI, PPI headers will be rejected

Diversion policy
    Defines what to do with :ref:`Diversion <sip_headers_diversion>` header received in initial INVITE from call originator. Available options:

    - Do not accept - Yeti will not process incoming **Diversion** header
    - Accept - Yeti will accept Diversion header. It will be possible to relay it to termination gateway according to :ref:`Diversion Send Mode <gateways_diversion_send_mode>`

Diversion rewrite rule/Diversion rewrite result
    Rewrite rules for **Diversion** URI user-part. See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

.. _customers_auth_pai_policy:

PAI Policy
    **P-Asserted-Identity** and **P-Preferred-Identity** headers processing logic. Available options:

    - Do not accept
        Do not accept incoming **P-Asserted-Identity** and **P-Preferred-Identity** data. It will not be possible to relay PAI and PPI to termination gateway

    - Accept
        Accept incoming **P-Asserted-Identity** and **P-Preferred-Identity** data. It will be possible to relay PAI and PPI to termination gateway

    - Require
        Yeti will reject call if no **P-Asserted-Identity** header received from call originator

    **P-Asserted-Identity** and **P-Preferred-Identity** values received from call originator will be saved in :ref:`CDR attributes PAI In and PPI In <cdr_pai>`

PAI Rewrite rule/PAI Rewrite result
    Rewrite rules for **P-Asserted-Identity** and **P-Preferred-Identity** URI user-part.
    See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

    .. warning:: Experimental feature.  Disabled by default.

Src name Field
    Src name Field setting defined where yeti reading Src Name from. Available options:

    - From URI Display name - use From header display name as Src Name
    - From URI :spelling:ignore:`:spelling:ignore:`userpart`` - use From header user part as Src Name

Src name rewrite rule/Src name rewrite result
    Rewrite rules for SRC Name. See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

Src number Field
    Src number Field setting defined where yeti reading Src Number from. Available options:

    - From URI :spelling:ignore:`userpart` - use From header user part as Src Name
    - From URI Display name - use From header display name as Src Name

Src rewrite rule/Src rewrite result
    Rewrite rules for SRC Number. See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

Dst number field
    TODO
    - R-URI :spelling:ignore:`userpart`
    - To URI :spelling:ignore:`userpart`
    - Top Diversion header :spelling:ignore:`userpart`

Dst rewrite rule/Dst rewrite result
    Rewrite rules for Destination number.
    See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

Cnam Database
    TODO

.. _radius_options:

Radius options
``````````````

Radius auth profile
    Must be specified if the additional radius authentication is required.

Src number radius rewrite rule/Src number radius rewrite result
    Rewrite rules for changing Source-number which will be send to Radius-server if it's required.
    See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.


Dst number radius rewrite rule/Dst number radius rewrite result
    Rewrite rules for changing Destination-number which will be send to Radius-server if it's required.
    See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

Radius accounting profile
    Must be specified if the radius accounting is required.

    .. _routing_tags_options:

Routing Tags options
````````````````````

Tag action
    Describes one of the possible actions that could be applied to the current set of :ref:`Routing Tags <routing_tag>` that are applied for the call with using *Tag action value* below. Usually *Authentication* it is first step where :ref:`Routing Tags <routing_tag>` can be added to the call. Following actions can be selected in this field:

    - **Clear tags**. Removes all :ref:`Routing Tags <routing_tag>` from the call (if any were added early);
    - **Remove selected tags**. Removes only :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) from the call;
    - **Append selected tags**. Appends :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) to the call;
    - **Intersection with selected tags**. Yeti leaves as is :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) in the call in case of their presence in the current set of :ref:`Routing Tags <routing_tag>` and removes any other :ref:`Routing Tags <routing_tag>` from the call.

Tag action value
    In this field :ref:`Routing Tags <routing_tag>` for making some *Tag action* above could be chosen.

