=============
Realtime Data
=============

YETI WEB interface - Realtime Data menu description. This section describes realtime data like active calls etc.


Active calls
~~~~~~~~~~~~

Active calls tool is used for monitoring of active calls in the System. Calls can be represented in the form of table (with providing full information) or in the form of graph together with list of calls (with providing short information).

****TODO****  - it is depends on ACTIVE CALLS REQUIRE FILTER parameter from global configuration. will it show result without filtering or require filtering before
****TODO**** ACTIVE CALLS SHOW CHART  - show graph or not
****TODO**** ACTIVE CALLS AUTOREFRESH ENABLE - authomatical update during demostration
****TODO**** y - calls count, x- time (step - 1 minute)

**Active call**'s attributes:
`````````````````````````````
    Node
        ****TODO**** - from the System Nodes
    Destination Country
        ****TODO****
    Destination Network
        ****TODO****
    Vendor
        ****TODO****
    Customer
        ****TODO****
    Vendor Account
        ****TODO****
    Customer Account
        ****TODO****
    Orig GW
        ****TODO****
    Term GW
        ****TODO****
    Duration
        ****TODO****

----

Nodes
~~~~~

****TODO**** - Node (SEMS) installation

**Node**'s attributes:
``````````````````````
    Name
        ****TODO****
    Active Calls Count
        ****TODO**** -
    Version
        ****TODO**** - version of sems
    Shutdown Req Time
        ****TODO**** - time for requesting shutdown (during this time new calls are rejected)
    Sessions Num
        ****TODO**** - number of sessions (1 for legA, and some amount for legsb, including rerouting)
    Uptime
        ****TODO****
    PoP
        ****TODO****

----

Outgoing Registrations
~~~~~~~~~~~~~~~~~~~~~~

****TODO**** - SIP registration. It helps to mask Yeti and simulate client procedure (registration). Registrations are presented in equipment registrations. This is only current state

**Outgoing Registration**'s attributes:
```````````````````````````````````````
    Node
        ****TODO****
