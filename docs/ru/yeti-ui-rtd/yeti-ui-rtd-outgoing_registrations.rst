
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

