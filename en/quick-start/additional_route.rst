
.. _quick_start_chapter2:

================
Additional Route
================

In this Chapter we'll improve basic configuration that is described in :ref:`Chapter 1 <quick_start_chapter1>` above by adding new :ref:`Dialpeers <dialpeers>` that will help to spend less money for calling to the alternative routes.

In our new example the same :ref:`Vendor <contractors>` (Contractor B from basic configuration) proposed us special price for all calls that will be made to the numbers that start from **38048** (code of Odesa region in Ukraine).

.. mermaid::

    graph LR
        gw1[Customer gw</br> IP 127.0.0.1]
        gw2[Vendor Gateway B</br>IP 128.0.0.1]
        subgraph yeti[Yeti SBC]
                destination380[Destination</br>prefix: 380</br>rate:1.5]
                dialpeer380[Dialpeer</br>prefix: 380</br>rate:1.0]
                dialpeer38048[Dialpeer</br>prefix: 38048</br>rate:0.5]
        end


        gw1 -->|Call to <b>380</b>662296132</br> rate $1.5/minute| destination380
        destination380 --> dialpeer380
        dialpeer380 -->|Call to <b>380</b>662296132</br> rate $1.0/minute| gw2

        gw1 -->|Call to <b>38048</b>7860570</br> rate $1.5/minute| destination380
        destination380 --> dialpeer38048
        dialpeer38048 -->|Call to <b>38048</b>7860570</br> rate $0.5/minute| gw2

        linkStyle 0 stroke-width:2px,fill:none,stroke:green;
        linkStyle 1 stroke-width:2px,fill:none,stroke:green;
        linkStyle 2 stroke-width:2px,fill:none,stroke:green;
        linkStyle 3 stroke-width:2px,fill:none,stroke:blue;
        linkStyle 4 stroke-width:2px,fill:none,stroke:blue;
        linkStyle 5 stroke-width:2px,fill:none,stroke:blue;


1. Creation of additional Dialpeer
==================================

At the first step we'll configure one additional :ref:`Dialpeer <dialpeers>` that should be associated with :ref:`Routing Group <routing_group>`, :ref:`Vendor <contractors>`, :ref:`Vendor's Account <accounts>` and :ref:`Vendor's Gateway <gateways>` that were configured in :ref:`Chapter 1 <quick_start_chapter1>` above. In our example we use **38048** as **Prefix** and we'll pay 0.5 monetary unit per minute.

======================= =====================================
  Object to create                Attributes
======================= =====================================
Dialpeer                  * Prefix: 38048
                          * Enabled: True
                          * Routing Group: My RoutingGroup
                          * Vendor: Contractor B
                          * Account: Account B
                          * Initial Rate: 0.5
                          * Next Rate: 0.5
                          * Gateway: Gateway B
======================= =====================================


2. Test the call
================

For the call testing it is necessary to fill :ref:`Routing Simulation <routing_simulation>` form and to press **Simulate routing** button.

   ==============================  =====================
           Field name                       Value
   ==============================  =====================
           Remote ip                   127.0.0.1
           Remote port                     10000
           Src number                    001234567890
            Dst number                   380487860570
   ==============================  =====================

As a result two records will be shown, where the first record is an actual record of Call Profile that will be send to the Yeti/SEMS node for making call. This Call Profile has Initial and Next Rates of Dialpeer that was newly created. Full log of call processing also will be shown under the resulting records.
