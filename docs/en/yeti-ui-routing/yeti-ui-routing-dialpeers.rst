
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
        This field is used for setting prefix for filtering dialpeers by destination number (number B). *Dialpeer* will be selected to the list of possible dialpeers for call routing only in case of matching this *Prefix* with first symbols of destination number. Under bottom of this field information about according :ref:`Network Prefix <network_prefixes>` record (if any) is shown. In case if two or more dialpeers from one :ref:`Vendor <contractors>` will match the destination number by this parameter (prefix) only one *Dialpeer* will be selected for call routing on the basis longest prefix match algorithm.
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
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src Name Rewrite Result
        The result of changing the Name field in the Source-number, using the Src name rewrite rule above.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src Rewrite Rule
        This field should contain a regular expression for changing the Source-number within SIP-signalization. It will affect all calls that are terminated according this *Dialpeer*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src Rewrite Result
        The result of changing the Name field in the Source-number, using the Src rewrite rule above.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst Rewrite Rule
        This field should contain a regular expression for changing the Destination-number within SIP-signalization. It will affect all calls that are terminated according this *Dialpeer*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst Rewrite Result
        The result of changing the Name field in the Destination-number, using the Dst rewrite rule above.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Created At
        Date and time creation of this *Dialpeer*.


