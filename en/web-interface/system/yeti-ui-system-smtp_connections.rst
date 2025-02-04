
.. _smtp_connections:

SMTP connections
~~~~~~~~~~~~~~~~

It is necessary to have an SMTP connection in order to YETI can send invoices and alerts to customers. Then user can choose SMTP connection for Customer.

**SMTP connection**'s attributes:
`````````````````````````````````
    Id
       SMTP connection's id.
    Name
        Unique name of SMTP connection.
        Uses for informational purposes and doesn't affect system behavior.
    Host
        IP address or hostname of SMTP server.
    Port
        TCP port on which SMTP server wait for requests (*default value: 25*).
    From address
        E-mail address of sender.
    Auth user
        Username for Authorization procedure on external SMTP server.
    Auth password
        Password for Authorization procedure on external SMTP server.

.. _global_smtp_connection:

    Global
        Set as global for all customers.


