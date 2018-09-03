
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

    .. _destination_reject_calls:

    Reject Calls
        If this flag is activated, when the corresponding number is received with this Direction during the routing procedure, the call will be rejected.
    Rateplan
        Rateplan to which this Destination is related.

    .. _destination_routing_tag:

    Routing Tag
        :ref:`Routing Tag <routing_tag>` can be selected from the list for adding additional routing issue to this Destination.

    .. _destination_routing_tag_mode:
    Routing tag mode
       Allows to choose :ref:`Routing tags <routing_tag>` comparison mode (**OR** or **AND**). In the **OR** mode at least one :ref:`Routing Tag <routing_tag>` (from the list of :ref:`Routing Tags <routing_tag>` that were chosen for the call during the routing algorithm) should be included in the set of :ref:`Routing Tags <destination_routing_tag>` that are chosen for this *Destination* record. In the **AND** mode all :ref:`Routing Tags <routing_tag>` (that were chosen for the call during the routing algorithm) should be the same with the set of :ref:`Routing Tags <destination_routing_tag>` that are chosen for this *Destination* record.

    .. _destination_valid_from:

    Valid From
        Time and date that determine the time from which this Destination participates (will participate) in the routing procedure.

    .. _destination_valid_to:

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
        Rate (in currency units per minute) for tariffication of :ref:`Initial Interval <destination_initial_interval>`.

    .. _destination_next_rate:

    Next Rate
        Rate (in currency units per minute) for tariffication of :ref:`Next Interval <destination_next_interval>`.

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


