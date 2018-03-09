
.. _customer_auth:

Customers Auths
~~~~~~~~~~~~~~~

This entity authenticates calls from customers or gateways, applies them to
routing table and has some useful filters and options.

 .. graphviz::

    digraph Auth {

      node [style=filled; fillcolor="#FCF9A5"];
      graph [nodesep=0.1, ranksep=0.001, mindist=0.01];

      subgraph cluster_dbfiltering {

        shape=doubleoctagon;

        block0 [label = "Looking into Customer Auth table for the records that are matching following conditions:"; shape=box; sides=4 ];

        subgraph cluster_dbfiltering1 {

            node [style=filled; fillcolor="#FCD975"];

            condition1;
            condition2;
            condition3;
          }

        subgraph cluster_dbfiltering2 {

            node [style=filled; fillcolor="#DCD975"];

            condition4;
            condition5;
            condition6;
          }

        subgraph cluster_dbfiltering3 {

            node [style=filled; fillcolor="#CCD975"];

            condition7;
            condition8;
            condition9;
          }

        subgraph cluster_dbfiltering4 {

            node [style=filled; fillcolor="#BCD975"];

            condition10;
            condition11;
            condition12;
          }

          block00 [label = "Result of selection"; shape=box; sides=4 ];

      }


      block1 [label = "Looking into Load Balancers table for the records where Signaling IP is equal Remote IP address"; shape=box; sides=4 ];

      block2 [label = "Call was received from Load Balancer?"; shape=diamond];

      block3 [label = "Using special headers that were\n received from Load Balancer for\n receiving information about real\n Remote IP address, port and\n Transport protocol"; shape=box; sides=4];

      condition1 [label = "IP address of Customer\n Auth record contains or\n equals Remote\n IP address"; shape=box; sides=4];
      condition2 [label = "Dst Prefix of Customer\n Auth record is in the\n prefix range of\n URI name"; shape=box; sides=4];
      condition3 [label = "Src Prefix of Customer\n Auth record is in the\n prefix range of\n From name"; shape=box; sides=4];
      condition4 [label = "PoP of Customer\n Auth record (if chosen)\n equals PoP that received\n the call"; shape=box; sides=4];
      condition5 [label = "X-Yeti-Auth of Customer\n Auth record (if not\n empty) equals\n X-Yeti-Auth"; shape=box; sides=4];
      condition6 [label = "URI domain of Customer\n Auth record (if not\n empty) equals\n From name"; shape=box; sides=4];
      condition7 [label = "To domain of Customer\n Auth record (if not\n empty) equals\n To domain"; shape=box; sides=4];
      condition8 [label = "From domain of\n Customer Auth record (if\n not empty) equals\n From domain"; shape=box; sides=4];
      condition9 [label = "Transport protocol of\n Customer Auth record (if\n chosen) equals Transport\n protocol"; shape=box; sides=4];
      condition10 [label = "Length of URI name is\n between Dst number min\n and max length values of\n Customer Auth record"; shape=box; sides=4];
      condition11 [label = "\nCustomer Auth\n record is enabled\n "; shape=box; sides=4];
      condition12 [label = "Contractor that is\n associated with\n Customer Auth record\n has Customer status"; shape=box; sides=4];

      block4 [label = "Exit from authentication procedure with\n Disconnect Code 110\n (Can’t find Customer or Customer locked)"; shape=box; sides=4];

      block5 [label = "Sorting of Customer Auth records with following rules: records with\n the longest mask of IP address first; records with chosen Transport\n protocol, PoP and with entered Uri domain, To domain and From\n domain values first; records with longest Dst and Src Prefixes first"; shape=box; sides=4];

      block6 [label = "Continuation of routing procedure with using first record from the\n sorted list of Customer Auth records that was received"; shape=box; sides=4];

      block1 -> block2;
      block2 -> block3 [ label = "Yes"; fontcolor = "darkgreen" ];
      block2 -> block0 [ label = "No" ; fontcolor = "tomato"];
      block3 -> block0;

      condition11 -> block00 [style=invis];

      block00 -> block4 [ label = "Not\n Found"; fontcolor = "tomato" ];
      block00 -> block5 [ label = "Found"; fontcolor = "darkgreen" ];
      block5 -> block6;


      block0 -> condition2 [style=invis];
      condition2 -> condition5 [style=invis];
      condition5 -> condition8 [style=invis];
      condition8 -> condition11 [style=invis];

    }

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
    

