
.. _service:

========
Services
========

A **Service** object represents an additional paid service that is not related to per-second call billing.
A service may charge the customer’s account once or multiple times during the **renew** procedure.

Id
    Unique identifier of the Service.

UUID
    Globally unique identifier (UUID) of the Service.

Name
    Name of the Service.

Account
    Account to which payments are applied.

Type
    :ref:`Service Type <service_type>` of the Service.

Variables
    Service-specific variables.
    The data format depends on the configured Service Type.

State
    Current state of the Service.

Initial price
    Price charged immediately after the Service is created.

Renew price
    Price charged during each renewal.

Created At
    Timestamp of when the Service was created.

Renew At
    Timestamp of the next renewal.

Renew Period
    Defines how the next **Renew At** date is calculated during the renewal process.
    Possible values:

    - **Daily** – Renew At is set to 00:00 of the next day.
    - **Monthly** – Renew At is set to 1st day of the next month, at 00:00.

Creating a Service with a non-zero **Initial price** will automatically create a
:ref:`Transaction <transaction>` object, which modifies the Account balance.

Renew procedure
===============

The renewal time is controlled by the **Renew At** value.
This value is set during Service creation.
During each renewal, the next **Renew At** timestamp is updated according to the **Renew Period** configuration.


.. mermaid::

    flowchart TD

        A[Waiting renew_at time reached] --> B{service.type.force_renew?}
        B -->|Yes. Renew process| R[<p style='text-align:left'>create transaction<br>set service.state=Active<br>set service.renew_at</p>]
        B -->|No. Checking balance| C{Enough balance?}

        C -->|No. Suspend service| S[<p style='text-align:left'>set service.state=Suspended</p>]
        S --> A
        C -->|Yes. Renew process| R

        R -->A


