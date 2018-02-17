====
Logs
====

YETI WEB interface - Logs menu description. This section describes logs and notifications entities.


API Log
~~~~~~~

API Log contains records about all requests via Application Programming Interface (API) to the System from external clients or from internal cron procedures. It is possible to use filters to select necessary records.

**Log Record**'s properties:
````````````````````````````
    Created At
        Date and time of request.
    Status
        Status of operation (HTTP-response code).
    Method
        HTTP-request (PUT, GET, POST, DELETE) method that was used for this API-request.
    Path
        Relative path to requested procedure.
    DB Duration
        Duration (im milliseconds) of processing request by Database.
    Page Duration
        Total response time (im milliseconds).
    Controller
        Controller that is contained procedure that was requested.
    Action
        Name of requested procedure.
    Params
        Parameters that were sent with request.
    Request Body
        Body of request in raw format. This field will be recorded only in case (ApiLogConfigs) for this controller  ****TODO****
    Response Body
        Body of response in raw format. ****TODO****
    Request Headers
        Headers of request in raw format. ****TODO****
    Response Headers
        Headers of response in raw format. ****TODO****


----

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

----

Logic Log
~~~~~~~~~

Logic Log contains records about internal processes. It is useful for monitoring status of long-time operations (like import of records to the Yeti's database from external sources). It is possible to use filters to select necessary records.

**Log Record**'s properties:
````````````````````````````
    Id
       Unique Record's id.
    Time Stamp
        Date and time of operation.
    TXID
        Unique identifier of transaction.
    Level
        ****TODO**** Level of importance.
    Source
        Type of item and process number (f.e. Dialpeer (3) - third process of the import of Dialpeers).
    MSG
        Status of the internal process (started, finished, success, Validation failed) and detailed message with additional information (if any).

----

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
        ****TODO**** Если какая-то сущность шлёт несколько мейлов сразу, то они будут в одном батче (числовое значение)

----

Events
~~~~~~

Events contains records about ... ****TODO**** (order of events on SEMS). It is possible to use filters to select necessary records.
Если поменяли что-то критичное для работы sems то тут создаётся строка, которая находится до тех пор, пока фоновый процесс не пошлёт евент семсу. С целью обновить изменения. Кодек - группа. В нормальном режиме эта табличка пустая.

**Event**'s properties:
```````````````````````
    Id
       Unique Event's id.
    Node
        :ref:`Node <nodes>` that is related to this *Event*.
    Retries
        ****TODO**** - количество попыток
    Command
        ****TODO**** - команда которую послали

Balance notifications
~~~~~~~~~~~~~~~~~~~~~
****TODO**** - если трэш-холд нотификейшн в акаунте (порог оповещения). Если случилось, то в этот лог записывается нотификейшн

**Balance notification**'s properties:
``````````````````````````````````````
    Id
       Unique Balance notification's id.
    Created At
       Date and time of this record creation.
    Direction
        ****TODO**** - превышен или принижен
    Action
        ****TODO**** - fire - случился, восстановился - другой (сделать пеймент, попробовать)
    Is Processed
        "Yes" - if this *Balance notification* was processed, "No" - otherwise.
    Processed At
       Date and time whet this *Balance notification* was processed.
    Data
        ****TODO**** - данные аккаунта к которому относится нотификейшн