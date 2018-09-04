
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
            Value of this field (numeric) is used during randomized taking decision about order of final routes (:ref:`Dialpeers <dialpeers>`) for the routing the call in case of selecting two or more routes with same :ref:`Priority <routing_plan_static_route_priority>`. It uses only in case of using **QD-Static, LCR, ACD&ASR control** or **Static only, No ACD&ASR control** mode of sorting in the framework of :ref:`Routing plan <routing_plan>`. Probability of putting the route on the top of routing set is bigger for routes where *Weight* value is bigger.

    .. note:: Example:

       During routing algorithm four :ref:`Dialpeers <dialpeers>` were selected (all selected Dialpeers are linked with the same :ref:`Routing plan <routing_plan>` via common :ref:`Routing Group <routing_group>`):

            -   Dialpeer 1 (Vendor A, Priority 100);
            -   Dialpeer 2 (Vendor B, Priority 100);
            -   Dialpeer 3 (Vendor C, Priority 101);
            -   Dialpeer 4 (Vendor D, Priority 102).

        In case of using **Static only, No ACD&ASR control** mode of sorting in the framework of related :ref:`Routing plan <routing_plan>` and in case of storing following *Static Routes* in the Yeti's Database:

            -   Static Route 1 (Vendor A, Priority 103, Weight 40);
            -   Static Route 2 (Vendor B, Priority 103, Weight 50);
            -   Static Route 3 (Vendor C, Priority 103, Weight 10),

        the algorithm of sorting resulting routes will consist from the following steps:

            1.  With using generator of random numbers the first route will be selected from the routes with same (biggest) priorities. Because using of **Static only, No ACD&ASR control** mode of sorting was configured and three *Static Routes* have biggest priority (103) they will be used for choosing three first possible routes. For example: the probability of choosing route based on Dialpeer 2 is 50% (via relation of weight value for the Static Route 2 (that has the same Vendor with Dialpeer 2) to the sum of weights of all static routes with same priorities (50/(40+50+10)*100% = 50%)); the probability of choosing route based on Dialpeer 1 is 40%; and the probability of choosing route based on Dialpeer 3 is 10%.
            2.  In case of choosing (by generator of random numbers) route that is based on Dialpeer 2 & Static Route 2 (both of them are related to Vendor B) this route will be put on the top of rating. The second route will be chosen between Dialpeer 1 & Static Route 1 (both of them are related to Vendor A) or Dialpeer 3 & Static Route 3 (both of them are related to Vendor C). During this choosing probabilities will be recalculated without already chosen route. For example: the probability of choosing route based on Dialpeer 1 is 80% (via relation of weight value for the Static Route 1 (that has the same Vendor with Dialpeer 1) to the sum of weights of all rest static routes with same priorities (40/(40+10)*100% = 80%)); the probability of choosing route based on Dialpeer 3 is 20%.
            3.  In case of choosing (by generator of random numbers) route that is based on Dialpeer 1 & Static Route 1 (both of them are related to Vendor A) this route will be put on the second place of rating and route that is based on Dialpeer 3 & Static Route 3 (both of them are related to Vendor C) will be put on the third place of rating.
            4.  On the last (fourth) place of rating will be put route that is based on Dialpeer 4 (Vendor D), because it has lowest priority 102 (after rewriting priorities of Dialpeers 1, 2 and 3 by Priorities from the Static Routes).

        The final view of routing rating in our example could be following:
        1.  Route that is based on  Dialpeer 2 (Vendor B)
        2.  Route that is based on  Dialpeer 1 (Vendor A)
        3.  Route that is based on  Dialpeer 3 (Vendor C)
        4.  Route that is based on  Dialpeer 4 (Vendor D)

        Routes 2-4 will be used only in case of wrong result for route 1.

    Vendor
        :ref:`Contractor <contractors>` that is related to this static route. Only Contractor that was marked as :ref:`Vendor <contractor_vendor>` can be chosen in this field.
    Updated At
        Date and time of last updating of static routing record.


