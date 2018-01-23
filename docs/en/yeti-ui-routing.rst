=============================================
YETI WEB interface - Routing menu description
=============================================

Customers Auth
~~~~~~~~~~~~~~

This entity authenticates calls from customers or gateways, applies them to
routing table and has some useful filters and options.

Customer Auth form is splitted to 3 tabs and each one is described below.

General **Customers Auth**'s attributes:
````````````````````````````````````````
    .. _customer_auth_id:

    Id
       Unique Customers Auth's id.

    .. _customer_auth_name:

    Name
        Unique name of Accounting profile.
        Uses for informational purposes and doesn't affect system behaviour.
    Enabled
        Disabled records will be ignored.
    Customer
        Customer, who this Customer Auth belongs to.
    Account
        Accout of Customer, which this Customer Auth belongs to.

    .. _customer_check_account_balance:

    Check account balance
        ****TODO****
    Gateway
        Gateway which related to this Customer Auth. That gateway (its parameters),
        will be used for media handling on the A-leg of a call.

    .. _require_incoming_auth:

    Require incoming auth
        In case of enabling this checkbox incoming authorization of Gateway (in case of using Gateway as Originator of calls) will be required.
        :ref:`Authorization parameters <incomming_auth_params>` (username and password) are available in the Signaling tab (Origination section) of **Gateway**'s attributes (Equipment menu).
        Call will be dropped in case of incorrect authorization.
    Rateplan
        Rateplan, which this Customer Auth belongs to.
    Routing Plan
        Routing Plan, which this Customer Auth belongs to.
    Dst Numberlist
        You may apply Dst Numberlist (Destination) and check B-numbers, by prefix or
        full-match, then reject it or allow.
    Src Numberlist
        You may apply Src Numberlist (Source) and check B-numbers, by prefix or
        full-match, then reject it or allow.
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
        And YETI will rely on this price on the routing stage if we allow such a behaviour.
    Send Billing Information
        If enabled, YETI adds the special SIP-header into 200 SIP-message, which contains
        current price for calls, in order to a Customer should be informed.

Match condition **Customers Auth**'s options
````````````````````````````````````````````
    This part is crucial for authentication process of incoming calls. You should note that a one
    customer may have many of Customer Auth with almost the same parameters, so pay
    attention to parameters besides Ip address.

    Transport Protocol
        Transport protocol (Any/TCP/UDP), which the customer uses for sending calls to YETI.
    Ip
        IP address of the originator (Customer).
    Pop
        Point of presence (PoP), which receives calls from the Customer. If a call will come
        on the different PoP (a node which receives calls belongs to different PoP), such calls
        will be dropped.
    Src Prefix
        You can define a prefix which necessarily should be presented in Src-number for every
        call from the customer. If not - the call will be dropped. Just a prefix must be used here, not a
        regular expression.
    Dst Prefix
        You can define a prefix which necessarily should be presented in a Dst-number for every
        call from the customer. If not - the call will be dropped. Just a prefix must be used here, not a
        regular expression.
    Dst number min length
        Minimal length of destination number allowed for this Customer Auth.
        ****TODO****
    Dst number max length
        ****TODO****
        Maximum length of destination number allowed for this Customer Auth.
    Uri Domain
        If specified, YETI checks the domain part of the URI for every call, and drops calls
        if the domain part is not the same as specified.
    From Domain
        If specified, YETI checks the domain part of the URI in the From header for every call, and drops calls
        if presented domain mismatches.
    To Domain
        If specified, YETI checks the domain part of the URI in the To header for every call, and drops calls
        if presented domain mismatches.
    X Yeti Auth
        It's possible to define the custom SIP-header **X-Yeti-Auth** for the customer's calls and specify its value in
        YETI. In case they match, YETI passes such calls through.

Number translation **Customers Auth**'s options
```````````````````````````````````````````````

    Diversion policy
        Defines what to do with Diversion header within SIP-signalization.
        Default value is "Clear header", so this header will be deleted.
    Diversion rewrite rule
        This option should contain a regular expression for changing a Diversion header.
    Diversion rewrite result
        The result of changing a Diversion header, using the Rewrite Rule above.
    Src name rewrite rule
        This field should contain a regular expression for changing the Name field in the Source-number within SIP-signalization.
    Src name rewrite result
        The result of changing the Name field in the Source-number, using the Src name rewrite rule above.
    Src rewrite rule
        This field should contain a regular expression for changing the Source-number within SIP-signalization.
    Src rewrite result
        The result of changing the Name field in the Source-number, using the Src rewrite rule above.
    Dst rewrite rule
        This field should contain a regular expression for changing the Destination-number within SIP-signalization.
    Dst rewrite result
        The result of changing the Name field in the Source-number, using the Dst rewrite rule above.

Radius **Customers Auth**'s options
```````````````````````````````````

    Radius auth profile
        Must be specified if the additional radius authentication is required.
    Src number radius rewrite rule
        Should contain regular expression for changing Source-number which will be send to Radius-server if it's required.
    Src number radius rewrite result
        The result of applying the Src number radius rewrite rule to Source-number.
    Dst number radius rewrite rule
        Should contain regular expression for changing Destination-number which will be send to Radius-server if it's required.
    Dst number radius rewrite result
        The result of applying the Dst number radius rewrite rule to Destination-number.
    Radius accounting profile
        Must be specified if the radius accounting is required.
    
----

..

Rateplan
~~~~~~~~

****TODO****

**Rateplan**'s attributes:
``````````````````````````
    .. _rateplan_id:

    Id
       Unique Rateplan's id.
    Name
        A-Z-Plan         ****TODO****
    Profit Control Mode
        Per call    ****TODO****
        No Control          ****TODO****
    Send Quality Alarms To
                ****TODO****
    
----

Destinations
~~~~~~~~~~~~

Destinations in YETI are designed to determine the prefixes that can be processed by the system and the order of calculating the cost of calls for the originator.

General **Destination**'s attributes:
`````````````````````````````````````
    .. _destination_id:

    Id
       Unique Destination's id.

    .. _destination_prefix:

    Prefix
        The numeric prefix with which the number is to be compared.
    Dst number min length
        Minimum length of number for this Destination.
    Dst number max length
        Maximum length of number for this Destination.
    Enabled
        If this flag is activated, the Direction will participate in the routing procedure.
    Reject Calls
        If this flag is activated, when the corresponding number is received with this Direction during the routing procedure, the call will be rejected.
    Rateplan
        Rateplan that is used with this Direction.
    Routing Tag
        ****TODO****
    Valid From
        Time and date that determine the time from which this Destination participates (will participate) in the routing procedure.
    Valid Till
        Time and date that determine the point in time to which this Destination will participate in the routing procedure.

    .. _rate_policy_id:

    Rate Policy
        The policy of determining the price of a call on this Direction. The following options are available:
            -   Fixed. If this option is selected, the cost of the call will be calculated with using the Initial rate, Next rate, Connect fee of this Destination.
            -   Based on used dialpeer. This option involves calculating the cost of the call with using the Initial rate, Next rate, Connect fee of Dial-up options, which will take the call. In this case, there is a possibility of changing the value, by determining the Dp margin fixed and / or Dp margin percent.
            -   MIN (Fixed, Based on used dialpeer). The minimum price for a call is chosen, when comparing the price of the "Fixed" mode and the "Based on used dialpeer" mode.
            -   MAX (Fixed, Based on used dialpeer). The maximum price for a call is selected when comparing the price of the "Fixed" mode and the "Based on used dialpeer" mode.

    .. _destination_reverse_billing:

    Reverse billing
        ****TODO****

    .. _destination_initial_interval:

    Initial Interval
        The starting interval from the start of the call in seconds (default 1). Allows you to set another tariffication policy for starting a call (example: *The first 5 seconds are free*).

    .. _destination_next_interval:

    Next Interval
        The subsequent interval of tariffication in seconds. With this interval, the charging step is defined (example *Minute (60 seconds)*, *Per second (1 second)*).

Fixed rating configuration of **Destination**'s attributes:
```````````````````````````````````````````````````````````
    .. _destination_initial_rate:

    Initial Rate
        ****TODO****

    .. _destination_next_rate:

    Next Rate
        ****TODO****

    .. _destination_connect_fee:

    Connect Fee
        ****TODO****
    Profit Control Mode
        ****TODO****
        Leave it empty to inherit Profit control mode from Rateplan
        No control  ****TODO****
        Per call    ****TODO****


Dialpeer based rating configuration of **Destination**'s attributes:
````````````````````````````````````````````````````````````````````
    Dp Margin Fixed
        ****TODO****
    Dp Margin Percent
        ****TODO****

Quality notifications configuration of **Destination**'s attributes:
````````````````````````````````````````````````````````````````````
    Asr Limit
        ****TODO****
    Acd Limit
        ****TODO****
    Short Calls Limit
        ****TODO****


.. _routing_group:

Routing Group
~~~~~~~~~~~~~

**Routing Group**'s attributes:
```````````````````````````````
    .. _routing_group_id:

    Id
       Unique Routing Group's id.
    Name
        Friendly name of object.
    
----

Dialpeers
~~~~~~~~~

****TODO****

**Dialpeer**'s attributes:
``````````````````````````
    .. _dialpeer_id:

    Id
       Unique Dialpeer's id.

    .. _dialpeer_prefix:

    Prefix
        ****TODO****
    Dst number min length
        ****TODO****
    Dst number max length
        ****TODO****
    Enabled
        ****TODO****
    Routing Group
        :ref:`Routing Group <routing_group>` that is related to this Dialpeer.
    Routing Tag
        ****TODO****
    Vendor
        ****TODO****
    Account
        ****TODO****
    Priority
        ****TODO****
    Force Hit Rate
        ****TODO****
    Exclusive Route
        If during the routing process it turned out that there are entries in the set of suitable routes with the Exclusive route set - all routes without such flag will be discarded. This behavior allows to disable call re-routing for any direction, if there is an exclusive route for it.

    .. _dialpeer_initial_interval:

    Initial Interval
        ****TODO****

    .. _dialpeer_initial_rate:

    Initial Rate
        ****TODO****

    .. _dialpeer_next_interval:

    Next Interval
        ****TODO****

    .. _dialpeer_next_rate:

    Next Rate
        ****TODO****
    Lcr Rate Multiplier
        ****TODO****

    .. _dialpeer_connect_fee:

    Connect Fee
        ****TODO****

    .. _dialpeer_reverse_billing:

    Reverse billing
        ****TODO****
    Gateway
        ****TODO****
    Gateway Group
        ****TODO****
    Valid From
        ****TODO****
    Valid Till
        ****TODO****
    Acd Limit
        ****TODO****
    Asr Limit
        ****TODO****
    Short Calls Limit
        ****TODO****
    Capacity
        ****TODO****
    Src Name Rewrite Rule
        ****TODO****
    Src Name Rewrite Result
        ****TODO****
    Src Rewrite Rule
        ****TODO****
    Src Rewrite Result
        ****TODO****
    Dst Rewrite Rule
        ****TODO****
    Dst Rewrite Result
        ****TODO****
    Created At
        Date and time creation of Dialpeer.

----

.. _routing_plan:

Routing Plans
~~~~~~~~~~~~~

****TODO****

**Routing Plan**'s attributes:
``````````````````````````````
    .. _routing_plan_id:

    Id
       Unique Routing Plan's id.
    Name
        Unique Routing Plan name.
    Sorting
        ****TODO****
        LCR, No ACD&ASR control ****TODO****
        Prio,LCR, ACD&ASR control ****TODO****
        LCR,Prio, ACD&ASR control ****TODO****
        LCRD, Prio, ACD&ASR control ****TODO****
        Route testing ****TODO****
        QD-Static, LCR, ACD&ASR control ****TODO****
        Static only, No ACD&ASR control  ****TODO****
    Use Lnp
        ****TODO****
    Rate Delta Max
        ****TODO****
    Routing Groups
        ****TODO****

----

Routing plan static routes
~~~~~~~~~~~~~~~~~~~~~~~~~~

****TODO****

**Routing plan static route**'s attributes:
```````````````````````````````````````````
    Id
       Unique Routing plan static route's id.
    Routing Plan
        :ref:`Routing plan <routing_plan>` that is related for this Routing plan static route. ****TODO****
    Prefix
        ****TODO****
    Priority
        ****TODO****
    Vendor
        ****TODO****
    Updated At
        Date and time of last updating of static routing record.

----

    .. _routing_plan_lnp_rules:

Routing Plan LNP rules
~~~~~~~~~~~~~~~~~~~~~~

****TODO****

**Routing Plan LNP rule**'s attributes:
```````````````````````````````````````
    Id
       Unique Routing Plan LNP rule's id.
    Routing plan
            :ref:`Routing plan <routing_plan>` for that will be applied this Routing plan LNP rule.
    Dst prefix
        ****TODO****
    Req dst rewrite rule
        ****TODO****
    Req dst rewrite result
        ****TODO****
    Database
        ****TODO****
    Lrn rewrite rule
        ****TODO****
    Lrn rewrite result
        ****TODO****

----

LNP Caches
~~~~~~~~~~

****TODO****

**LNP Cache**'s attributes:
```````````````````````````
    Id
       Unique LNP Cache's id.
    DST
        ****TODO****
    LRN
        ****TODO****
    TAG
        ****TODO****
    DATA
        ****TODO****
    DATABASE
        ****TODO****

----

Numberlists
~~~~~~~~~~~

****TODO****

**Numberlist**'s attributes:
````````````````````````````
    Id
       Unique Numberlist's id.
    Name
        Unique Numberlist name.
    Mode
        ****TODO****
        Strict number match ****TODO****
        Prefix match    ****TODO****
    Default action
        ****TODO****
        Reject call ****TODO****
        Allow call  ****TODO****
    Default src rewrite rule
        ****TODO****
    Default src rewrite result
        ****TODO****
    Default dst rewrite rule
        ****TODO****
    Default dst rewrite result
        ****TODO****
    Created At
        Date and time of this Numberlist creation.
    Updated At
        Date and time of last updating of this Numberlist.

----

Numberlist items
~~~~~~~~~~~~~~~~

****TODO****

**Numberlist item**'s attributes:
`````````````````````````````````
    Id
       Unique Numberlist item's id.
    Numberlist
        ****TODO****
    Key
        ****TODO****
    Action
        ****TODO****
        Default action  ****TODO****
        Reject call ****TODO****
        Allow call  ****TODO****
    Src rewrite rule
        ****TODO****
    Src rewrite result
        ****TODO****
    Dst rewrite rule
        ****TODO****
    Dst rewrite result
        ****TODO****
    Created At
        ****TODO****
    Updated At
        ****TODO****

----

Routing Tags
~~~~~~~~~~~~

****TODO****

**Routing Tag**'s attributes:
`````````````````````````````
    .. _routing_tag_id:

    Id
       Unique Routing Tag's id.
    Name
        ****TODO****

----


Areas
~~~~~

****TODO****

**Area**'s attributes:
``````````````````````
    .. _area_id:

    Id
       Unique Area's id.
    Name
        ****TODO****

----

Area prefixes
~~~~~~~~~~~~~

****TODO****

**Area prefixe**'s attributes:
``````````````````````````````
    Id
       Unique Area prefixe's id.
    Prefix
        ****TODO****
    Area
        ****TODO****

----

Routing Tag detection Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~

****TODO****

**Routing Tag detection Rule**'s attributes:
````````````````````````````````````````````
    Id
       Unique Routing Tag detection Rule's id.
    Src area
        ****TODO****
    Dst area
        ****TODO****
    Routing tag
        ****TODO****


----

Routing Simulation
~~~~~~~~~~~~~~~~~~

****TODO****

**Routing Simulation**'s attributes:
````````````````````````````````````
    Transport protocol
        ****TODO****
        UDP
        TCP
    Remote ip
        ****TODO****
    Remote port
        ****TODO****
    Pop
        ****TODO****
    Src number
        ****TODO****
    Dst number
        ****TODO****
    Uri domain
        ****TODO****
    From domain
        ****TODO****
    To domain
        ****TODO****
    X yeti auth
        ****TODO****
    Pai
        ****TODO****
    Ppi
        ****TODO****
    Privacy
        ****TODO****
    Rpid
        ****TODO****
    Rpid privacy
        ****TODO****
    Release mode
        ****TODO****
