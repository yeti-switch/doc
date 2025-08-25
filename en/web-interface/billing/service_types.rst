.. _service_type:

=============
Service Types
=============

A **Service Type** object is a template for a service. It defines how a service behaves during its life-cycle.

Id
    Unique identifier of the Service Type.

Name
    Human-readable name of the Service Type.

Force Renew
    When enabled, this flag forces service renewal even if the customer’s account
    balance is insufficient (``balance <= min_balance``).
    In this case, the service is renewed and the corresponding price is still charged.

.. spelling:word-list::
    FreeMinutes
    PhoneSystems

Provisioning Class
    Specifies system behavior during the service life-cycle (Creation, Renewal, Deletion).

    Billing::Provisioning::Logging
        This provisioning class requires no configuration variables and performs no actions.
        It can be used for services that only need to charge the account periodically.

    Billing::Provisioning::FreeMinutes
        Provisioning class that provides packages of free minutes.

    Billing::Provisioning::PhoneSystems
        Provisioner for account creation on the DIDWW Phone.Systems cloud PBX platform.
        It creates an Account, Incoming and Outgoing trunks on the Phone.Systems side
        (via the `Operator API <https://doc.telecom.center/introduction.html>`_), and a gateway on the Yeti side to exchange calls with the Phone Systems Account.

UI Type
    Optional setting that controls how the service is displayed in the :ref:`Customer Portal <yeti_client>`.

Variables
    Optional provisioning class configuration in JSON format.
