
================================
Guideline on Quick start of Yeti
================================

Yeti is user-friendly application and it very easy for configuration. You can see this by looking at the diagram of dependencies between objects :)

.. toctree::
   :maxdepth: 1

   dependencies


This Guideline contains step-by-step description of Yeti's configuration that will help to start it quickly just after finishing of the :ref:`installation process <install>`.
For configuration purposes :ref:`Yeti Web interface <web>` could be used.

Chapter 1.  Basic configuration
===============================


In this Chapter we'll configure Yeti for receiving calls on IP address **127.0.0.1** (any port, UDP) and switching them (in case if B-number starts from **380**) to the Gateway with IP address **128.0.0.1**. In our example we'll pay one monetary unit per minute  to the Vendor after the initial interval (by default - 1 minute) and 2 monetary units during initial interval. From other side we'll receive 1.5 monetary units per minute from Cutomer after the initial interval and 3 monetary units during initial interval. So, in case of call with ten minutes length the profit will be (3-2)+(10-1)*(1.5-1) = 5.5 monetary units (16.5 will be received from the Customer and 11 will be paid to the Vendor).

Step 1. Creation of Contractors

At the first step it is necessary to configure two :ref:`Contractor's <contractors>` records: one with type :ref:`Customer <contractor_customer>` and second with type :ref:`Vendor <contractor_vendor>`. Both records should be *Enabled*.


.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   =================  ================  =================
     Field name           Customer           Vendor
   =================  ================  =================
        Name             Contractor A       Contractor B
       Enabled           True               True
        Vendor           False              True
       Customer          True               False
   =================  ================  =================

.. note::

   It is possible to use one record instead two by enabling both (:ref:`Customer <contractor_customer>` and :ref:`Vendor <contractor_vendor>`) flags.


Step 2. Creation of Accounts

At the second step it is necessary to configure two :ref:`Account's <accounts>` records: one will be linked to Contractor A (Customer) and second will be linked to Contractor B (Vendor). You should also set *Max balance* parameter for the Vendor to the some value that allow to make a call at least during initial interval (in our example we'll set 100 monetary units).

.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   ==============================  ================  =================
           Field name                  Customer           Vendor
   ==============================  ================  =================
            Name                       Account A         Account B
          Contractor                   Contractor A      Contractor B
           Max balance                     0               100
   ==============================  ================  =================


Step 3. Creation of Gateways

At the third step it is necessary to configure two :ref:`Gateway's <gateways>` records: one will be linked to Contractor A (Customer) and second will be linked to Contractor B (Vendor).

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


Step 4. Creation of Routing plans, Routing groups and Dialpeers

At the fourth step it is necessary to configure:

 - at least one :ref:`Routing Group's <routing_group>` record;

   .. table:: Example of records filling
      :widths: auto

      ==============================  =====================
                 Field name                   Value
      ==============================  =====================
               Name                      My RoutingGroup
      ==============================  =====================



 - at least one :ref:`Routing Plan's <routing_plan>` record;

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                       Value
      ==============================  =====================
               Name                     My RoutingPlan
          Routing groups                My RoutingGroup
      ==============================  =====================



 - at least one :ref:`Dialpeer's <dialpeers>` record;

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                      Value
      ==============================  =====================
               Prefix                       000
        Enabled                             True
         Routing group                   My RoutingGroup
         Vendor                          Contractor B
         Account                         Account B
          Initial Rate                      2
         Next Rate                           1
         Gateway                          Gateway B
      ==============================  =====================



Step 5. Creation of Rateplan and Destinations

At the fifth step it is necessary to configure:

 - at least one :ref:`Rateplan's <rateplans>` record;

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                      Value
      ==============================  =====================
               Name                        My RatePlan
      ==============================  =====================



 - at least one :ref:`Destination's <destinations>` record;

   .. table:: Example of records filling (only fields that should be changed from default values are shown)
      :widths: auto

      ==============================  =====================
              Field name                      Value
      ==============================  =====================
             **New Destination**           **Section**
      ------------------------------  ---------------------
               Prefix                       0000
            Enabled                           True
           Rateplan                          My RatePlan
      ------------------------------  ---------------------
      ------------------------------  ---------------------
             **Fixed rating**           **Section**
      ------------------------------  ---------------------
          Initial rate                        3
          Next rate                           1.5
      ==============================  =====================



Step 6. Creation of Customer Auth

At the sixth step it is necessary to configure at least one :ref:`Customers Auth's <customer_auth>` record.

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


Step 7. Test the call

At the last step it is necessary to create some :ref:`Payment's <payments>` record for topping up the balance of Account A and test the call.

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
           Remote port                     1000
           Src number                    0000123
            Dst number                    00001234
   ==============================  =====================

