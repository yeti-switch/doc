
================================
Guideline on Quick start of Yeti
================================

Yeti is user-friendly application and it very easy for configuration. You can see this by looking at the diagram of dependencies between objects :)

.. toctree::
   :maxdepth: 1

   dependencies


This Guideline contains step-by-step description of Yeti's configuration that will help to start it quickly just after finishing of the :ref:`installation process <install>`.
For configuration purposes :ref:`Yeti Web interface <web>` could be used.


Step 1. Creation of Contractors

At the first step it is necessary to configure two :ref:`Contractor's <contractors>` records: one with type :ref:`Customer <contractor_customer>` and second with type :ref:`Vendor <contractor_vendor>`.


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

At the second step it is necessary to configure two :ref:`Account's <accounts>` records: one will be linked to Contractor A (Customer) and second will be linked to Contractor B (Vendor).

.. table:: Example of records filling (only fields that should be changed from default values are shown)
   :widths: auto

   ==============================  ================  =================
           Field name                  Customer           Vendor
   ==============================  ================  =================
            Name                       Account A         Account B
          Contractor                   Contractor A      Contractor B
          Min balance                      0                0
           Max balance                    100               100
      Origination capacity                 5                 -
       Termination capacity                -                 5
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
       Origination capacity                5                 -
       Termination capacity                -                 5
   ------------------------------------------------  -----------------
   ------------------------------------------------  -----------------
                     **Signaling**                        **Tab**
   ------------------------------------------------  -----------------
            Host                          -              127.0.0.1
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



