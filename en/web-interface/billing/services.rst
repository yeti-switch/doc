
.. _service:

========
Services
========

Service object represents additional paid service not related to per-second call billing. Service may charge customer account one time or multiple times during **renew** procedure

Id
    Unique payment id.

UUID
    Unique payment id.

Name
    Name of service.

Account
    Account related to payment.

Type
    Service Type.

Variables
    Service variables. Data format depends on configured Service Type.

State
    Current state of service.

Initial price
    Price that will bill be charged immediately after service creation.

Renew price
    Price of renew.

Created At
    Timestamp of service creation.

Renew At
    Timestamp when service will be renewed.

Renew Period
    Daily or Monthly.


Creation of service with non-zero **Initial price** value will cause creation of :ref:`Transaction <transaction>` object and it will cause Account balance modification.

Renew procedure
===============

Renew time controlled by **Renew At** value. Initially this value defined during service creation. During renew next **Renew At** will be set according to **Renew Period** configuration.



.. mermaid::

    flowchart TD

        A[Waiting renew_at time reached] --> B{service.type.force_renew?}
        B -->|Yes. Renew process| R[<p style='text-align:left'>create transaction<br>set service.state=Active<br>set service.renew_at</p>]
        B -->|No. Checking balance| C{Enough balance?}

        C -->|No. Suspend service| S[<p style='text-align:left'>set service.state=Suspended</p>]
        S --> A
        C -->|Yes. Renew process| R

        R -->A


