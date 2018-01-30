=======
Routing
=======

YETI WEB interface - Routing menu description. This section describes authentication and routing principles.


Customers Auth
~~~~~~~~~~~~~~

This entity authenticates calls from customers or gateways, applies them to
routing table and has some useful filters and options.

Customer Auth form is splitted to 3 tabs and each one is described below.

.. _customer_auth:

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
        Account of Customer, which this Customer Auth belongs to.

    .. _customer_check_account_balance:

    Check account balance
        If this flag is enabled Yeti will check current :ref:`Balance <account_balance>` of :ref:`Account <accounts>` that is associated with this Customer Auth record. If current balance is out of limits (less than :ref:`Min balance <account_min_balance>`, or more than :ref:`Max balance <account_max_balance>`) call will dropped.
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
        to the different PoP (a node which receives calls belongs to different PoP), such call
        will be processed with other Customer Auth entity.
    Src Prefix
        You can define a prefix which necessarily should be presented in Src-number for every
        call from the customer. Just a prefix must be used here, not a regular expression.
    Dst Prefix
        You can define a prefix which necessarily should be presented in a Dst-number for every
        call from the customer. Just a prefix must be used here, not a regular expression.
    Dst number min length
        Minimum length of destination number allowed for this Customer Auth. In case of receiving destination number that is less than this minimal value other Customer Auth entity will be used (if any) for authentication.
    Dst number max length
        Maximum length of destination number allowed for this Customer Auth.
        In case of receiving destination number that is longer than this maximum value call other Customer Auth entity will be used (if any) for authentication.
    Uri Domain
        If specified, YETI checks the domain part of the URI for every call. If the domain part is not the same as specified other Customer Auth entity will be used (if any) for authentication.
    From Domain
        If specified, YETI checks the domain part of the URI in the From header for every call.
        If presented domain mismatches other Customer Auth entity will be used (if any) for authentication.
    To Domain
        If specified, YETI checks the domain part of the URI in the To header for every call. If presented domain mismatches other Customer Auth entity will be used (if any) for authentication.
    X Yeti Auth
        It's possible to define the custom SIP-header **X-Yeti-Auth** for the customer's calls and specify its value in
        YETI. In case they match, YETI passes such calls with using this Customer Auth entity for authentication.

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
        The result of changing the Name field in the Destination-number, using the Dst rewrite rule above.

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

Rateplans are used for describing common billing parameters that can be applied for concrete Customer. Rateplans include Destinations that are used for configuration of billing principles for particular call destinations.

**Rateplan**'s attributes:
``````````````````````````

    .. _rateplan_id:

    Id
       Unique Rateplan's id.
    Name
        Unique name of Rateplan.

    .. _rateplan_profit_control:

    Profit Control Mode
        Per call
            In this mode Yeti will route calls only in case of receiving some profit from the call or not unprofitable calls. If this mode was chosen Yeti will select :ref:`Dialpeers <dialpeers>` (for routing the call) where price is bigger or equal (>=) than the price in the :ref:`Destination <destinations>` that was applied for this call.
        No Control
            In this mode Yeti won't control of receiving profit from the call (without comparison price in the applied :ref:`Destination <destinations>` and price in the chosen :ref:`Dialpeer <dialpeers>`).
    Send Quality Alarms To
         This field is used for choosing :ref:`Contact <contacts>` that will be used for sending Quality notifications about all calls that are related to the :ref:`Destinations <destinations>` from this *Ratepalan*. :ref:`Quality notifications configuration <quality_notification_config>` is described in the Destination's attributes description.
    
----

.. _destinations:

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
        This field is used for setting prefix for choosing *Destination* by destination number (number B). Destination will be choosed for call routing only in case of matching this *Prefix* with first symbols of destination number. Under buttom of this field information about according :ref:`Network Prefix <network_prefixes>` record (if any) is shown.
    Dst number min length
        Minimum length of number for this Destination. Destination won't be chosen for the call where destination number (number B) length is less than value of this field.
    Dst number max length
        Maximum length of number for this Destination. Destination won't be chosen for the call where destination number (number B) length is more than value of this field.
    Enabled
        If this flag is activated, the Direction will participate in the routing procedure.
    Reject Calls
        If this flag is activated, when the corresponding number is received with this Direction during the routing procedure, the call will be rejected.
    Rateplan
        Rateplan to which this Destination is related.
    Routing Tag
        :ref:`Routing Tag <routing_tag>` can be selected from the list for adding additional routing issue to this Destination.
    Valid From
        Time and date that determine the time from which this Destination participates (will participate) in the routing procedure.
    Valid Till
        Time and date that determine the point in time to which this Destination will participate in the routing procedure.

    .. _rate_policy_id:

    Rate Policy
        The policy of determining the price of a call on this Direction. The following options are available:
            -   Fixed. If this option is selected, the cost of the call will be calculated with using the Initial rate, Next rate, Connect fee of this Destination.
            -   Based on used dialpeer. This option involves calculating the cost of the call with using the Initial rate, Next rate, Connect fee of Dialpeer that is used for the call. In this case, there is a possibility of changing the value, by determining the :ref:`Dialpeer based rating configuration attributes <destination_dialpeer_based_rating_configuration>` (Dp margin fixed and / or Dp margin percent).
            -   MIN (Fixed, Based on used dialpeer). The minimum price for the call will be chose, when comparing the price of the "Fixed" mode and the "Based on used dialpeer" mode.
            -   MAX (Fixed, Based on used dialpeer). The maximum price for the call will be chose, when comparing the price of the "Fixed" mode and the "Based on used dialpeer" mode.

    .. _destination_reverse_billing:

    Reverse billing
        In case of enabling this flag money for the call that was calculated according :ref:`Rate Policy <rate_policy_id>` **will be added** to the :ref:`Balance <account_balance>` of :ref:`Account <accounts>` that is associated with Customer Auth record that is used for this call.
        Also the call won't be dropped even if :ref:`Check account balance <customer_check_account_balance>` property of :ref:`Customer Auth <customer_auth>` that is used for this call is enabled and current :ref:`Balance <account_balance>` of :ref:`Account <accounts>` that is associated with Customer Auth record is less than :ref:`Min balance <account_min_balance>`.

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
        Rate (in currency units per second) for tariffication of :ref:`Initial Interval <destination_initial_interval>`.

    .. _destination_next_rate:

    Next Rate
        Rate (in currency units per second) for tariffication of :ref:`Next Interval <destination_next_interval>`.

    .. _destination_connect_fee:

    Connect Fee
        Fee (in currency units) for connection (it charges once per call).
    Profit Control Mode
        Leave it empty to inherit :ref:`Profit control mode <rateplan_profit_control>` from Rateplan or specify especial mode for this Destination only. In case of specification :ref:`Profit control mode <rateplan_profit_control>` from Rateplan will be ignored for this Destination.

        No Control
            In this mode Yeti won't control of receiving profit from the call (without comparison price of this  Destination and price in the chosen :ref:`Dialpeer <dialpeers>` ).

        Per call
            In this mode Yeti will route calls only in case of receiving some profit from the call or not unprofitable calls. If this mode was chosen Yeti will select :ref:`Dialpeers <dialpeers>` (for routing the call) where price is bigger or equal (>=) than the price in the  this Destination.

.. _destination_dialpeer_based_rating_configuration:

Dialpeer based rating configuration of **Destination**'s attributes:
````````````````````````````````````````````````````````````````````
    Dp Margin Fixed
        Value of this field (in currency units) will be added (or removed in case of negative value) to/from Rate of Dialpeers during building of Dialpeers rating for routing call regarding to the Rate policy of this Destination.
    Dp Margin Percent
        Value of this field (in percents from full Rate, where 1.0 = 100%) will be added (or removed in case of negative value) to/from Rate of Dialpeers during building of Dialpeers rating for routing call regarding to the Rate policy of this Destination.

.. _quality_notification_config:

Quality notifications configuration of **Destination**'s attributes:
````````````````````````````````````````````````````````````````````
    Asr Limit
        The answer-seizure ratio (ASR) limit for this Destination (in percents, where 1.0 = 100%, 0.5 = 50% etc). Lower limit of the percentage of answered telephone calls with respect to the total call volume on this Destination. If ASR for this Destination will stay less than *Asr Limit* Quality notification will be send to the Contact that is configured in the Rateplan configuration window.
    Acd Limit
        The average call duration (ACD) limit for this Destination (in seconds). Lower limit of the average length of telephone calls on this Destination. If ACD for this Destination will stay less than *Acd Limit* Quality notification will be send to the Contact that is configured in the Rateplan configuration window.
    Short Calls Limit
        The Short Calls ratio limit for this Destination (in percents, where 1.0 = 100%, 0.5 = 50% etc). Lower limit of the percentage of answered telephone calls with length less than :ref:`Short Call Length <short_call_length>` value of :ref:`Global configuration <global_configuration>` with respect to the total call volume on this Destination. If this ration for this Destination will stay less than *Short Calls Limit* Quality notification will be send to the Contact that is configured in the Rateplan configuration window.


.. _routing_group:

Routing Groups
~~~~~~~~~~~~~~

Routing Groups are used for describing common parameters that can be applied for set of Dialpeers. Routing Groups include Dialpeers that are used for configuration of routing and billing principles for the calls.


**Routing Group**'s attributes:
```````````````````````````````

    .. _routing_group_id:

    Id
       Unique Routing Group's id.
    Name
        Friendly name of object.
    
----

.. _dialpeers:

Dialpeers
~~~~~~~~~

Dialpeers identify call destination endpoint and define the billing characteristics that are applied to call legB in a call connection.

**Dialpeer**'s attributes:
``````````````````````````

    .. _dialpeer_id:

    Id
       Unique Dialpeer's id.

    .. _dialpeer_prefix:

    Prefix
        This field is used for setting prefix for filtering dialpeers by destination number (number B). *Dialpeer* will be selected to the list of possible dialpeers for call routing only in case of matching this *Prefix* with first symbols of destination number. Under buttom of this field information about according :ref:`Network Prefix <network_prefixes>` record (if any) is shown. In case if two or more dialpeers from one :ref:`Vendor <contractors>` will match the destination number by this parameter (prefix) only one *Dialpeer* will be selected for call routing on the basis longest prefix match algorithm.
    Dst number min length
        Minimum length of number for this *Dialpeer*. Dialpeer won't be chosen to the list of routing for the call where destination number (number B) length is less than value of this field.
    Dst number max length
        Maximum length of number for this *Dialpeer*. Dialpeer won't be chosen to the list of routing for the call where destination number (number B) length is more than value of this field.
    Enabled
        *Dialpeer* can be used in the dialpeers selection process (for routing calls) only in case of enabling this flag.
    Routing Group
        :ref:`Routing Group <routing_group>` that is related to this Dialpeer.
    Routing Tag
        :ref:`Routing Tag <routing_tag>` can be selected from the list for adding additional routing issue to this *Dialpeer*.
    Vendor
       :ref:`Contractor <contractors>` that is related to this *Dialpeer*. Only Contractor that was marked as :ref:`Vendor <contractor_vendor>` can be chosen in this field.
    Account
        Account of :ref:`Contractor <contractors>` that is related to the chosen *Vendor* for this *Dialpeer*.

    .. _dialpeer_priority:

    Priority
        Value of this field (numeric) is used during building of Dialpeers rating (sorting of Dialpeers) for routing call. Dialpeers with biggest value of *Priority* will be put into top of rating and will be used first in routing set.
    Force Hit Rate
        Value of this field (numeric between 0 and 1) is used during building of Dialpeers rating for routing call. It represents probability of putting this *Dialpeer* at the top of suitable routes.
    Exclusive Route
        If during the routing process it turned out that there are entries in the set of suitable routes with the Exclusive route set - all routes without such flag will be discarded. This behavior allows to disable call re-routing for any direction, if there is an exclusive route for it.

    .. _dialpeer_initial_interval:

    Initial Interval
        The starting interval from the start of the call in seconds (default 1). Allows to set another tariffication policy for starting a call (example: *The first 5 seconds are free*).

    .. _dialpeer_initial_rate:

    Initial Rate
        Rate (in currency units per second) for tariffication of :ref:`Initial Interval <dialpeer_initial_interval>` for this *Dialpeer*.

    .. _dialpeer_next_interval:

    Next Interval
        The subsequent interval of tariffication in seconds. With this interval, the charging step is defined (example *Minute (60 seconds)*, *Per second (1 second)*).

    .. _dialpeer_next_rate:

    Next Rate
        Rate (in currency units per second) for tariffication of :ref:`Next Interval <dialpeer_next_interval>` for this *Dialpeer*.
    Lcr Rate Multiplier
        Value of this field (numeric) is used during building of Dialpeers rating (sorting of Dialpeers) for routing call on the basis of least-cost routing (LCR). This value is used for multiplying :ref:`Next Rate <dialpeer_next_rate>` value only during building of Dialpeers rating and doesn't effect on final cost of call.

    .. _dialpeer_connect_fee:

    Connect Fee
        Fee (in currency units) for connection (it charges once per call) for this *Dialpeer*.

    .. _dialpeer_reverse_billing:

    Reverse billing
        In case of enabling this flag money for the call that was calculated according settings of this Dialpeer **will be removed** from the :ref:`Balance <account_balance>` of :ref:`Account <accounts>` that is associated with this *Dialpeer* of the Vendor that is used for this call. In normal mode (when this flag is disabled) money **will be added** to the :ref:`Balance <account_balance>` of :ref:`Account <accounts>`.
    Gateway
        :ref:`Gateway <gateways>` that will be used for termination of the calls for this *Dialpeer*. :ref:`Termination attributes on Signaling Tab of Gateway properties <gateway_signaling_termination>` should be configured for this :ref:`Gateway <gateways>`.
    Gateway Group
        :ref:`Gateway Group <gateway_groups>` that will be used for termination of the calls for this *Dialpeer* in case of using multiple gateways for traffic termination to the same Vendor.
    Valid From
        Date and time from that this *Dialpeer* will be active and can be used for routing call.
    Valid Till
        Date and time up to that this *Dialpeer* will be active and can be used for routing call.

    .. _dialpeer_acd_limit:

    Acd Limit
        The average call duration (ACD) limit for this *Dialpeer* (in seconds). Lower limit of the average length of telephone calls on this *Dialpeer*. If ACD for this *Dialpeer* will stay less than *Acd Limit* this *Dialpeer* will be excluding from call routing process.

    .. _dialpeer_asr_limit:

    Asr Limit
        The answer-seizure ratio (ASR) limit for this *Dialpeer* (in percents, where 1.0 = 100%, 0.5 = 50% etc). Lower limit of the percentage of answered telephone calls with respect to the total call volume on this *Dialpeer*. If ASR for this Destination will stay less than *Asr Limit* this *Dialpeer* will be excluding from call routing process.
    Short Calls Limit
        The Short Calls ratio limit for this *Dialpeer* (in percents, where 1.0 = 100%, 0.5 = 50% etc). Lower limit of the percentage of answered telephone calls with length less than :ref:`Short Call Length <short_call_length>` value of :ref:`Global configuration <global_configuration>` with respect to the total call volume on this *Dialpeer*. If this ration for this *Dialpeer* will stay less than *Short Calls Limit* this *Dialpeer* will be excluding from call routing process.
    Capacity
        Termination capacity limit for this *Dialpeer*. This value regulates maximum amount of calls that are allowed bia this *Dialpeer* at same time.
    Src Name Rewrite Rule
        This field should contain a regular expression for changing the Name field in the Source-number within SIP-signalization. It will affect all calls that are terminated according this *Dialpeer*.
    Src Name Rewrite Result
        The result of changing the Name field in the Source-number, using the Src name rewrite rule above.
    Src Rewrite Rule
        This field should contain a regular expression for changing the Source-number within SIP-signalization. It will affect all calls that are terminated according this *Dialpeer*.
    Src Rewrite Result
        The result of changing the Name field in the Source-number, using the Src rewrite rule above.
    Dst Rewrite Rule
        This field should contain a regular expression for changing the Destination-number within SIP-signalization. It will affect all calls that are terminated according this *Dialpeer*.
    Dst Rewrite Result
        The result of changing the Name field in the Destination-number, using the Dst rewrite rule above.
    Created At
        Date and time creation of this *Dialpeer*.

----

.. _routing_plan:

Routing Plans
~~~~~~~~~~~~~

Routing Plans are used for describing common parameters that can be applied for set of :ref:`Routing Groups <routing_group>`.
    **TODO** - need to clarify.

**Routing Plan**'s attributes:
``````````````````````````````

    .. _routing_plan_id:

    Id
        Unique Routing Plan's id.
    Name
        Unique Routing Plan name.
    Sorting
        This field is used for setting sorting method for the routes (Dialpeers) within Routing Plan. **TODO** - need to clarify. The following algorithms (sorting methods) are available:
            LCR, No ACD&ASR control - Sorting only on the basis of least-cost routing (LCR) algorithm (routes with lowest price will be on the top of rating) without control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>`.
            Prio,LCR, ACD&ASR control - Sorting on the basis of internal :ref:`Priority <dialpeer_priority>` of :ref:`Dialpeers <dialpeers>` with following sorting on the basis of least-cost routing (LCR) algorithm (routes with highest priorities will be on the top of rating, in case of same priorities LCR sorting will be used) with control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>` (routes with best values of these parameters will be upper in the rating withing same Priority and Cost values).
            LCR,Prio, ACD&ASR control - Sorting on the basis of least-cost routing (LCR) algorithm with following sorting on the basis of internal :ref:`Priority <dialpeer_priority>` of :ref:`Dialpeers <dialpeers>` (routes with lowest price will be on the top of rating, in case of same prices sorting on priorities will be used) with control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>` (routes with best values of these parameters will be upper in the rating withing same Cost and Priority values).
            LCRD, Prio, ACD&ASR control - Sorting on the basis of modified (****TODO****) least-cost routing (LCR) algorithm with following sorting on the basis of internal :ref:`Priority <dialpeer_priority>` of :ref:`Dialpeers <dialpeers>` (routes with lowest price will be on the top of rating, in case of same prices sorting on priorities will be used) with control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>` (routes with best values of these parameters will be upper in the rating withing same Cost and Priority values).
            Route testing ****TODO****
            QD-Static, LCR, ACD&ASR control ****TODO****
            Static only, No ACD&ASR control  ****TODO****
    Use Lnp
        ****TODO****
    Rate Delta Max
        ****TODO****
    Routing Groups
        :ref:`Routing Groups <routing_group>` that are related to this Routing Plan.

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
        This field is used for setting prefix for filtering static routes by destination number (number B). Route will be selected to the list of possible routes for call routing only in case of matching this *Prefix* with first symbols of destination number. Under buttom of this field information about according :ref:`Network Prefix <network_prefixes>` record (if any) is shown. In case if two or more routes from one :ref:`Vendor <contractors>` will match the destination number by this parameter (prefix) only one route will be selected for call routing on the basis longest prefix match algorithm. ****TODO****
    Priority
        Value of this field (numeric) is used during building of routing rating for routing call. Route with biggest  value of *Priority* will be put into top of rating for the same Vendor. **TODO** - need to clarify.
    Vendor
        :ref:`Contractor <contractors>` that is related to this static route. Only Contractor that was marked as :ref:`Vendor <contractor_vendor>` can be chosen in this field.
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
        This field is used for setting prefix for filtering calls by destination number (number B) for using this *Routing Plan LNP rule*.
    Req dst rewrite rule
        ****TODO****
    Req dst rewrite result
        ****TODO****
    Database
        :ref:`LNP Database <lnp_databases>` that will be used for processing LNP requests for selected calls.
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
        Date and time of this Numberlist item creation.
    Updated At
        Date and time of last updating of this Numberlist item.

----

.. _routing_tag:

Routing Tags
~~~~~~~~~~~~

****TODO****

**Routing Tag**'s attributes:
`````````````````````````````

    .. _routing_tag_id:

    Id
       Unique Routing Tag's id.
    Name
       Unique Routing Tag's name.

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
       Unique Area's name.

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
