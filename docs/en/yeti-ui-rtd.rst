=============
Realtime Data
=============

YETI WEB interface - Realtime Data menu description. This section describes realtime data like active calls etc.

.. _active_calls:

Active calls
~~~~~~~~~~~~

Active calls tool is used for monitoring of active calls in the System. Calls can be represented in the form of table (with providing full information) or in the form of graph together with list of calls (with providing short information).
It is possible to request filtering before showing the information about active calls by setting :ref:`Active Calls Require Filter <system_global_configuration_active_calls_require_filter>` parameter in the :ref:`Global configuration <global_configuration>`.
It is also possible add (or remove) graph from the screen by changing :ref:`Active Calls Show Chart <system_global_configuration_active_calls_show_chart>` parameter in the :ref:`Global configuration <global_configuration>` and enable (or disable) automatic update mode by changing :ref:`Active Calls Autorefresh Enable  <system_global_configuration_active_calls_autorefresh_enable>` parameter in the :ref:`Global configuration <global_configuration>`.

**Active call**'s filtering parameters:
```````````````````````````````````````
    Node
        :ref:`Node <nodes>` (independent installation of YETI-SEMS) that will be used for filtering active calls. In case of specification - only calls from selected node will be shown. For monitoring calls from all :ref:`Nodes <nodes>`, please, choose "Any" in this field.
    Destination Country
        :ref:`Destination Country <countries>` that will be used for filtering active calls. In case of specification - only calls that are identified by destination number & international country code as calls that are related to the selected country will be shown. For monitoring calls to all :ref:`Destination Country <countries>`, please, choose "Any" in this field.
    Destination Network
        :ref:`Destination Network <networks>` that will be used for filtering active calls. In case of specification -  only calls that are identified by destination number & network prefix as calls that are related to the selected Network (Carrier) will be shown. For monitoring calls to all :ref:`Destination Networks <countries>`, please, choose "Any" in this field.
    Vendor
        :ref:`Vendor <contractors>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Vendor will be shown. For monitoring calls via all :ref:`Vendors <contractors>`, please, choose "Any" in this field.
    Customer
        :ref:`Customer <contractors>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Customer will be shown. For monitoring calls from all :ref:`Customers <contractors>`, please, choose "Any" in this field.
    Vendor Account
        :ref:`Vendor Account <accounts>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Account will be shown. For monitoring calls related to all :ref:`Accounts <accounts>`, please, choose "Any" in this field.
    Customer Account
        :ref:`Customer Account <accounts>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Account will be shown. For monitoring calls related to all :ref:`Accounts <accounts>`, please, choose "Any" in this field.
    Orig GW
        :ref:`Origination Gateway <gateways>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Gateway will be shown. For monitoring calls related to all :ref:`Gateways <gateways>`, please, choose "Any" in this field.
    Term GW
        :ref:`Termination Gateway <gateways>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Gateway will be shown. For monitoring calls related to all :ref:`Gateways <gateways>`, please, choose "Any" in this field.
    Duration
        Duration of calls in seconds. This field will be used for filtering active calls by duration. It is possible to use statement for this field (equals, greater than, less than). For monitoring calls independently from this parameter just leave it empty.

----

Nodes
~~~~~

RealTime information about current state of the :ref:`Nodes <nodes>` (independent installations of YETI-SEMS).

**Node**'s filtering parameters:
````````````````````````````````
    Name
        Node's name. It is possible to use statement for this field (contains, equals, starts with, ends with).
    POP
        :ref:`Point of Presence <pops>` (PoP) that will be used for filtering Nodes. In case of specification - only Nodes that are related to selected PoP will be shown. For monitoring Nodes from all :ref:`Points of Presence <pops>`, please, choose "Any" in this field.

**Node**'s properties:
``````````````````````
    Name
        Node's name.
    Active Calls Count
        Count of active calls that a currently going via :ref:`Node <nodes>`.
    Version
        Version of SEMS that is used on :ref:`Node <nodes>`.
    Shutdown Req Time
        Time for requesting shutdown of the :ref:`Node <nodes>`. This is time for planned shutdown (or restart) of software. During period before this Time new calls will be rejected by the :ref:`Node <nodes>`. If this field is empty :ref:`Node <nodes>` is working in normal mode.
    Sessions Num
        General amount of active sessions between Yeti and :ref:`Gateways <gateways>`.
    Uptime
        Time from last reboot for this :ref:`Node <nodes>`.

----

Outgoing Registrations
~~~~~~~~~~~~~~~~~~~~~~

Outgoing Registrations are used for monitoring of current status of :ref:`outgoing SIP registrations on remote vendor's or customer's equipment <registrations>`.

**Outgoing Registration**'s filtering parameters:
`````````````````````````````````````````````````
    Node
        :ref:`Node <nodes>` (independent installation of YETI-SEMS) that will be used for filtering Outgoing Registrations. In case of specification - only Outgoing Registrations from selected node will be shown. For monitoring Outgoing Registrations from all :ref:`Nodes <nodes>`, please, choose "Any" in this field.

**Outgoing Registration**'s properties:
```````````````````````````````````````
    User
        Username that is used for this *Outgoing Registration* (user part of RURI).
    Domain
        Domain that is used for this *Outgoing Registration* (domain part of RURI).
    State
        Current state of this *Outgoing Registration*. Following states are available: RegisterPending; RegisterActive;RegisterError; RegisterExpired; RegisterPostponed.
    Auth User
        Authorization username that is used for this *Outgoing Registration*.
    Display Name
        Display Name that is used for this *Outgoing Registration* (From display name part).
    Contact
        Contact header that is used for this *Outgoing Registration* (in SIP-URI format).
    Proxy
        Proxy that is used for this *Outgoing Registration* (if any).
    Expires
        Registration expiration time for this *Outgoing Registration*.
    Expires Left
        Time in seconds that is left before expiration for this *Outgoing Registration*.
    Node
        :ref:`Node <nodes>` (independent installation of YETI-SEMS) that is used for this *Outgoing Registration*.
    Last Error Code
        Code of last error that was received for this *Outgoing Registration*.
    Last Error Initiator
        Initiator of last error for this *Outgoing Registration* (remote or local).
    Last Error Reason
        Reason of last error that was received for this *Outgoing Registration*.
    Last Request Time
        Timestamp of last sending REGISTER request for this *Outgoing Registration*.
    Last Succ Req Time
        Timestamp of last sending sucess REGISTER request for this *Outgoing Registration*.
    Attempt
        Current amount of attempts for sending REGISTER request for this *Outgoing Registration*.
    Max Attempts
        Maximum amount of attempts for sending REGISTER request that is used for this *Outgoing Registration*.
    Retry Delay
        Delay before sending a new REGISTER request to a registrar, when received error code or timeout occurred.
