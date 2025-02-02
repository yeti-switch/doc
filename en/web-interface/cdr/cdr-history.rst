
.. _cdr_history:

.. |br| raw:: html

   <br />

CDR History
~~~~~~~~~~~

Storage of Call Detail Records (CDR) for all calls (or call attempts) what are passed via Yeti. Yeti save CDR for every call termination attempt, so one received call on legA can cause multiple CDRs in case of rerouting. All CDRs related to one call will have same values of **Orig Call Id** and **Local tag**, **routing attempt** value indicates sequence number of CDR withing same call.

.. seealso:: There is built-in tool to provide CDR data retention, see :ref:`Data retention <data_retention>` documentation.

CDR  attributes
```````````````

Id
    Unique CDR identifier.

UUID
    Unique CDR identifier.

Time Start
    Date and time of call starting.
Time Connect
    Date and time of receiving 200OK response.
Time End
    Date and time of receiving Bye.
Duration
    Duration of the call in seconds.

Internal Disconnect Code
    Internal :ref:`Disconnect Code <disconnect_codes>` for the call.
Lega Disconnect Code
    :ref:`Disconnect Code <disconnect_codes>` for interconnection between Yeti and Gateway that was used as Originator for the call.
Lega Disconnect Reason
    Disconnect Reason for interconnection between Yeti and Gateway that was used as Originator for the call.

LegA Q850 Cause
    Q.850 cause code received on call legA in **Reason** header.

LegA Q850 Text
    Q.850 text received on call legA in **Reason** header.

LegA Q850 Params
    Q.850 parameters received on call legA in **Reason** header.

Legb Disconnect Code
    :ref:`Disconnect Code <disconnect_codes>` for interconnection between Yeti and Gateway that was used as Terminator for the call.
Legb Disconnect Reason
    Disconnect Reason for interconnection between Yeti and Gateway that was used as Terminator for the call.

LegB Q850 Cause
    Q.850 cause code received on call legB in **Reason** header.

LegB Q850 Text
    Q.850 text received on call legB in **Reason** header.

LegB Q850 Params
    Q.850 parameters received on call legB in **Reason** header.


Customer
    Value of the :ref:`*Name* <contractor_name>` attribute of the Customer Contractor for the call.
Vendor
    Value of the :ref:`*Name* <contractor_name>` attribute of the Vendor Contractor for the call.
Customer Auth
    Value of the :ref:`*Name* <customer_auth_name>` attribute of the Customer Auth.


Src Area
    Source :ref:`Area <areas>` for the call (if any).
Dst Area
    Destination :ref:`Area <areas>` for the call (if any).

Dst Country
    Destination Country name detected by :ref:`Network Prefixes <network_prefixes>` table
Dst Network
    Destination Network name detected by :ref:`Network Prefixes <network_prefixes>` table
Dst Network Type
    Destination Network Type name detected by :ref:`Network Prefixes <network_prefixes>` table

Src Country
    Source Country name detected by :ref:`Network Prefixes <network_prefixes>` table
Src Network
    Source Network name detected by :ref:`Network Prefixes <network_prefixes>` table
Src Network Type
    Source Network Type name detected by :ref:`Network Prefixes <network_prefixes>` table

Status
    Status of the call regarding its :ref:`Disconnect Code <disconnect_codes>`. Could be **SUCCESS** (if "Success" flag is enabled for :ref:`Disconnect Code <disconnect_codes>` that was applied to the call) or **FAILURE** (otherwise).

Is Last CDR
    This field should be "yes" ("true") for last routing attempt for the call ("no"("false") otherwise).

Dump Level
    Level of capturing of call to PCAP (Packet Capture) files that was chosen in the :ref:`Dump Level <customer_auth_dump_level>` attribute of :ref:`Customers Auth <customer_auth>` that is related to this call: |br|
    **Capture nothing** - Information didn't capture to pcap-file for this call. |br|
    **Capture signaling traffic** - Only signaling information had been captured to pcap-file for this call. |br|
    **Capture rtp traffic** - Only RTP traffic had been captured to pcap-file for this call. |br|
    **Capture all traffic** - Only signaling information & RTP traffic had been captured to pcap-file for this call. |br|

Orig GW
    Value of the :ref:`*Name* <gateway_name>` attribute of Gateway that was used as Originator for the call.
Term GW
    Value of the :ref:`*Name* <gateway_name>` attribute of Gateway that was used as Terminator for the call.
Routing Plan
    :ref:`Routing plan <routing_plan>` that was used for the call.
Routing Group
    :ref:`Routing Group <routing_group>` that was used for the call.
Routing Tags
    :ref:`Routing Tags <routing_tag>` associased with the call.
Rateplan
    :ref:`Rateplan <rateplans>` that was used for the call.

Src Name In
    Name of caller that was received in the "From" field of SIP header from :ref:`Gateway <gateways>` that was used as Originator for the call.
Src Prefix In
    Source number (A-number) that was received from Gateway that was used as Originator for the call.
Dst Prefix In
    Destination number (B-number) that was received from Gateway that was used as Originator for the call.

Src Prefix Routing
    Source number (A-number) that was used for routing for the call.
Dst Prefix Routing
    Destination number (B-number) that was used for routing for the call.
LRN
    Routing number that was received from LNP database (in case of requesting) for the call.

Src Prefix Out
    Source number (A-number) that was sent to Gateway that was used as Terminator for the call.
Dst Prefix Out
    Destination number (B-number) that was sent to Gateway that was used as Terminator for the call.
Src Name Out
    Name of caller that was sent in the "From" field of SIP header to Gateway that was used as Terminator for the call.



LegA Remote socket
    Protocol, Source IP address and Source Port of initial INVITE request received on Yeti node.

LegA Local socket
    Destination IP address and Destination Port of initial INVITE request received on Yeti node.

LegA Originator address
    Protocol, Source IP address and Source Port of initial INVITE request received from call originator(legA) on Load balancer or Yeti node.


LegB Remote socket
    Protocol, Destination IP address and Destinaion Port of initial INVITE request sent by Yeti on legB. This field may be empty if no responce received for initial INVITE.

LegB Local socket
    Source IP address and Source Port of initial INVITE request sent by Yeti on legB. This field may be empty if no responce received for initial INVITE.

LegB Ruri
    R-URI of initial INVITE request sent by Yeti on legB.

Is Redirected
    Will be true if call leg B was redirected using 3xx SIP response or REFER request.

Pai In
    Value of **P-Asserted-Identity** header received from origination gateway in initial INVITE on legA.

Pai Out
    Value of **P-Asserted-Identity** header sent by Yeti to termination gateway in initial INVITE on legB.

Ppi In
    Value of **P-Preferred-Identity** header received from origination gateway in initial INVITE on legA.

Ppi Out
    Value of **P-Preferred-Identity** header sent by Yeti to termination gateway in initial INVITE on legB.

Rpid In
    Value of **Remote-Party-ID** header received from origination gateway in initial INVITE on legA.

Rpid Out
    Value of **Remote-Party-ID** header sent by Yeti to termination gateway in initial INVITE on legB.

Rpid Privacy In
    Value of **RPID-Privacy** header received from origination gateway in initial INVITE on legA.

Rpid Privacy Out
    Value of **RPID-Privacy** header sent by Yeti to termination gateway in initial INVITE on legB.

Privacy In
    Value of **Privacy** header received from origination gateway in initial INVITE legA.

Privacy Out
    Value of **Pricacy** header sent by Yeti to termination gateway in initial INVITE on legB.

Diversion In
    Value of SIP Diversion header that was received from Gateway that was used as Originator for the call.
Diversion Out
    Value of SIP Diversion header that was sent to Gateway that is used as Terminator for the call.

P Charge Info In
    Value of **P-Charge-Info** header received from origination gateway in initial INVITE on legA. Yeti doesn't validate P-Charge-Info header format and accept any value even not in URI format.

Node
    Node that processed call
PoP
    Location of node processed call

Local Tag
    Internal session ID for call legA
LebB Local Tag
    Internal session ID for call legB
Orig Call
    Value on **Call-Id** header received from origination gateway.
Term Call
    Value on **Call-Id** header sent to termination gateway.

Routing Attempt
        Number of attempt to route this call to destination.
Customer Price
        Price that was used for changing balance of Customer's :ref:`Account <accounts>` (in case of success call).
Vendor Price
        Price that was used for changing balance of Vendors's :ref:`Account <accounts>` (in case of success call).

Routing Delay
    Delay (in seconds) between receiving call by Yeti (from Originator) and sending it to termination gateway.
PDD
    Post Dial Delay (PDD) for this call ( time between the start of the call and the moment the phone of the called party starts ringing) in seconds.
RTT
    Round-trip time (RTT) for this call.

Yeti version
    Versions of SEMS core and Yeti module that handled call

Lega User Agent
    Values of **User-Agent** and **Server** headers received from origination gateway on legA.

Legb User Agent
    Values of **User-Agent** and **Server** headers received from termination gateway on legB.



