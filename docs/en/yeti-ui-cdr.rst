===
CDR
===

YETI WEB interface - CDR menu description. This section describes CDR storage entities.


Tables
~~~~~~

Tables are used for review general information about Call Delivery Records (CDR) that are stored in the system.

**CDR Table**'s attributes:
```````````````````````````
    Id
       Unique CDR Table's id.
    Name
        Unique CDR Table's name.
    Active
        Yes - if CDRs of this *Table* are available in the :ref:`CDR History <cdr_history>`.
        No - if  CDRs of this *Table* are available in the :ref:`CDR Archive <cdr_archive>`.
    Date Start
        Date of *Table* creation (date of the first CDR record in the *Table*).
    Date Stop
        Date of *Table* closing (date of the last CDR record in the *Table*).
    Data Size
        Size of data that are represented in this *Table* without system information.
    Full Size
        Full size of data that are represented in this *Table* including system information.

----

.. _cdr_history:

CDR History
~~~~~~~~~~~

Storage of Call Delivery Records (CDR) for all calls (or call attempts) what are passed via Yeti (without archived records). CDRs are moved to :ref:`CDR Archive <cdr_archive>` after some period of time that is regulated by :ref:`CDR Archive Delay parameter <system_global_configuration_cdr_archive_delay>` from Global Configurations.

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
        Status of the call regarding its :ref:`Disconnect Code <disconnect_codes>`. Could be **SUCCESS** (if "Success" flag is enabled for :ref:`Disconnect Code <disconnect_codes>` that was applied to the call) or **FAILURE** (otherwise).
    Duration
        Duration of the call in seconds.
    Is Last CDR
        This field should be "yes" ("true") for last routing attempt for the call ("no"("false") otherwise).
    Dump Level
        Level of capturing of call to PCAP (Packet Capture) files that was chosen in the :ref:`Dump Level <customer_auth_dump_level>` attribute of :ref:`Customers Auth <customer_auth>` that is related to this call:

        **Capture nothing** - Information didn't capture to pcap-file for this call.

        **Capture signaling traffic** - Only signaling information had been captured to pcap-file for this call.

        **Capture rtp traffic** - Only RTP traffic had been captured to pcap-file for this call.

        **Capture all traffic** - Only signaling information & RTP traffic had been captured to pcap-file for this call.

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
        Internal :ref:`Disconnect Code <disconnect_codes>` for the call.
    Lega Disconnect Code
        :ref:`Disconnect Code <disconnect_codes>` for interconnection between Yeti and Gateway that was used as Originator for the call.
    Lega Disconnect Reason
        Disconnect Reason for interconnection between Yeti and Gateway that was used as Originator for the call.
    Legb Disconnect Code
        :ref:`Disconnect Code <disconnect_codes>` for interconnection between Yeti and Gateway that was used as Terminator for the call.
    Legb Disconnect Reason
        Disconnect Reason for interconnection between Yeti and Gateway that was used as Terminator for the call.
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
        :ref:`Node <nodes>` (independent installation of YETI-SEMS) that was used for the call.
    PoP
        :ref:`Point of Presence <pops>` that was received the call.
    Local Tag
        ****TODO**** (	6A96AC2A-59DCAF69000E66CE-FB0FC700)
    Orig Call
        ****TODO**** (ce1929d5ee766c7409aa4be0c3d758ac)
    Term Call
        ****TODO**** (480AE781-59DCAF6A00024EF7-3B2FB700)
    Routing Attempt
        Number of attempt to route this call to destination.
    Customer Price
        Price that was used for changing balance of Customer's :ref:`Account <accounts>` (in case of success call).
    Vendor Price
        Price that was used for changing balance of Vendors's :ref:`Account <accounts>` (in case of success call).
    Vendor Invoice
        :ref:`Invoice <invoices>` with billing information about changing balance of Vendors's :ref:`Account <accounts>` (in case of success call).
    Customer Invoice
        :ref:`Invoice <invoices>` with billing information about changing balance of Customer's :ref:`Account <accounts>` (in case of success call).
    Routing Delay
        Delay (in miliseconds) between receiving call by Yeti (from Originator) and starting of its termination (to Terminator).
    PDD
        Post Dial Delay (PDD) for this call ( time between the start of the call and the moment the phone of the called party starts ringing) in seconds.
    RTT
        Round-trip time (RTT) for this call.

----

.. _cdr_archive:

CDR Archive
~~~~~~~~~~~

Storage of archived Call Delivery Records (CDR) for all calls (or call attempts) what are passed via Yeti (without archived records). CDRs are moved to :ref:`CDR Archive <cdr_archive>` after some period of time that is regulated by :ref:`CDR Archive Delay parameter <system_global_configuration_cdr_archive_delay>` from Global Configurations.

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
    Dst Prefix Routing
        Prefix of the destination number (B-number) that was used for routing for the call
    Dst Country
        :ref:`Country <countries>` that was associated (via :ref:`Network Prefixes <network_prefixes>` table) with the destination number (B-number) for the call.
    Status
        Status of the call regarding its :ref:`Disconnect Code <disconnect_codes>`. Could be **SUCCESS** (if "Success" flag is enabled for :ref:`Disconnect Code <disconnect_codes>` that was applied to the call) or **FAILURE** (otherwise).
    Duration
        Duration of the call in seconds.
    Is Last CDR
        This field should be "yes" ("true") for last routing attempt for the call ("no"("false") otherwise).
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
        Internal :ref:`Disconnect Code <disconnect_codes>` for the call.
    Internal Disconnect Reason
        Internal Disconnect Reason for the call.
    Lega Disconnect Code
        :ref:`Disconnect Code <disconnect_codes>` for interconnection between Yeti and Gateway that was used as Originator for the call.
    Lega Disconnect Reason
        Disconnect Reason for interconnection between Yeti and Gateway that was used as Originator for the call.
    Legb Disconnect Code
        :ref:`Disconnect Code <disconnect_codes>` for interconnection between Yeti and Gateway that was used as Terminator for the call.
    Legb Disconnect Reason
        Disconnect Reason for interconnection between Yeti and Gateway that was used as Terminator for the call.
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
        :ref:`Node <nodes>` (independent installation of YETI-SEMS) that was used for the call.
    PoP
        :ref:`Point of Presence <pops>` that was received the call.
    Local Tag
        ****TODO**** (	6A96AC2A-59DCAF69000E66CE-FB0FC700)
    Orig Call
        ****TODO**** (ce1929d5ee766c7409aa4be0c3d758ac)
    Term Call
        ****TODO**** (480AE781-59DCAF6A00024EF7-3B2FB700)
    Routing Attempt
        Number of attempt to route this call to destination.
    Customer Price
        Price that was used for changing balance of Customer's :ref:`Account <accounts>` (in case of success call).
    Vendor Price
        Price that was used for changing balance of Vendors's :ref:`Account <accounts>` (in case of success call).
    Vendor Invoice
        :ref:`Invoice <invoices>` with billing information about changing balance of Vendors's :ref:`Account <accounts>` (in case of success call).
    Customer Invoice
        :ref:`Invoice <invoices>` with billing information about changing balance of Customer's :ref:`Account <accounts>` (in case of success call).
    Routing Delay
        Delay (in miliseconds) between receiving call by Yeti (from Originator) and starting of its termination (to Terminator).
    PDD
        Post Dial Delay (PDD) for this call ( time between the start of the call and the moment the phone of the called party starts ringing) in seconds.
    RTT
        Round-trip time (RTT) for this call.
