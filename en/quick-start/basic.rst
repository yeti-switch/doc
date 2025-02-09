.. _quick_start_chapter1:

===================
Basic configuration
===================

This Guideline explains how to configure Yeti to route your first test call.


In this Chapter we'll configure Yeti for receiving calls on IP address **127.0.0.1** (any port, UDP) and switching them (in case if B-number starts from **380**) to the Gateway with IP address **128.0.0.1**.


.. mermaid::

    graph LR
        gw1[Customer gw</br> IP 127.0.0.1]
        gw2[Vendor gw</br>IP 128.0.0.1]
        yeti[Yeti SBC]

        gw1 -->|Call to 380662296132| yeti
        yeti -->|Call to 380662296132| gw2

        gw1 -->|Cashflow</br>rate $1.5/minute| yeti
        yeti -->|Cashflow</br>rate $1.0/minute| gw2


1. Creation of Contractors
==========================

At the first step it is necessary to configure two :ref:`Contractors <contractors>`: one with type :ref:`Customer <contractor_customer>` and second with type :ref:`Vendor <contractor_vendor>`. Both contractors should be *Enabled*.


======================= ========================
  Object to create             Attributes
======================= ========================
Contractor              * Name: Contractor A
                        * Enabled: True
                        * Vendor: False
                        * Customer: True

Contractor              * Name: Contractor B
                        * Enabled: True
                        * Vendor: True
                        * Customer: False
======================= ========================


2. Creation of Accounts
=======================

At the second step it is necessary to configure two :ref:`Accounts <accounts>`: one will be linked to Contractor A (Customer) and second will be linked to Contractor B (Vendor). You should also set **Max balance** parameter for the Vendor to the some value that allow to make a call (current balance will be less than **Max balance** value). In our example we'll set 100 monetary units.


======================= ===============================
  Object to create              Attributes
======================= ===============================
Account                 * Name: Account A
                        * Contractor: Contractor A

Account                 * Name: Account B
                        * Contractor: Contractor B
                        * Max Balance: 100
======================= ===============================


3. Creation of Gateways
=======================

At the third step it is necessary to configure two :ref:`Gateways <gateways>`: one will be linked to Contractor A (Customer) and second will be linked to Contractor B (Vendor). Both records should be **Enabled**. It is also important to allow origination at the **Gateway A** and termination to the **Gateway B**.



======================= ===============================
  Object to create                Attributes
======================= ===============================
Gateway                 * Name: Gateway A
                        * Contractor: Contractor A
                        * Enabled: True
                        * Allow Origination: True
                        * Allow Termination: False

Gateway                 * Name: Gateway B
                        * Contractor: Contractor B
                        * Enabled: True
                        * Allow Origination: False
                        * Allow Termination: True
                        * **Host: 128.0.0.1**
======================= ===============================


.. note:: Host TODO


4. Creation of Routing plan, Routing group and Dialpeer
=======================================================

At the fourth step it is necessary to configure:

 - at least one :ref:`Routing Group <routing_group>`;
 - at least one :ref:`Routing Plan <routing_plan>` that is associated with :ref:`Routing Group <routing_group>` above;
 - at least one :ref:`Dialpeer <dialpeers>` that should be associated with :ref:`Routing Group <routing_group>`, :ref:`Vendor <contractors>`, :ref:`Vendor's Account <accounts>` and :ref:`Vendor's Gateway <gateways>` that were configured above. In our example we use **380** (international code of Ukraine) as *Prefix* and we'll pay one monetary unit per minute to the Vendor after the initial interval (by default - 1 second) and 2 monetary units during initial interval. This :ref:`Dialpeer <dialpeers>` will be used as a route for all traffic to Ukrainian numbers;


======================= =====================================
  Object to create                Attributes
======================= =====================================
Routing Group             * Name: My RoutingGroup


Routing Plan              * Name: My RoutingPlan
                          * Routing Groups: My RoutingGroup

Dialpeer                  * Prefix: 380
                          * Enabled: True
                          * Routing Group: My RoutingGroup
                          * Vendor: Contractor B
                          * Account: Account B
                          * Initial Rate: 2
                          * Next Rate: 1
                          * Gateway: Gateway B
======================= =====================================


5. Creation of Rateplan and Destination
=======================================

At the fifth step it is necessary to configure:

 - at least one :ref:`Rateplan <rateplans>`;
 - at least one :ref:`Rate Group <rate_groups>`;
 - at least one :ref:`Destination <destinations>` that should be associated with with :ref:`Rate Group <rate_groups>` above. In our example we also use **380** (international code of Ukraine) as *Prefix*  and we'll receive 1.5 monetary units per minute from Customer after the initial interval and 3 monetary units during initial interval. So, in case of call with ten minutes length the profit will be (3-2)+(10-1)*(1.5-1) = 5.5 monetary units (16.5 will be received from the Customer and 11 will be paid to the Vendor);


======================= =====================================
  Object to create                Attributes
======================= =====================================
Rate Group                * Name: My RateGroup


Rateplan                  * Name: My Rateplan
                          * Rate Groups: My RateGroup


Destination               * Prefix: 380
                          * Enabled: True
                          * Rate Group: My RateGroup
                          * Initial Rate: 3
                          * Next Rate: 1.5
======================= =====================================



6. Creation of Customer Auth
============================

At the sixth step it is necessary to configure at least one :ref:`Customers Auth <customer_auth>` that should be associated with :ref:`Customer <contractors>`, :ref:`Customer's Account <accounts>` and :ref:`Customer's Gateway <gateways>`, :ref:`Rateplan <rateplans>` and :ref:`Routing Group <routing_group>` that were configured above.

======================= =====================================
  Object to create                Attributes
======================= =====================================
CustomerAuth              * Name: My CustomerAuth
                          * Customer: Contractor A
                          * Account: Account A
                          * Gateway: Gateway A
                          * Rateplan: My RatePlan
                          * RoutingPlan: My RoutingPlan
                          * IP: 127.0.0.1
======================= =====================================


7. Test the call
================

At the last step it is necessary to create some :ref:`Payment <payments>` for topping up the balance of Account A and test the call (Customer's balance should be greater than **Min balance** value).



======================= =====================================
  Object to create                Attributes
======================= =====================================
Payment                   * Account: Account A
                          * Amount: 50
======================= =====================================


For the call testing it is necessary to fill :ref:`Routing Simulation <routing_simulation>` form and to press **Simulate routing** button.

   ==============================  =====================
           Field name                       Value
   ==============================  =====================
           Remote ip                   127.0.0.1
           Remote port                     10000
           Src number                    001234567890
            Dst number                   380662296132
   ==============================  =====================

As a result two records will be shown, where the first record is an actual record of Call Profile that will be send to the Yeti/SEMS node for making call. Full log of call processing also will be shown under the resulting records.

.. note::

   If you don't see necessary results, please, make sure that you enter everything correctly.
