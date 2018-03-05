
.. _routing_plan:

Routing Plans
~~~~~~~~~~~~~

Routing Plans are used for describing common parameters that can be applied for set of :ref:`Dialpeers <dialpeers>` that are specified by :ref:`Routing Groups <routing_group>`.

**Routing Plan**'s attributes:
``````````````````````````````

    .. _routing_plan_id:

    Id
        Unique Routing Plan's id.
    Name
        Unique Routing Plan name.
    Sorting
        This field is used for setting sorting method for the routes (Dialpeers) within Routing Plan. The following algorithms (sorting methods) are available:

            **LCR, No ACD&ASR control** - Sorting only on the basis of least-cost routing (LCR) algorithm (routes with lowest price will be on the top of rating) without control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>`.

            **Prio,LCR, ACD&ASR control** - Sorting on the basis of internal :ref:`Priority <dialpeer_priority>` of :ref:`Dialpeers <dialpeers>` with following sorting on the basis of least-cost routing (LCR) algorithm (routes with highest priorities will be on the top of rating, in case of same priorities LCR sorting will be used) with control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>` (routes where values of these parameters are less than presetuped limits couldn't be chosen for routing).

            **LCR,Prio, ACD&ASR control** - Sorting on the basis of least-cost routing (LCR) algorithm with following sorting on the basis of internal :ref:`Priority <dialpeer_priority>` of :ref:`Dialpeers <dialpeers>` (routes with lowest price will be on the top of rating, in case of same prices sorting on priorities will be used) with control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>` (routes where values of these parameters are less than presetuped limits couldn't be chosen for routing).

            **LCRD, Prio, ACD&ASR control** - Sorting on the basis of modified least-cost routing (LCR) algorithm with following sorting on the basis of internal :ref:`Priority <dialpeer_priority>` of :ref:`Dialpeers <dialpeers>` (routes with lowest price will be on the top of rating, in case of same prices sorting on priorities will be used) with control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>` (routes where values of these parameters are less than presetuped limits couldn't be chosen for routing). Difference of this algorithm from the classic LCR algorithm is on the using :ref:`Rate Delta Max <rate_delta_max>` value during the sorting of :ref:`Dialpeers <dialpeers>` by price. :ref:`Dialpeers <dialpeers>` with prices that are different one from other less than :ref:`Rate Delta Max <rate_delta_max>` value will be on one level of sorting by price and :ref:`Priority <dialpeer_priority>` will be used for building routing rating between them.

            **Route testing** - This mode of sorting usually used for testing routes from different Vendors. In this mode you can use especial format of destination number: XX*YYYYYYYYYY, where XX - :ref:`Vendor ID <contractor_id>` and YYYYYYYYYY - phone number. In this mode most preffered :ref:`Dialpeer <dialpeers>` of :ref:`Vendor <contractors>` with XX ID will be used for the routing.

            **QD-Static, LCR, ACD&ASR control** - Sorting on the basis of modified internal :ref:`Priority <dialpeer_priority>` of :ref:`Dialpeers <dialpeers>` with following sorting on the basis of least-cost routing (LCR) algorithm (routes with highest priorities will be on the top of rating, in case of same priorities LCR sorting will be used) with control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>` (routes where values of these parameters are less than presetuped limits couldn't be chosen for routing). In this method of sorting :ref:`Priority <dialpeer_priority>` of :ref:`Dialpeers <dialpeers>` will be re-writen by :ref:`Priority <routing_plan_static_route_priority>` of the :ref:`Routing plan static route <routing_plan_static_route>` (if this static route is present in this *Routing plan*).

            **Static only, No ACD&ASR control** - Sorting only on the basis of :ref:`Priority <routing_plan_static_route_priority>` of the :ref:`Routing plan static route <routing_plan_static_route>` (if this static route is present in this *Routing plan*) without control of :ref:`Acd Limit <dialpeer_acd_limit>` and :ref:`Asr Limit <dialpeer_asr_limit>` parameters of :ref:`Dialpeer <dialpeers>`. Routes with highest priorities will be on the top of rating. Routing will be done only in case of presence of :ref:`Routing plan static route <routing_plan_static_route>` record and :ref:`Dialpeer <dialpeers>` record that are related to this *Routing plan*.

    Use Lnp
        If this flag is enabled to all calls with ported numbers that are associated with this *Routing plan* via :ref:`Customer Auth <customer_auth>` record, will be applied local number portability procedure (receiving information from :ref:`LNP Cache <lnp_caches>` or sending request to :ref:`LNP Database <lnp_databases>`.

    .. _rate_delta_max:

    Rate Delta Max
        This value is used for *LCRD, Prio, ACD&ASR control* method of sorting. You should setup this value in case of using this method of sorting. :ref:`Dialpeers <dialpeers>` with prices that are different one from other less than :ref:`Rate Delta Max <rate_delta_max>` value will be on one level of sorting by price and :ref:`Priority <dialpeer_priority>` will be used for building routing rating between them.
    Routing Groups
        :ref:`Routing Groups <routing_group>` that are related to this *Routing Plan*. The rules that are described in this *Routing plan* will be applied to all :ref:`Dialpeers <dialpeers>` that are associated with chosen :ref:`Routing Groups <routing_group>`.


