=======
Routing
=======

This section describes authentication and routing principles.


General routing algorithm is represented on the picture below:

 .. graphviz:: graphviz/general.dot

On the first step of general routing algorithm :ref:`authentication <customer_auth>` will be made.

On the second step of general routing algorithm Yeti will check Customer's balance if :ref:`Check account balance <customer_check_account_balance>` flag of :ref:`Customer Auth <customer_auth>` record is enabled.

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


