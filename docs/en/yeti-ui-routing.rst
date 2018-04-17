=======
Routing
=======

This section describes authentication and routing principles.


General routing algorithm is represented on the picture below:

 .. graphviz:: graphviz/routing.dot

On the first step of general routing algorithm :ref:`authentication <customer_auth>` will be made. As a result of this step :ref:`Customer Auth <customer_auth>` record will be selected for incoming call or call will be dropped with *Disconnect Code 110 (Can't find Customer or Customer locked)*.

On the second step of algorithm Yeti will check Customer's balance if :ref:`Check account balance <customer_check_account_balance>` flag of selected :ref:`Customer Auth <customer_auth>` record is enabled. If current balance is less than :ref:`Min balance <account_min_balance>` call will dropped with **Disconnect code 8000** (No enough customer balance).

On the third step of general routing algorithm Yeti makes pre-Routing numbers translations. Yeti rewrites (if necessary) Name field in the Source-number, Source-number and Destination-number for incoming call (by :ref:`using POSIX Regular Expressions <posix_regular_expressions2>`) with using :ref:`Number translation settings <number_translation_settings>` of  :ref:`Customer Auth <customer_auth>` record that was selected. On this step Yeti also rewrites (if necessary) Source and Destination numbers which will be send to Radius-server if it's required (by :ref:`using POSIX Regular Expressions <posix_regular_expressions2>`) with using :ref:`Radius options <radius_options>` of  :ref:`Customer Auth <customer_auth>` record that was selected.

On the fourth step of general routing algorithm Yeti makes processing of destination :ref:`Numberlist <numberlists>` if this :ref:`Numberlist <numberlists>` was setted up in the :ref:`Customer Auth <customer_auth>` record. Depending on chosen :ref:`mode <numberlists_mode>` Yeti is going via all related :ref:`Numberlist items <numberlist_items>` and makes some :ref:`actions <numberlists_action>`. As a result of this step Yeti could drop the call with **Disconnect code 8001** (Destination blacklisted) or just rewrite (if necessary) Source and Destination numbers (by :ref:`using POSIX Regular Expressions <posix_regular_expressions2>`) with using :ref:`rewrite rules <numberlist_items_rewrite_rules>` of  :ref:`Numberlist items <numberlist_items>` record or :ref:`rewrite rules <numberlists_rewrite_rules>` relevant :ref:`Numberlist <numberlists>` record.

On the fifth step of general routing algorithm Yeti makes processing of source :ref:`Numberlist <numberlists>` if this :ref:`Numberlist <numberlists>` was setted up in the :ref:`Customer Auth <customer_auth>` record. Depending on chosen :ref:`mode <numberlists_mode>` Yeti is going via all related :ref:`Numberlist items <numberlist_items>` and makes some :ref:`actions <numberlists_action>`. As a result of this step Yeti could drop the call with **Disconnect code 8002** (Source blacklisted) or just rewrite (if necessary) Source and Destination numbers (by :ref:`using POSIX Regular Expressions <posix_regular_expressions2>`) with using :ref:`rewrite rules <numberlist_items_rewrite_rules>` of  :ref:`Numberlist items <numberlist_items>` record or :ref:`rewrite rules <numberlists_rewrite_rules>` relevant :ref:`Numberlist <numberlists>` record.

On the sixth step of general routing algorithm Yeti will be looking for :ref:`Areas <areas>` (by using :ref:`Area prefixes <area_prefixes>`) that are related to the Source number (**From name**) and Destination number (**URI name**) after them processing and translation on the previous steps.  :ref:`Area <areas>` records that were found (if any), are used for detecting :ref:`Routing Tags <routing_tag>` for the call on the basis :ref:`Routing Tag detection Rules <routing_tag_detection_rules>`.

On the seventh step of general routing algorithm Yeti will be selecting :ref:`Routing Plan <routing_plan>` that was chosen for :ref:`Customer Auth <customer_auth>` record.

On the eighth step of general routing algorithm Yeti (if :ref:`Use Lnp <routing_plan_use_lnp>` flag of :ref:`Routing Plan <routing_plan>` that was chosen for :ref:`Customer Auth <customer_auth>` record is enabled) selects most preferred :ref:`Routing Plan LNP rule <routing_plan_lnp_rules>` (by longest match prefix of destination number (number B)) and uses this :ref:`Routing Plan LNP rule <routing_plan_lnp_rules>` for processing ported numbers of call. If required record wasn't found in the :ref:`LNP Cache <lnp_caches>` - :ref:`LNP Database <lnp_databases>` will be requested. In case of failing query Yeti will drop the call with **Disconnect code 8003** (No response from LNP DB).

On the ninth step of general routing algorithm Yeti will be searching :ref:`Destination <destinations>` for the call that is matching **ALL** following conditions:

-   :ref:`Prefix <destination_prefix>` of :ref:`Destination <destinations>` record is in the prefix range of Destination number (**URI name**);

    .. note:: Examples:

       -    Prefix of :ref:`Destination <destinations>` record = ** ; **URI name** = *0662296132* => **TRUE**
       -    Prefix of :ref:`Destination <destinations>` record = *066* ; **URI name** = *0662296132* => **TRUE**
       -    Prefix of :ref:`Destination <destinations>` record = *066[1-3]* ; **URI name** = *0662296132* => **TRUE**
       -    Prefix of :ref:`Destination <destinations>` record = *066[1-3]* ; **URI name** = *0665296132* => **FALSE**
       -    Prefix of :ref:`Destination <destinations>` record = *066[1-3], 0665* ; **URI name** = *0665296132* => **TRUE**
       -    Prefix of :ref:`Destination <destinations>` record = *066[1-3], 0665* ; **URI name** = *0666296132* => **FALSE**

-   Length of Destination number (**URI name**) is between Dst number min and max length values of :ref:`Destination <destinations>` record;

    .. note:: Examples:

       -    Dst number min length of :ref:`Destination <destinations>` record = *3* ; Dst number max length of :ref:`Destination <destinations>` record = *15* ; **URI name** = *380662296132* => **TRUE**
       -    Dst number min length of :ref:`Destination <destinations>` record = *7* ; Dst number max length of :ref:`Destination <destinations>` record = *7* ; **URI name** = *7050460* => **TRUE**
       -    Dst number min length of :ref:`Destination <destinations>` record = *0* ; Dst number max length of :ref:`Destination <destinations>` record = *7* ; **URI name** = *0487050460* => **FALSE**

-  :ref:`Rateplan <rateplans>` that is chosen for :ref:`Destination <destinations>` record is same with :ref:`Rateplan <rateplans>` that is chosen for :ref:`Customer Auth <customer_auth>` record;

-   :ref:`Destination <destinations>` record is enabled;

-  current date&time is more than :ref:`Valid From <destination_valid_from>` value of :ref:`Destination <destinations>` record;

-  current date&time is less than :ref:`Valid To <destination_valid_to>` value of :ref:`Destination <destinations>` record;

-  :ref:`Routing Tags <routing_tag>` that were chosen for the call (during the sixth step of general routing algorithm) are included in the set of :ref:`Routing Tags <destination_routing_tag>` that are chosen for:ref:`Destination <destinations>` record.

If more than one record was found during searching of :ref:`Destination <destinations>` Yeti sorts records with following rules: records with the longest :ref:`Prefix <destination_prefix>` of :ref:`Destination <destinations>` on the top; records with biggest amount of :ref:`Routing Tags <destination_routing_tag>` that were chosen for the call (during the sixth step of general routing algorithm) and are included in the set of :ref:`Routing Tags <destination_routing_tag>` that are chosen for:ref:`Destination <destinations>` record on the top. Only first record from sorted list will be chosen.

If no records were found during searching of :ref:`Destination <destinations>` Yeti will drop the call with  **Disconnect Code 111** (Can't find destination prefix).

If :ref:`Reject Calls <destination_reject_calls>` flag is enabled for the :ref:`Destination <destinations>` record that was chosen Yeti will drop the call with  **Disconnect Code 112** (Rejected by destination).


On the tenth step of general routing algorithm Yeti will search routes (:ref:`Dialpeers <dialpeers>`) for a call on the basis :ref:`routing (sorting) algorithm <routing_plan_sorting>` that was chosen for :ref:`Routing Plan <routing_plan>` record. If no records were found during searching of :ref:`Dialpeers <dialpeers>` Yeti will drop the call with  **Disconnect Code 113** (No routes).

On the eleventh step of general routing algorithm Yeti will pass through list of selected :ref:`Dialpeers <dialpeers>`) that is sorted by chosen :ref:`routing (sorting) algorithm <routing_plan_sorting>`. For each :ref:`Dialpeer <dialpeers>` following actions will be applied:

    - Search termination :ref:`Gateways <gateways>` for selected :ref:`Dialpeer <dialpeers>` (Step 11.1). If :ref:`Gateway <gateways>` was chosen for :ref:`Dialpeer <dialpeers>` record (and this :ref:`Gateway <gateways>` is :ref:`Enabled <gateway_enabled>`)  Yeti will check :ref:`Vendor <dialpeer_vendor>` property of :ref:`Dialpeer <dialpeers>` and compares it with :ref:`Contractor <gateway_contractor>` property of :ref:`Gateway <gateways>`. In case if :ref:`Is shared <gateways>` flag of :ref:`Gateway <gateways>` record wasn't chosen and :ref:`Vendor <dialpeer_vendor>` property of :ref:`Dialpeer <dialpeers>` record and :ref:`Contractor <gateway_contractor>` property of :ref:`Gateway <gateways>` record aren't same - Yeti will stop process this :ref:`Dialpeer <dialpeers>` and will go to next record in the sorted list of :ref:`Dialpeers <dialpeers>`. Otherwise :ref:`Gateway <gateways>` that was chosen for :ref:`Dialpeer <dialpeers>` record will be used for attempt of the call termination. If :ref:`Gateway <gateways>` wasn't chosen for :ref:`Dialpeer <dialpeers>` record Yeti will select all :ref:`enabled <gateway_enabled>` :ref:`Gateways <gateways>` from :ref:`Gateway group <gateway_groups>` that was chosen for :ref:`Dialpeer <dialpeers>` where :ref:`Point of Presence <gateway_pop>` of the termination and origination :ref:`Gateways <gateways>` are same AND :ref:`Vendor <dialpeer_vendor>` property of :ref:`Dialpeer <dialpeers>` record and :ref:`Contractor <gateway_contractor>` property of :ref:`Gateway <gateways>` record are same. If :ref:`Gateways <gateways>` from the same :ref:`Point of Presence <gateway_pop>` weren't found - Yeti will select all :ref:`enabled <gateway_enabled>` :ref:`Gateways <gateways>` from :ref:`Gateway group <gateway_groups>` that was chosen for :ref:`Dialpeer <dialpeers>` regardless :ref:`Point of Presence <gateway_pop>`, but where :ref:`Vendor <dialpeer_vendor>` property of :ref:`Dialpeer <dialpeers>` record and :ref:`Contractor <gateway_contractor>` property of :ref:`Gateway <gateways>` record are same. All selected by this way :ref:`Gateways <gateways>` will be used for attempts of the call termination. The quantity of attempts of the call termination for each :ref:`Dialpeer <dialpeers>` record from the sorted list of :ref:`Dialpeers <dialpeers>` is determined by quantity of selected :ref:`Gateways <gateways>` that are sorted by following rules: :ref:`Gateways <gateways>` from the same (related to origination) :ref:`Point of Presence <gateway_pop>` are first, :ref:`Gateways <gateways>` with higher :ref:`Priority <gateway_priority>` are first, random :ref:`Gateway <gateways>` will be chosen first in case of equal :ref:`Priorities <gateway_priority>` for two or more :ref:`Gateways <gateways>` in the list;

    - Yeti will pass through list of selected :ref:`Gateways <gateways>` that is sorted by priority (Step 11.2). For each :ref:`Gateway <gateways>` from the list following actions will be applied:

      -  Checking if Customer's min balance will be reached during the call (Step 11.3). On this stage Yeti will check if :ref:`Connect Fee <destination_connect_fee>` of :ref:`Destination <destinations>` record that was selected for this call is bigger than the result of subtracting :ref:`Balance <account_balance>` of the :ref:`Customer's Account <accounts>` and :ref:`Min balance <account_min_balance>` of the :ref:`Customer's Account <accounts>`. If no enough money on :ref:`Customer's Account <accounts>` for make connection and for calling during :ref:`Initial Interval <destination_initial_interval>` of :ref:`Destination <destinations>` record that was selected for this call - call will dropped with **Disconnect code 8000** (No enough customer balance);

      -  Calculating of allowed time for the call (Step 11.4). If :ref:`Next Rate <destination_next_rate>` AND :ref:`Next Interval <destination_next_interval>` of the :ref:`Destination <destinations>` record that was selected for this call are not zero: allowed time for the call will be calculated as sum of :ref:`Initial Interval <destination_initial_interval>` of this :ref:`Destination <destinations>` record and length of call that can be made within amount of money available on :ref:`Customer's Account <accounts>`. Otherwise value :ref:`Max Call Duration <system_global_configuration_max_call_duration>` from :ref:`Global configuration <global_configuration>` will be used for setting allowed time for the call;

      -  Checking if Vendor's max balance will be reached during the call (Step 11.5); **TODO**

      -  Post-routing numbers translations (Step 11.6); **TODO**

      -  Adding Call Profile to the Array (Step 11.7); **TODO**


On the twelfth step of general routing algorithm Yeti will pass through list of Call Profiles that was received on previous step (Step 12). For each Call Profile following actions will be applied:

   -  Checking Disconnect Code (Step 12.1); **TODO**

   -  Writing CDR + writing statistic for route/gateway (Step 12.2, 12.6); **TODO**

   -  Change customer's and vendor's balance at billing subsystem (if necessary) (Step 12.3, 12.7); **TODO**

   -  Trying to connect a call (Step 12.5); **TODO**

   -  Disconnect from Originator (Step 12.4). **TODO**





YETI WEB interface - Routing menu description.

.. toctree::
   :maxdepth: 1

   yeti-ui-routing/yeti-ui-routing-customer_auths
   yeti-ui-routing/yeti-ui-routing-rateplans
   yeti-ui-routing/yeti-ui-routing-destinations
   yeti-ui-routing/yeti-ui-routing-routing_groups
   yeti-ui-routing/yeti-ui-routing-dialpeers
   yeti-ui-routing/yeti-ui-routing-new_rates
   yeti-ui-routing/yeti-ui-routing-routing_plans
   yeti-ui-routing/yeti-ui-routing-routing_plan_static_routes
   yeti-ui-routing/yeti-ui-routing-routing_plan_lnp_rules
   yeti-ui-routing/yeti-ui-routing-lnp_caches
   yeti-ui-routing/yeti-ui-routing-numberlists
   yeti-ui-routing/yeti-ui-routing-numberlist_items
   yeti-ui-routing/yeti-ui-routing-routing_tags
   yeti-ui-routing/yeti-ui-routing-areas
   yeti-ui-routing/yeti-ui-routing-area_prefixes
   yeti-ui-routing/yeti-ui-routing-routing_tag_detection_rules
   yeti-ui-routing/yeti-ui-routing-routing_simulation


