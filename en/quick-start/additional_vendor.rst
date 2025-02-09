.. _quick_start_chapter3:

===============================
Additional termination provider
===============================

In this Chapter we'll add additional local termination partner(Vendor 2) who providing route to **38048705** prefix with price **$0.2 per minute**. We also will provide better price to this destination for customer. Configuration based on :ref:`Chapter 2 <quick_start_chapter2>`

.. mermaid::

    graph LR
        gw1[Customer gw</br> IP 127.0.0.1]
        gw2[Vendor gw</br>IP 128.0.0.1]
        gw3[Vendor2 gw</br>IP 129.0.0.1]

        subgraph yeti[Yeti SBC]
                subgraph Rateplan
                        destination380[Destination</br>prefix: 380</br>rate:1.5]
                        destination38048705[Destination</br>prefix: 38048705</br>rate:1.0]
                end
                subgraph RoutingPlan
                        dialpeer380[Dialpeer</br>prefix: 380</br>rate:1.0]
                        dialpeer38048[Dialpeer</br>prefix: 38048</br>rate:0.5]
                        dialpeer38048705[Dialpeer</br>prefix: 38048705</br>rate:0.2]
                end

        end


        gw1 -->|Call to <b>380</b>662296132</br> rate $1.5/minute| destination380
        destination380 --> dialpeer380
        dialpeer380 -->|Call to <b>380</b>662296132</br> rate $1.0/minute| gw2

        gw1 -->|Call to <b>38048</b>7050321</br> rate $1.5/minute| destination380
        destination380 --> dialpeer38048
        dialpeer38048 -->|Call to <b>38048</b>7050321</br> rate $0.5/minute| gw2

        gw1 -->|Call to <b>38048705</b>0321</br> rate $1.0/minute| destination38048705
        destination38048705 --> dialpeer38048705
        dialpeer38048705 -->|Call to <b>38048705</b>0321</br> rate $0.2/minute| gw3

        linkStyle 0 stroke-width:2px,fill:none,stroke:green;
        linkStyle 1 stroke-width:2px,fill:none,stroke:green;
        linkStyle 2 stroke-width:2px,fill:none,stroke:green;
        linkStyle 3 stroke-width:2px,fill:none,stroke:blue;
        linkStyle 4 stroke-width:2px,fill:none,stroke:blue;
        linkStyle 5 stroke-width:2px,fill:none,stroke:blue;
        linkStyle 6 stroke-width:2px,fill:none,stroke:violet;
        linkStyle 7 stroke-width:2px,fill:none,stroke:violet;
        linkStyle 8 stroke-width:2px,fill:none,stroke:violet;




1. Creation of new Vendor and Account
=====================================

At the first step we'll configure one additional :ref:`Contractor <contractors>` and :ref:`Account <accounts>` for it

======================= ===========================
  Object to create             Attributes
======================= ===========================
Contractor              * Name: Vendor2
                        * Enabled: True
                        * Vendor: True
                        * Customer: False

Account                 * Name Vendor2 Account
                        * Contractor: Vendor2
                        * Max Balance: 100
======================= ===========================



2. Creation of new termination Gateway
======================================

At the second step we'll configure one additional termination :ref:`Gateway <gateways>` that will be linked to Vendor2

======================= ===========================
  Object to create             Attributes
======================= ===========================
Gateway                 * Name: Vendor2 Gateway
                        * Contractor: Vendor2
                        * Enabled: True
                        * Allow origination: False
                        * Allow termination: True
                        * Host: 129.0.0.1
======================= ===========================


3. Creation of additional Dialpeer
==================================

At the third step we'll configure one additional :ref:`Dialpeer <dialpeers>` to route calls to prefix **38048705** via new termination gateway with price $0.2 per minute.


======================= =================================
  Object to create             Attributes
======================= =================================
Dialpeer                * Prefix: 38048705
                        * Enabled: True
                        * Routing Group: My RoutingGroup
                        * Vendor: Vendor2
                        * Account: Vendor2 Account
                        * Initial Rate: 0.2
                        * Next Rate: 0.2
                        * Gateway: Vendor2 Gateway
======================= =================================


4. Test the call
================

For the call testing it is necessary to fill :ref:`Routing Simulation <routing_simulation>` form and to press **Simulate routing** button.

==============================  =====================
           Field name                       Value
==============================  =====================
           Remote ip                   127.0.0.1
           Remote port                     10000
           Src number                    001234567890
            Dst number                   380487050321
==============================  =====================

As a result two records will be shown, where the first record is an actual record of Call Profile that will be send to the Yeti/SEMS node for making call. This Call Profile uses Gateway C for termination the call. Full log of call processing also will be shown under the resulting records.

.. note::

   If you don't see necessary results, please, make sure that you enter everything correctly.
