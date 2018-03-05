
.. _customer_auth:

Customers Auths
~~~~~~~~~~~~~~~

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
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Diversion rewrite result
        The result of changing a Diversion header, using the Rewrite Rule above.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src name rewrite rule
        This field should contain a regular expression for changing the Name field in the Source-number within SIP-signalization.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src name rewrite result
        The result of changing the Name field in the Source-number, using the Src name rewrite rule above.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src rewrite rule
        This field should contain a regular expression for changing the Source-number within SIP-signalization.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src rewrite result
        The result of changing the Name field in the Source-number, using the Src rewrite rule above.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst rewrite rule
        This field should contain a regular expression for changing the Destination-number within SIP-signalization.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst rewrite result
        The result of changing the Name field in the Destination-number, using the Dst rewrite rule above.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

Radius **Customers Auth**'s options
```````````````````````````````````

    Radius auth profile
        Must be specified if the additional radius authentication is required.
    Src number radius rewrite rule
        Should contain regular expression for changing Source-number which will be send to Radius-server if it's required.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src number radius rewrite result
        The result of applying the Src number radius rewrite rule to Source-number.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst number radius rewrite rule
        Should contain regular expression for changing Destination-number which will be send to Radius-server if it's required.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst number radius rewrite result
        The result of applying the Dst number radius rewrite rule to Destination-number.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Radius accounting profile
        Must be specified if the radius accounting is required.
    

