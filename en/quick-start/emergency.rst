.. _quick_start_chapter5:

===============
Emergency calls
===============

In this Chapter we'll change configuration that is described in :ref:`Chapter 1 <quick_start_chapter1>` above by adding possibility to make free call to the emergency number (**112**) even in case of zero balance of Customer's account.


1. Editing of the Customer Auth record
======================================

At the first step it is necessary to edit :ref:`Customers Auth <customer_auth>` that was configured in :ref:`Chapter 1 <quick_start_chapter1>` above by disabling **Check account balance** flag.


2. Adding new Destination for emergency calls
=============================================

At the second step we'll  configure :ref:`Destination <destinations>` that should be associated with  :ref:`Rateplan <rateplans>` that was configured in :ref:`Chapter 1 <quick_start_chapter1>` above. In our example we will use **112** as *Prefix* and we'll receive 0 monetary units per minute from Customer after the initial interval and 0 monetary units during initial interval. It is also important to set value of the **Profit control mode** field into the **no control** value.

=============================== =====================================
  Object to create                Attributes
=============================== =====================================
Destination                     * Prefix: 112
                                * Dst number min length: 3
                                * Dst number max length: 3
                                * Enabled: True
                                * Rate Group: My RateGroup
                                * Initial rate: 0
                                * Next rate: 0
                                * Profit control mode: no control
=============================== =====================================


3. Creation new Dialpeer for emergency calls
============================================

At the third step we'll configure one additional :ref:`Dialpeer <dialpeers>` that should be associated with :ref:`Routing Group <routing_group>`, :ref:`Vendor <contractors>`, :ref:`Vendor's Account <accounts>`, :ref:`Vendor's Gateway B <gateways>` that were configured in :ref:`Chapter 1 <quick_start_chapter1>`. In our example we use **112** as *Prefix* and we'll pay 0 monetary unit per minute to the Vendor after the initial interval (by default - 1 minute) and 0 monetary units during initial interval.


=============================== =====================================
  Object to create                Attributes
=============================== =====================================
Dialpeer                        * Prefix: 112
                                * Dst number min length: 3
                                * Dst number max length: 3
                                * Enabled: True
                                * Routing Group: My RoutingGroup
                                * Vendor: Contractor B
                                * Account: Account B
                                * Initial rate: 0
                                * Next rate: 0
                                * Gateway: Gateway B
=============================== =====================================


4. Test the call
================

For the call testing it is necessary to fill :ref:`Routing Simulation <routing_simulation>` form and to press **Simulate routing** button.

   ==============================  =====================
           Field name                       Value
   ==============================  =====================
           Remote ip                   127.0.0.1
           Remote port                     10000
           Src number                    331234567890
            Dst number                      112
   ==============================  =====================

As a result two records will be shown, where the first record is an actual record of Call Profile that will be send to the Yeti/SEMS node for making call. This Call Profile uses newly created :ref:`Destination's <destinations>` and :ref:`Dialpeer's <dialpeers>` records as a basis for Customer's and Vendor's billing and will work also in case zero balance of Customer's Account. Full log of call processing also will be shown under the resulting records.

.. note::

   If you don't see necessary results, please, make sure that you enter everything correctly.
