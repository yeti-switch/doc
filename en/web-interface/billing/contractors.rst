
.. _contractors:

Contractors
~~~~~~~~~~~

Contractor is a company which will interact with the system.

Contractor may act as **Customer** - Use provided call termination service and **Vendor** - Provide call termination service. Same contractor can be either customer and vendor.


.. _contractor_id:

Id
    Unique contractor id.

.. _contractor_name:

Name
    Unique contractor name.
Enabled
    Self-descriptive.
    If flag is off (contractor disabled) this contractor will not be used for routing and billing.

.. _contractor_vendor:

Vendor
    If enabled contractor can act as vendor and system may terminate calls to it.

.. _contractor_customer:

Customer
    If enabled contractor can act as customer and originate calls to the system.
Description
    Optional description of the contractor.
Address
    Optional contractor address.
Phones
    List of phone numbers to contact with contractor.

Smtp Connection
    :ref:`SMTP Connection <smtp_connections>` which will be used for email sending to this contractor. If empty - :ref:`Global SMTP connection <global_smtp_connection>` will be used

.. note:: Fields **Description**, **Address**, **Phones** are informational and not used in routing or billing logic.


