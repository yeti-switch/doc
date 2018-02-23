
Audit Log
~~~~~~~~~

Audit Log contains records about all changes of objects within Yeti's database that were initiated by user (via web-interface or via console) or by system. It is possible to use filters to select necessary records.

**Log Record**'s properties:
````````````````````````````
    Item type
        Type of item (Contractor, Account, Gateway, Rateplan etc.) that was changed.
    Item ID EQ
        Unique identifier of item.
    Event
        Type of event that was occurred (create, update, destroy).
    Created At
        Date and time of this record creation.
    TXID
        Unique identifier of transaction. Actions with same TXID are related to common transaction (operation).
    Who
        Username for the records that are related to some :ref:`Admin Users <admin_users>`. You can use "WHODUNNIT" for filtering by ID from :ref:`Admin Users <admin_users>` table.
    IP
        IP-address of user that was initiate operation that is related to this Audit Log record.


