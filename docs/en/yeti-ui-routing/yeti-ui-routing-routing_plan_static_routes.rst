
.. _routing_plan_static_route:

Routing plan static routes
~~~~~~~~~~~~~~~~~~~~~~~~~~

Routing plan static routes are used only for two methods of sorting that could be chosen for :ref:`Routing plan <routing_plan>`:  **QD-Static, LCR, ACD&ASR control** and **Static only, No ACD&ASR control**. They are used for setting common Priority for the group of :ref:`Dialpeers <dialpeers>` that are related to some :ref:`Vendor <contractors>`, have common Prefix and are related to common :ref:`Routing plan <routing_plan>`.

**Routing plan static route**'s attributes:
```````````````````````````````````````````
    Id
       Unique Routing plan static route's id.
    Routing Plan
        :ref:`Routing plan <routing_plan>` that is related for this Routing plan static route.
    Prefix
        This field is used for setting prefix for filtering static routes by destination number (number B). This record will be used during one of two methods of sorting in the framework of :ref:`Routing plan <routing_plan>` (**QD-Static, LCR, ACD&ASR control** or **Static only, No ACD&ASR control**) only in case of matching this *Prefix* with first symbols of destination number. Under buttom of this field information about according :ref:`Network Prefix <network_prefixes>` record (if any) is shown. In case if two or more routes will match the destination number by this parameter (prefix) only one record will be selected for sorting on the basis longest prefix match algorithm.

    .. _routing_plan_static_route_priority:

    Priority
        Value of this field (numeric) is used during building of routing rating for routing call. Route with biggest  value of *Priority* will be put into top of rating. Value of this field will be used for rewriting of the :ref:`Priority <dialpeer_priority>` of the related :ref:`Dialpeers <dialpeers>` in case of using **QD-Static, LCR, ACD&ASR control** or **Static only, No ACD&ASR control** mode of sorting in the framework of :ref:`Routing plan <routing_plan>`.

    Weight
        Value of this field (numeric) is used during randomized taking decision about final route (:ref:`Dialpeer <dialpeers>`) for the routing the call in case of selecting two or more routes with same :ref:`Priority <routing_plan_static_route_priority>`. It uses only in case of using **QD-Static, LCR, ACD&ASR control** or **Static only, No ACD&ASR control** mode of sorting in the framework of :ref:`Routing plan <routing_plan>`. Probability to choose the route is bigger for routes where *Weight* value is bigger.

    Vendor
        :ref:`Contractor <contractors>` that is related to this static route. Only Contractor that was marked as :ref:`Vendor <contractor_vendor>` can be chosen in this field.
    Updated At
        Date and time of last updating of static routing record.


