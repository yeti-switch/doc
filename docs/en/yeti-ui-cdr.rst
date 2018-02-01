===
CDR
===

YETI WEB interface - CDR menu description. This section describes CDR storage entities.


Tables
~~~~~~

****TODO****

**CDR Table**'s attributes:
```````````````````````````
    Id
       Unique CDR Table's id.
    Name
        ****TODO****
    Readable
        ****TODO****
    Writable
        ****TODO****
    Date Start
        ****TODO****
    Date Stop
        ****TODO****
    Active
        ****TODO****
    Comments
        ****TODO****

----

CDR History
~~~~~~~~~~~

Call Delivery Records (CDR) about all calls (or call attempts) what are passed via Yeti.

**CDR**'s attributes:
`````````````````````
    Id
       Unique CDR's id.
    Time Start
       Date and time of call starting.
    Customer
        Value of the :ref:`*Name* <contractor_name>` attribute of the Customer Contractor for the call.
    Vendor
        Value of the :ref:`*Name* <contractor_name>` attribute of the Vendor Contractor for the call.
    Customer Auth
        Value of the :ref:`*Name* <customer_auth_name>` attribute of the Customer Auth.
    Src Prefix Routing
        Prefix of the source number (A-number) that was used for routing for the call.
    Src Area
        Source :ref:`Area <areas>` for the call (if any).
    Dst Prefix Routing
        Prefix of the destination number (B-number) that was used for routing for the call
    Dst Area
        Destination :ref:`Area <areas>` for the call (if any).
    Dst Country
        :ref:`Country <countries>` that was associated (via :ref:`Network Prefixes <network_prefixes>` table) with the destination number (B-number) for the call.
    Status
        ****TODO****
    Duration
        Duration of the call in seconds. ****TODO**** - need to clarify
    Is Last CDR
        This field should be "1" for last routing attempt for the call ("0" otherwise). ****TODO****
    Dump Level
        ****TODO****
    Orig GW
        Value of the :ref:`*Name* <gateway_name>` attribute of Gateway that is used as Originator for the call.
    Term GW
        Value of the :ref:`*Name* <gateway_name>` attribute of Gateway that is used as Terminator for the call.
    Routing Plan
        :ref:`Routing plan <routing_plan>` that was used for the call.
    Routing Group
        :ref:`Routing Group <routing_group>` that was used for the call.
    Routing Tag
        :ref:`Routing Tag <routing_tag>` that was used for the call.
    Rateplan
        :ref:`Rateplan <rateplans>` that was used for the call.
    Internal Disconnect Code
        ****TODO****
    Lega Disconnect Code
        :ref:`Disconnect Code <disconnect_codes>` for interconnection between Yeti and Gateway that was used as Originator for the call.
    Lega Disconnect Reason
        ****TODO****
    Legb Disconnect Code
        ****TODO****
    Legb Disconnect Reason
        ****TODO****
    Src Prefix In
        Source number (A-number) that is received from Gateway that is used as Originator for the call.
    Dst Prefix In
        Destination number (B-number) that is received from Gateway that is used as Originator for the call.
    Src Prefix Out
        Source number (A-number) that is sent to Gateway that is used as Terminator for the call.
    Dst Prefix Out
        Destination number (B-number) that is sent to Gateway that is used as Terminator for the call.
    LRN
        Routing number that was received from LNP database (in case of requesting) for the call.
    Diversion In
        Value of SIP Diversion header that is received from Gateway that is used as Originator for the call.
    Diversion Out
        Value of SIP Diversion header that is sent to Gateway that is used as Terminator for the call.
    Src Name In
        Name of caller that is received in the "From" field of SIP header from Gateway that is used as Originator for the call.
    Src Name Out
        Name of caller that is sent in the "From" field of SIP header to Gateway that is used as Terminator for the call.
    Node
        ****TODO****
    PoP
        ****TODO****
    Local Tag
        ****TODO****
    Orig Call
        ****TODO****
    Term Call
        ****TODO****
    Routing Attempt
        Number of attempt to route this call to destination.
    Customer Price
        ****TODO****
    Vendor Price
        ****TODO****
    Vendor Invoice
        ****TODO****
    Customer Invoice
        ****TODO****
    Routing Delay
        ****TODO****
    PDD
        ****TODO****
    RTT
        ****TODO****

----

CDR Archive
~~~~~~~~~~~

****TODO****

**CDR**'s attributes:
`````````````````````
    Id
       Unique CDR's id.
    Time Start
        ****TODO****
    Customer
        ****TODO****
    Vendor
        ****TODO****
    Customer Auth
        ****TODO****
    Src Prefix Routing
        ****TODO****
    Dst Prefix Routing
        ****TODO****
    Dst Country
        ****TODO****
    Status
        ****TODO****
    Duration
        ****TODO****
    Is Last CDR
        ****TODO****
    Orig GW
        ****TODO****
    Term GW
        ****TODO****
    Routing Plan
        ****TODO****
    Routing Group
        ****TODO****
    Rateplan
        ****TODO****
    Internal Disconnect Code
        ****TODO****
    Internal Disconnect Reason
        ****TODO****
    Lega Disconnect Code
        ****TODO****
    Lega Disconnect Reason
        ****TODO****
    Legb Disconnect Code
        ****TODO****
    Legb Disconnect Reason
        ****TODO****
    Src Prefix In
        ****TODO****
    Dst Prefix In
        ****TODO****
    Src Prefix Out
        ****TODO****
    Dst Prefix Out
        ****TODO****
    LRN
        ****TODO****
    Diversion In
        ****TODO****
    Diversion Out
        ****TODO****
    Src Name In
        ****TODO****
    Src Name Out
        ****TODO****
    Node
        ****TODO****
    PoP
        ****TODO****
    Local Tag
        ****TODO****
    Orig Call
        ****TODO****
    Term Call
        ****TODO****
    Routing Attempt
        ****TODO****
    Customer Price
        ****TODO****
    Vendor Price
        ****TODO****
    Vendor Invoice
        ****TODO****
    Customer Invoice
        ****TODO****
    Routing Delay
        ****TODO****
    PDD
        ****TODO****
    RTT
        ****TODO****
