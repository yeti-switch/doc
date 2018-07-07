
Email Log
~~~~~~~~~

Email Log contains records about emails that were or weren't (via some reason) sent from the system. It is possible to use filters to select necessary records.

**Email Log Record**'s properties:
``````````````````````````````````
    Id
       Unique Record's id.
    Created At
        Date and time of this record creation.
    Sent At
        Date and time of this record creation.
    Contact
        :ref:`Contact <contacts>` that was used for sending email.
    SMTP Connection
        :ref:`SMTP Connection <smtp_connections>` that was used for sending email.
    Mail From
        Email address that was used as "From-address" for sending email.
    Mail To
        Email address that was used as "To-address" for sending email.
    Subject
        Subject that was used for sending email.
    Attachments
        Attachments that were attached to email.
    Error
        Text of error (if any).
    Batch
        Digital value that represents belonging to the common batch of emails that were sent.

