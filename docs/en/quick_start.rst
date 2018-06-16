
================================
Guideline on Quick start of Yeti
================================

Yeti is user-friendly application and it very easy for configuration. You can see this by looking at the diagram of dependencies between objects :)

.. toctree::
   :maxdepth: 1

   dependencies


This Guideline contains step-by-step description of Yeti's configuration that will help to start it quickly just after finishing of the :ref:`installation process <install>`.
For configuration purposes :ref:`Yeti Web interface <web>` could be used.

.. _quick_start_chapter1:

Chapter 1.  Basic configuration
===============================


In this Chapter we'll configure Yeti for receiving calls on IP address **127.0.0.1** (any port, UDP) and switching them (in case if B-number starts from **380**) to the Gateway with IP address **128.0.0.1**.

**Step 1. Creation of Contractors**

At the first step it is necessary to configure two :ref:`Contractor's <contractors>` records: one with type :ref:`Customer <contractor_customer>` and second with type :ref:`Vendor <contractor_vendor>`. Both records should be *Enabled*.


.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   =================  ================  =================
     Field name           Customer           Vendor
   =================  ================  =================
        Name             Contractor A       Contractor B
       Enabled              True               True
        Vendor             False              True
       Customer             True               False
   =================  ================  =================

.. note::

   It is possible to use one record instead two by enabling both (:ref:`Customer <contractor_customer>` and :ref:`Vendor <contractor_vendor>`) flags.


**Step 2. Creation of Accounts**

At the second step it is necessary to configure two :ref:`Account's <accounts>` records: one will be linked to Contractor A (Customer) and second will be linked to Contractor B (Vendor). You should also set *Max balance* parameter for the Vendor to the some value that allow to make a call (current balance will be less than *Max balance* value). In our example we'll set 100 monetary units.

.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   ==============================  ================  =================
           Field name                  Customer           Vendor
   ==============================  ================  =================
            Name                       Account A         Account B
          Contractor                   Contractor A      Contractor B
           Max balance                     0               100
   ==============================  ================  =================


**Step 3. Creation of Gateways**

At the third step it is necessary to configure two :ref:`Gateway's <gateways>` records: one will be linked to Contractor A (Customer) and second will be linked to Contractor B (Vendor). Both records should be *Enabled*. It is also important to allow origination at the *Gateway A* and termination to the *Gateway B*.

.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   ==============================  ================  =================
           Field name                  Customer           Vendor
   ==============================  ================  =================
                     **General**                           **Tab**
   ------------------------------------------------  -----------------
            Name                       Gateway A         Gateway B
            Enabled                       True             True
          Contractor                   Contractor A      Contractor B
       Allow origination                  True               False
        Allow termination                 False              True
   ------------------------------------------------  -----------------
   ------------------------------------------------  -----------------
                     **Signaling**                        **Tab**
   ------------------------------------------------  -----------------
            Host                          -              128.0.0.1
   ==============================  ================  =================


**Step 4. Creation of Routing plan, Routing group and Dialpeer**

At the fourth step it is necessary to configure:

 - at least one :ref:`Routing Group's <routing_group>` record;

   .. table:: Example of records filling
      :widths: auto

      ==============================  =====================
                 Field name                   Value
      ==============================  =====================
               Name                      My RoutingGroup
      ==============================  =====================



 - at least one :ref:`Routing Plan's <routing_plan>` record that is associated with :ref:`Routing Group <routing_group>` above;

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                       Value
      ==============================  =====================
               Name                     My RoutingPlan
          Routing groups                My RoutingGroup
      ==============================  =====================



 - at least one :ref:`Dialpeer's <dialpeers>` record that should be associated with :ref:`Routing Group <routing_group>`, :ref:`Vendor <contractors>`, :ref:`Vendor's Account <accounts>` and :ref:`Vendor's Gateway <gateways>` that were configured above. In our example we use **380** (international code of Ukraine) as *Prefix* and we'll pay one monetary unit per minute to the Vendor after the initial interval (by default - 1 minute) and 2 monetary units during initial interval;

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                      Value
      ==============================  =====================
               Prefix                       380
        Enabled                             True
         Routing group                   My RoutingGroup
         Vendor                          Contractor B
         Account                         Account B
          Initial Rate                      2
         Next Rate                           1
         Gateway                          Gateway B
      ==============================  =====================



**Step 5. Creation of Rateplan and Destination**

At the fifth step it is necessary to configure:

 - at least one :ref:`Rateplan's <rateplans>` record;

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                      Value
      ==============================  =====================
               Name                        My RatePlan
      ==============================  =====================



 - at least one :ref:`Destination's <destinations>` record that should be associated with with :ref:`Rateplan <rateplans>` above. In our example we also use **380** (international code of Ukraine) as *Prefix*  and we'll receive 1.5 monetary units per minute from Customer after the initial interval and 3 monetary units during initial interval. So, in case of call with ten minutes length the profit will be (3-2)+(10-1)*(1.5-1) = 5.5 monetary units (16.5 will be received from the Customer and 11 will be paid to the Vendor);

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                      Value
      ==============================  =====================
             **New Destination**           **Section**
      ------------------------------  ---------------------
               Prefix                       380
            Enabled                           True
           Rateplan                          My RatePlan
      ------------------------------  ---------------------
      ------------------------------  ---------------------
             **Fixed rating**           **Section**
      ------------------------------  ---------------------
          Initial rate                        3
          Next rate                           1.5
      ==============================  =====================



**Step 6. Creation of Customer Auth**

At the sixth step it is necessary to configure at least one :ref:`Customers Auth's <customer_auth>` record that should be associated with :ref:`Customer <contractors>`, :ref:`Customer's Account <accounts>` and :ref:`Customer's Gateway <gateways>`, :ref:`Rateplan <rateplans>` and :ref:`Routing Group <routing_group>` that were configured above.

.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   ==============================  =====================
           Field name                      Value
   ==============================  =====================
          **General**                   **Tab**
   ------------------------------  ---------------------
            Name                      My CustomerAuth
           Customer                    Contractor A
            Account                     Account A
            Gateway                       Gateway A
             Rateplan                     My RatePlan
        Routing plan                  My RoutingPlan
   ==============================  =====================


**Step 7. Test the call**

At the last step it is necessary to create some :ref:`Payment's <payments>` record for topping up the balance of Account A and test the call (Customer's balance should be greater than *Min balance* value).

.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   ==============================  =====================
           Field name                       Value
   ==============================  =====================
            Account                    Account A
            Amount                        50
   ==============================  =====================

Fot the call testing it is necessary to fill :ref:`Routing Simulation <routing_simulation>` form and to press **Simulate routing** button.

.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

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

.. _quick_start_chapter2:

Chapter 2.  Additional Dialpeers
================================

In this Chapter we'll improve basic configuration that is described in :ref:`Chapter 1 <quick_start_chapter1>` above by adding new :ref:`Dialpeers <dialpeers>` that will help to spend less money for calling to the numbers that have some prefixes.

In our new example the same :ref:`Vendor <contractors>` (Contractor B from basic configuration) proposed us special price for all calls that will be made to the numbers that start from **38048** (regional code of Odessa city in Ukraine).

**Step 1. Creation of additional Dialpeer**

At the first step we'll configure one additional :ref:`Dialpeer's <dialpeers>` record that should be associated with :ref:`Routing Group <routing_group>`, :ref:`Vendor <contractors>`, :ref:`Vendor's Account <accounts>` and :ref:`Vendor's Gateway <gateways>` that were configured in :ref:`Chapter 1 <quick_start_chapter1>` above. In our example we use **38048** as *Prefix* and we'll pay 0.5 monetary unit per minute to the Vendor after the initial interval (by default - 1 minute) and 1 monetary units during initial interval;

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                      Value
      ==============================  =====================
               Prefix                       38048
        Enabled                             True
         Routing group                   My RoutingGroup
         Vendor                          Contractor B
         Account                         Account B
          Initial Rate                      1
         Next Rate                          0.5
         Gateway                          Gateway B
      ==============================  =====================

**Step 2. Creation of Destination**

At the second step we'll  configure :ref:`Destination's <destinations>` record that should be associated with with :ref:`Rateplan <rateplans>` that was configured in :ref:`Chapter 1 <quick_start_chapter1>` above. In our example we also use **38048** as *Prefix*  and we'll receive 0.75 monetary units per minute from Customer after the initial interval and 1.5 monetary units during initial interval. So, in case of call with ten minutes length the profit will be (1.5-1)+(10-1)*(0.75-0.5) = 2.75 monetary units (8.25 will be received from the Customer and 5.5 will be paid to the Vendor);

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                      Value
      ==============================  =====================
             **New Destination**           **Section**
      ------------------------------  ---------------------
               Prefix                       38048
            Enabled                           True
           Rateplan                          My RatePlan
      ------------------------------  ---------------------
      ------------------------------  ---------------------
             **Fixed rating**           **Section**
      ------------------------------  ---------------------
          Initial rate                        1.5
          Next rate                           0.75
      ==============================  =====================

**Step 3. Test the call**

Fot the call testing it is necessary to fill :ref:`Routing Simulation <routing_simulation>` form and to press **Simulate routing** button.

.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   ==============================  =====================
           Field name                       Value
   ==============================  =====================
           Remote ip                   127.0.0.1
           Remote port                     10000
           Src number                    001234567890
            Dst number                   380487050321
   ==============================  =====================

As a result two records will be shown, where the first record is an actual record of Call Profile that will be send to the Yeti/SEMS node for making call. This Call Profile has Initial and Next Rates of Dealpeer and Destination that were newly created. Full log of call processing also will be shown under the resulting records.

.. note::

   If you don't see necessary results, please, make sure that you enter everything correctly.

.. _quick_start_chapter3:

Chapter 3.  Alternative Gateway for calls from selected Destination
===================================================================

In this Chapter we'll improve configuration that is described in :ref:`Chapter 2 <quick_start_chapter2>` above by adding new :ref:`Vendor's Gateway <gateways>` that will be used for terminating calls that were received from specific :ref:`Destination <destinations>`.

**Step 1. Creation of Gateway Group and new termination Gateway**

At the first step we'll configure:


- one :ref:`Gateway group's <gateway_groups>` record;

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                      Value
      ==============================  =====================
               Name                     My Gateway Group
               Vendor                     Contractor B
      ==============================  =====================


- one additional termination :ref:`Gateway's <gateways>` record that will be linked to Contractor B (Vendor).

.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   ==============================  ================
           Field name                  Value
   ==============================  ================
                     **General**         **Tab**
   ------------------------------------------------
            Name                       Gateway B
            Enabled                       True
          Contractor                   Contractor B
       Allow origination                  False
        Allow termination                 True
   ------------------------------------------------
   ------------------------------------------------
                     **Signaling**       **Tab**
   ------------------------------------------------
            Host                        129.0.0.1
   ==============================  ================
