=======
Routing
=======

This section describes authentication and routing principles.


General routing algorithm is represented on the picture below:

 .. graphviz:: routing.dot

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

-  at least one :ref:`Routing Tag <routing_tag>` (from the list of :ref:`Routing Tags <routing_tag>` that were chosen for the call during the sixth step of general routing algorithm) is included in the set of :ref:`Routing Tags <destination_routing_tag>` that are chosen for:ref:`Destination <destinations>` record.

If more than one record was found during searching of :ref:`Destination <destinations>` Yeti sorts records with following rules: records with the longest :ref:`Prefix <destination_prefix>` of :ref:`Destination <destinations>` on the top; records with biggest amount of :ref:`Routing Tags <destination_routing_tag>` that were chosen for the call (during the sixth step of general routing algorithm) and are included in the set of :ref:`Routing Tags <destination_routing_tag>` that are chosen for:ref:`Destination <destinations>` record on the top. Only first record from sorted list will be chosen.


If no records were found during searching of :ref:`Destination <destinations>` Yeti will drop the call with  **Disconnect Code 111** (Can't find destination prefix).

If :ref:`Reject Calls <destination_reject_calls>` flag is enabled for the :ref:`Destination <destinations>` record that was chosen Yeti will drop the call with  **Disconnect Code 112** (Rejected by destination).


On the tenth step of general routing algorithm Yeti will search routes (:ref:`Dialpeers <dialpeers>`) for a call on the basis :ref:`routing (sorting) algorithm <routing_plan_sorting>` that was chosen for :ref:`Routing Plan <routing_plan>` record. If no records were found during searching of :ref:`Dialpeers <dialpeers>` Yeti will drop the call with  **Disconnect Code 113** (No routes).

On the eleventh step of general routing algorithm Yeti will pass through list of selected :ref:`Dialpeers <dialpeers>`) that is sorted by chosen :ref:`routing (sorting) algorithm <routing_plan_sorting>`. For each :ref:`Dialpeer <dialpeers>` following actions will be applied:

    - Search termination :ref:`Gateways <gateways>` for selected :ref:`Dialpeer <dialpeers>` (Step 11.1). If :ref:`Gateway <gateways>` was chosen for :ref:`Dialpeer <dialpeers>` record (and this :ref:`Gateway <gateways>` is :ref:`Enabled <gateway_enabled>`)  Yeti will check :ref:`Vendor <dialpeer_vendor>` property of :ref:`Dialpeer <dialpeers>` and compares it with :ref:`Contractor <gateway_contractor>` property of :ref:`Gateway <gateways>`. In case if :ref:`Is shared <gateways>` flag of :ref:`Gateway <gateways>` record wasn't chosen and :ref:`Vendor <dialpeer_vendor>` property of :ref:`Dialpeer <dialpeers>` record and :ref:`Contractor <gateway_contractor>` property of :ref:`Gateway <gateways>` record aren't same - Yeti will stop process this :ref:`Dialpeer <dialpeers>` and will go to next record in the sorted list of :ref:`Dialpeers <dialpeers>`. Otherwise :ref:`Gateway <gateways>` that was chosen for :ref:`Dialpeer <dialpeers>` record will be used for attempt of the call termination. If :ref:`Gateway <gateways>` wasn't chosen for :ref:`Dialpeer <dialpeers>` record Yeti will select all :ref:`enabled <gateway_enabled>` :ref:`Gateways <gateways>` from :ref:`Gateway group <gateway_groups>` that was chosen for :ref:`Dialpeer <dialpeers>` where :ref:`Point of Presence <gateway_pop>` of the termination and origination :ref:`Gateways <gateways>` are same AND :ref:`Vendor <dialpeer_vendor>` property of :ref:`Dialpeer <dialpeers>` record and :ref:`Contractor <gateway_contractor>` property of :ref:`Gateway <gateways>` record are same. If :ref:`Gateways <gateways>` from the same :ref:`Point of Presence <gateway_pop>` weren't found - Yeti will select all :ref:`enabled <gateway_enabled>` :ref:`Gateways <gateways>` from :ref:`Gateway group <gateway_groups>` that was chosen for :ref:`Dialpeer <dialpeers>` regardless :ref:`Point of Presence <gateway_pop>`, but where :ref:`Vendor <dialpeer_vendor>` property of :ref:`Dialpeer <dialpeers>` record and :ref:`Contractor <gateway_contractor>` property of :ref:`Gateway <gateways>` record are same. All selected by this way :ref:`Gateways <gateways>` will be used for attempts of the call termination. The quantity of attempts of the call termination for each :ref:`Dialpeer <dialpeers>` record from the sorted list of :ref:`Dialpeers <dialpeers>` is determined by quantity of selected :ref:`Gateways <gateways>` that are sorted by following rules: :ref:`Gateways <gateways>` from the same (related to origination) :ref:`Point of Presence <gateway_pop>` are first, :ref:`Gateways <gateways>` with higher :ref:`Priority <gateway_priority>` are first, random :ref:`Gateway <gateways>` will be chosen first in case of equal :ref:`Priorities <gateway_priority>` for two or more :ref:`Gateways <gateways>` in the list;

    - Yeti will pass through list of selected :ref:`Gateways <gateways>` that is sorted by priority (Step 11.2). For each :ref:`Gateway <gateways>` from the list following actions will be applied:

      -  Checking if Customer's min balance will be reached during the call (Step 11.3). On this stage Yeti will check if :ref:`Connect Fee <destination_connect_fee>` of :ref:`Destination <destinations>` record that was selected for this call is bigger than the result of subtracting :ref:`Balance <account_balance>` of the :ref:`Customer's Account <accounts>` and :ref:`Min balance <account_min_balance>` of the :ref:`Customer's Account <accounts>`. If no enough money on :ref:`Customer's Account <accounts>` for make connection and for calling during :ref:`Initial Interval <destination_initial_interval>` of :ref:`Destination <destinations>` record that was selected for this call - call will dropped with **Disconnect code 8000** (No enough customer balance);

      -  Calculating of allowed time for the call (Step 11.4). Yeti could limit maximum time of the calls to avoid exceeding limits of money (minimum or maximum) that are available on accounts of Customer and Vendor. For this purpose Yeti has two values of allowed time: limited by Customer's Account and limited by Vendor's account:

         -  **Allowed time that is limited by Customer's Account**. If :ref:`Next Rate <destination_next_rate>` AND :ref:`Next Interval <destination_next_interval>` of the :ref:`Destination <destinations>` record that was selected for this call are not zero: allowed time for the call will be calculated as sum of :ref:`Initial Interval <destination_initial_interval>` of this :ref:`Destination <destinations>` record and length of call that can be made within amount of money available on :ref:`Customer's Account <accounts>`. Otherwise value :ref:`Max Call Duration <system_global_configuration_max_call_duration>` from :ref:`Global configuration <global_configuration>` will be used for setting allowed time for the call;

         -  **Allowed time that is limited by Vendor's Account**. If :ref:`Next Rate <dialpeer_next_rate>` AND :ref:`Next Interval <dialpeer_next_interval>` of the :ref:`Dialpeer <dialpeers>` record that was selected for this call are not zero: allowed time for the call will be calculated as sum of :ref:`Initial Interval <dialpeer_initial_interval>` of this :ref:`Dialpeer <dialpeers>` record and length of call that can be made before reaching :ref:`Max balance <account_max_balance>` the :ref:`Vendor's Account <accounts>`. Otherwise value :ref:`Max Call Duration <system_global_configuration_max_call_duration>` from :ref:`Global configuration <global_configuration>` will be used for setting allowed time for the call;

      -  Checking if Vendor's max balance will be reached during the call (Step 11.5); On this stage Yeti will check if :ref:`Connect Fee <dialpeer_connect_fee>` of :ref:`Dialpeer <dialpeers>` record that was selected for this call is bigger than the result of subtracting :ref:`Max balance <account_max_balance>` and :ref:`Balance <account_balance>` of the :ref:`Vendor's Account <accounts>`. If Vendor's max balance will be reached during :ref:`Initial Interval <dialpeer_initial_interval>` of :ref:`Dialpeer <dialpeers>` record that was selected for this call - this :ref:`Gateway <gateways>` will be ignored and next :ref:`Gateway <gateways>` will be chosen from the list on Step 11.2;

      -  Post-routing numbers translations (Step 11.6). On this step of general routing algorithm Yeti makes post-Routing numbers translations. Yeti rewrites (if necessary) Name field in the Source-number, Source-number and Destination-number for incoming call (by :ref:`using POSIX Regular Expressions <posix_regular_expressions2>`) with using :ref:`Number translation settings <dialpeer_number_translation_settings>` of :ref:`Dialpeer <dialpeers>` record that was selected for this call;

      -  Adding Call Profile to the Array (Step 11.7). On this step Yeti will add Call Profile to the list (array) of Call Profiles. Call Profile will be used by Yeti/SEMS node for making call on Step 12 of general routing algorithm.


On the twelfth step of general routing algorithm Yeti/SEMS node will pass through list of Call Profiles that was received on previous step (Step 12). For each Call Profile following actions will be applied:

   -  Checking Disconnect Code (Step 12.1). On this step Yeti will check if Disconnect Code for Call Profile was initialized (not NULL). If yes - Yeti will initiate disconnecting (Step 12.6) from Originator (with using received Disconnect Code) after writing CDR & statistic for route/gateway (Step 12.3a);

   -  Trying to connect a call (Step 12.2). On this step Yeti will try to make a connection with LegB via :ref:`Gateway <gateways>` that was selected for current Call Profile. Regardless from call result (successful or not, length of call etc.) Yeti will write CDR & statistic for route/gateway (Step 12.3b) and will change customer's and vendor's balance at billing subsystem (in case of successful call with non-zero length) on Step 12.4. After the checking of call result (Step 12.5) Yeti will disconnect from Originator (Step 12.6) in case of successful call or will go the next Call Profile in the list (Step 12). Yeti will exit from the loop only when call had been made successfully or when all Call Profiles had been used;

   -  Writing CDR + writing statistic for route/gateway (Step 12.3 (a & b)). Information about call will be stored to the :ref:`CDR Table <cdr_partitions>` and current statistical parameters (count of answered telephone calls, general length of telephone calls) will be updated for :ref:`Dialpeer <dialpeers>` record that was selected for this call and for :ref:`Gateway <gateways>` that was used for this call;

   -  Change Customer's and Vendor's balance at billing subsystem (if necessary) (Step 12.4). On this step Yeti will change Customer's and Vendor's :ref:`balance <account_balance>` in case of successful call with non-zero length. For calculating prices of the call for Customer and Vendor following rules are used:


   .. _customer_price_calc_rules:

      -  **Customer's price calculation rules**. For calculate Customer's price for the call Yeti will summarize :ref:`Connect Fee <destination_connect_fee>` (in currency units) of :ref:`Destination <destinations>` record that was selected for this call, price of initial interval of call that is calculated as multiplication of :ref:`Initial Interval <destination_initial_interval>` (in seconds) of :ref:`Destination <destinations>` record to the :ref:`Initial Rate <destination_initial_rate>` (in currency units per minute) that was divided on length of a minute in seconds (60 seconds), and (in case of calls that are longer than :ref:`Initial Interval <destination_initial_interval>`)  price of next interval of call that is calculated as multiplication amount of :ref:`Next Intervals <destination_next_interval>` of :ref:`Destination <destinations>` record that was selected for this call that were placed in the duration of the call after :ref:`Initial Interval <destination_initial_interval>` to the :ref:`Next Rate <destination_next_rate>` (in currency units per minute) that was divided on length of a minute in seconds (60 seconds). At the last step Customer's price that was calculated will be increased on the value of value-added tax (VAT) that was specified for the Customer's :ref:`Account <accounts>`.

   .. _vendor_price_calc_rules:

      -  **Vendor's price calculation rules**. For calculate Vendor's price for the call Yeti will summarize :ref:`Connect Fee <dialpeer_connect_fee>` (in currency units) of :ref:`Dialpeer <dialpeers>` record that was selected for this call, price of initial interval of call that is calculated as multiplication of :ref:`Initial Interval <dialpeer_initial_interval>` (in seconds) of :ref:`Dialpeer <dialpeers>` record to the :ref:`Initial Rate <dialpeer_initial_rate>` (in currency units per minute) that was divided on length of a minute in seconds (60 seconds), and (in case of calls that are longer than :ref:`Initial Interval <dialpeer_initial_interval>`)  price of next interval of call that is calculated as multiplication amount of :ref:`Next Intervals <dialpeer_next_interval>` of :ref:`Dialpeer <dialpeers>` record that was selected for this call that were placed in the duration of the call after :ref:`Initial Interval <dialpeer_initial_interval>` to the :ref:`Next Rate <dialpeer_next_rate>` (in currency units per minute) that was divided on length of a minute in seconds (60 seconds);

      .. note:: Important notice:

         In normal mode changing Customer's and Vendor's balance at billing subsystem will be made **by subtraction** of the Customer's price that was calculated on this step from the Customer's :ref:`balance <account_balance>` and **by addition** Vendor's price to the Vendor's :ref:`balance <account_balance>`.
         But in case of enabling :ref:`Reverse billing <destination_reverse_billing>` flag of :ref:`Destination <destinations>` record that was selected for this call - Yeti **will add** Customer's price that was calculated on this step to the Customer's :ref:`balance <account_balance>`, and in case of enabling :ref:`Reverse billing <dialpeer_reverse_billing>` flag of :ref:`Dialpeer <dialpeers>` record that was selected for this call - Yeti **will subtract** Vendor's price from the Vendor's :ref:`balance <account_balance>`.
         Following formula is used for calculation both Customer's and Vendor's prices:

         .. math::

            \begin{equation}
            Price = (CF + II(\frac{IR}{60}) + [\frac{(CD-II)}{NI}]NI(\frac{NR}{60}))(1 + \frac{VAT}{100})
            \end{equation}

         where:
               -  Price - Customer's or Vendor's price;
               -  CF -    *Connect Fee* of :ref:`Destination <destinations>` (for Customer's price) or :ref:`Dialpeer <dialpeers>` (for Vendor's price), currency units;
               -  II - *Initial Interval* of :ref:`Destination <destinations>` (for Customer's price) or :ref:`Dialpeer <dialpeers>` (for Vendor's price), seconds;
               -  IR - *Initial Rate* of :ref:`Destination <destinations>` (for Customer's price) or :ref:`Dialpeer <dialpeers>` (for Vendor's price), currency units per minute;
               -  CD - *Call duration*, seconds;
               -  NI - *Next Interval* of :ref:`Destination <destinations>` (for Customer's price) or :ref:`Dialpeer <dialpeers>` (for Vendor's price), seconds;
               -  NR - *Next Rate* of :ref:`Destination <destinations>` (for Customer's price) or :ref:`Dialpeer <dialpeers>` (for Vendor's price), currency units per minute;
               -  VAT - Value-added tax, percents. VAT = 0 for calculating Vendor's price.

   -  Disconnect from Originator (Step 12.6).




YETI WEB interface - Routing menu description.

.. toctree::
   :maxdepth: 1

   yeti-ui-routing-customer_auths
   yeti-ui-routing-rateplans
   yeti-ui-routing-destinations
   yeti-ui-routing-routing_groups
   yeti-ui-routing-dialpeers
   yeti-ui-routing-routing_plans
   yeti-ui-routing-routing_plan_static_routes
   yeti-ui-routing-routing_plan_lnp_rules
   yeti-ui-routing-lnp_caches
   numberlists
   numberlist-items
   yeti-ui-routing-routing_tags
   yeti-ui-routing-areas
   yeti-ui-routing-area_prefixes
   yeti-ui-routing-routing_tag_detection_rules
   yeti-ui-routing-routing_simulation
   yeti-ui-routing-tags_truth_table
   yeti-ui-routing-prefix_truth_table


