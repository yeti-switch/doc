.. _quick_start_chapter4:

====================
Origin based billing
====================

In this Chapter we'll improve configuration that is described in :ref:`Chapter 3 <quick_start_chapter3>` above by adding origin based billing.

In our example Vendor 2(who providing route to **38048705** prefix) also want to accept international calls from France(country core 33) with price **$1.5 per minute**. We are going to sell such traffic(from France to **38048705** prefix) for **$2.5 per minute** to customer.

.. mermaid::

    graph LR
        gw1[Customer gw</br> IP 127.0.0.1]
        gw2[Vendor gw</br>IP 128.0.0.1]
        gw3[Vendor2 gw</br>IP 129.0.0.1]

        subgraph yeti[Yeti SBC]
                subgraph RoutingTagDetectionRules
                        rtd380[No rule found.</br>do nothing]
                        rtd33[dst_prefix: <b>380</b></br>src_prefix: <b>33</b></br>append tag <b>France_to_UA</b>]
                end
                subgraph Rateplan
                        destination380[Destination</br>prefix: 380</br><b>not tagged</b></br>rate:1.5]
                        destination38048705[Destination</br>prefix: 38048705</br><b>not tagged</b></br>rate:1.0]
                        destination38048705_france[Destination</br>prefix: 38048705</br>tag: <b>France_to_UA</b></br>rate:2.5]
                end
                subgraph RoutingPlan
                        dialpeer380[Dialpeer</br>prefix: 380</br><b>not tagged</b></br>rate:1.0]
                        dialpeer38048[Dialpeer</br>prefix: 38048</br><b>not tagged</b></br>rate:0.5]
                        dialpeer38048705[Dialpeer</br>prefix: 38048705</br><b>not tagged</b></br>rate:0.5]
                        dialpeer38048705_france[Dialpeer</br>prefix: 38048705</br>tag: <b>France_to_UA</b></br>rate:1.5]
                end

        end


        gw1 -->|Call to <b>380</b>662296132</br>from <b>380</b>971122338</br>rate $1.5/minute| rtd380
        rtd380 -->|no tags| destination380
        destination380 -->|no tags| dialpeer380
        dialpeer380 -->|Call to <b>380</b>662296132</br>from <b>380</b>971122338</br>rate $1.0/minute| gw2

        gw1 -->|Call to <b>38048</b>7050321</br>from <b>380</b>971122338</br>rate $1.5/minute| rtd380
        rtd380 -->|no tags| destination380
        destination380 -->|no tags| dialpeer38048
        dialpeer38048 -->|Call to <b>38048</b>7050321</br>from <b>380</b>971122338</br>rate $0.5/minute| gw2

        gw1 -->|Call to <b>38048705</b>0321</br>from <b>380</b>971122338</br>rate $1.0/minute| rtd380
        rtd380 -->|no tags| destination38048705
        destination38048705 -->|no tags| dialpeer38048705
        dialpeer38048705 -->|Call to <b>38048705</b>0321</br>from <b>380</b>971122338</br>rate $0.5/minute| gw3

        gw1 -->|Call to <b>38048705</b>0321</br>from <b>33</b>109758351</br>rate $2.5/minute| rtd33
        rtd33 -->|tag France_to_UA| destination38048705_france
        destination38048705_france -->|tag France_to_UA| dialpeer38048705_france
        dialpeer38048705_france -->|Call to <b>38048705</b>0321</br>from 380</br>rate $1.5/minute| gw3


        linkStyle 0 stroke-width:2px,fill:none,stroke:green;
        linkStyle 1 stroke-width:2px,fill:none,stroke:green;
        linkStyle 2 stroke-width:2px,fill:none,stroke:green;
        linkStyle 3 stroke-width:2px,fill:none,stroke:green;
        linkStyle 4 stroke-width:2px,fill:none,stroke:blue;
        linkStyle 5 stroke-width:2px,fill:none,stroke:blue;
        linkStyle 6 stroke-width:2px,fill:none,stroke:blue;
        linkStyle 7 stroke-width:2px,fill:none,stroke:blue;
        linkStyle 8 stroke-width:2px,fill:none,stroke:violet;
        linkStyle 9 stroke-width:2px,fill:none,stroke:violet;
        linkStyle 10 stroke-width:2px,fill:none,stroke:violet;
        linkStyle 11 stroke-width:2px,fill:none,stroke:violet;
        linkStyle 12 stroke-width:2px,fill:none,stroke:orange;
        linkStyle 13 stroke-width:2px,fill:none,stroke:orange;
        linkStyle 14 stroke-width:2px,fill:none,stroke:orange;
        linkStyle 15 stroke-width:2px,fill:none,stroke:orange;


Orange line represent call routing logic for calls with France CLI to destination network 38048705.


1. Adding Areas and Area Prefixes
=================================

At the first step it is necessary to configure:

 - two :ref:`Areas <areas>` (one for France and one for Ukraine);

======================= =====================================
  Object to create                Attributes
======================= =====================================
Area                      * Name: Ukraine
Area                      * Name: France
======================= =====================================

 - two :ref:`Area prefixes <area_prefixes>` that should be associated with :ref:`Areas <areas>`  above.

======================= =====================================
  Object to create                Attributes
======================= =====================================
Area Prefix               * Prefix: 380
                          * Area: Ukraine
Area Prefix               * Prefix: 33
                          * Name: France
======================= =====================================


2. Adding Routing Tag and Routing Tag Detection Rule
====================================================

At the second step it is necessary to configure:

 -  :ref:`Routing Tag <routing_tag>` to mark calls from France to Ukraine

======================= =====================================
  Object to create                Attributes
======================= =====================================
Routing Tag               * Name: France_to_UA
======================= =====================================

 -  :ref:`Routing Tag detection Rule <routing_tag_detection_rules>` to append routing tag to calls from France to Ukraine


=============================== =====================================
  Object to create                Attributes
=============================== =====================================
Routing Tag detection Rule      * Src Area: France
                                * Dst Area: Ukraine
                                * Tag Action: Append selected tags
                                * Tag Action value: France_to_UA
=============================== =====================================



3. Adding Destination
=====================

At the third step we'll configure additional :ref:`Destination <destinations>` to charge customer traffic tagged as **France_to_UA** with different price.

=============================== =====================================
  Object to create                Attributes
=============================== =====================================
Destination                     * Prefix: 38048705
                                * Enabled: True
                                * Rate Group: My RateGroup
                                * Routing tags: France_to_UA
                                * Routing mode: AND
                                * Initial rate: 2.5
                                * Next rate: 2.5
=============================== =====================================



4. Adding Dialpeer
==================

At the fourth step we'll add :ref:`Dialpeer <dialpeers>` to properly calculate price we have to pay to vendor for traffic from France


=============================== =====================================
  Object to create                Attributes
=============================== =====================================
Dialpeer                        * Prefix: 38048705
                                * Enabled: True
                                * Routing Group: My RoutingGroup
                                * Routing tags: France_to_UA
                                * Routing mode: AND
                                * Initial rate: 1.5
                                * Next rate: 1.5
=============================== =====================================


5. Test the call
================

For the call testing it is necessary to fill :ref:`Routing Simulation <routing_simulation>` form and to press **Simulate routing** button.


   ==============================  =====================
           Field name                       Value
   ==============================  =====================
           Remote ip                   127.0.0.1
           Remote port                     10000
           Src number                    331234567890
            Dst number                   380487050321
   ==============================  =====================

As a result two records will be shown, where the first record is an actual record of Call Profile that will be send to the Yeti/SEMS node for making call. This Call Profile uses newly created :ref:`Destination <destinations>` as a basis for Customer's billing. Full log of call processing also will be shown under the resulting records.
