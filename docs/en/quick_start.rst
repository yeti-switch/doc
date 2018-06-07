
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


.. table:: Example of records filling
   :widths: auto

   =================  ================  =================
     Field name           Customer           Vendor
   =================  ================  =================
        Name             Contractor A       Contractor B
       Enabled           True               True
        Vendor           False              True
       Customer          True               False
    Description          *Blank*             *Blank*
     Address             *Blank*             *Blank*
      Phones             *Blank*             *Blank*
    SMTP connection         -                   -
   =================  ================  =================

.. note::

   It is possible to use one record instead two by enabling both (:ref:`Customer <contractor_customer>` and :ref:`Vendor <contractor_vendor>`) flags.


Step 2. Creation of Accounts

At the second step it is necessary to configure two :ref:`Account's <accounts>` records: one will be linked to Contractor A (Customer) and second will be linked to Contractor B (Vendor).

.. table:: Example of records filling
   :widths: auto

   ==============================  ================  =================
           Field name                  Customer           Vendor
   ==============================  ================  =================
            Uuid                          1                  2
            Name                       Account A         Account B
          Contractor                   Contractor A      Contractor B
          Min balance                     100                0
           Max balance                    200               100
       Balance low threshold              100                0
       Balance high threshold             200               100
      Origination capacity                 5                 -
       Termination capacity                -                 5
    Vendor invoice period                  -                 -
    Customer invoice period                -                 -
    Vendor invoice template                -                 -
    Customer invoice template              -                 -
    Send invoices to                       -                 -
    Send balance notifications to          -                 -
    Timezone                              UTC               UTC
   ==============================  ================  =================


Step 3. Creation of Gateways

**TODO**


Step 4. Creation of Routing plans, Routing groups and Dialpeers

**TODO**

Step 5. Creation of Rateplan and Destinations

**TODO**

Step 6. Creation of Customer Auth

**TODO**

Step 7. Test the call

**TODO**


