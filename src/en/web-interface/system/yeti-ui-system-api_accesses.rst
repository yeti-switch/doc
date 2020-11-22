.. _api_access:

API Accesses
~~~~~~~~~~~~

This configuration section allow administrator define credentials and grant access to specific Contractor/Account information to Customer via :ref:`Customer API <customer_api>`

**API Access**'s attributes:
````````````````````````````
    Id
       API Access's id.
    Login
        Unique login of user that is used for authentication of access via Application Programming Interface (API).
    Password
        Password of user that is used for authentication of access via Application Programming Interface (API).
    Customer
        :ref:`Customer <contractors>` that is associated with this *API Access* record.
    Accounts
        :ref:`Accounts <accounts>` that are associated with this *API Access* record.
    Allowed IPs
        Array of IP addresses that is divided by comma. It is possible to use hosts or networks addresses here.

During authentication(see **auth** controller) Customer API will check Login, Password and Allowed IPs and generate JWT token that can be used to fetch information related to specified Contractor/Account.

