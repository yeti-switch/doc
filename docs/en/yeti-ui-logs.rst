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
        Status of operation (code of error). ****TODO****
    Method
        HTTP-request (PUT, GET, POST) method that was used for this API-request. ****TODO****
    Path
        Relative path to requested procedure.
    DB Duration
        Duration (im milliseconds) of processing request by Database. ****TODO****
    Page Duration
        Duration (im milliseconds) of loading page with answer on API-request. ****TODO****
    Controller
        Controller that is contained procedure that was requested. ****TODO****
    Action
        Name of requested procedure. ****TODO****
    Params
        Parameters that were sent with request. ****TODO****
    Request Body
        Body of request in raw format. ****TODO****
    Response Body
        Body of response in raw format. ****TODO****
    Request Headers
        Headers of request in raw format. ****TODO****
    Response Headers
        Headers of response in raw format. ****TODO****


----

Audit Log
~~~~~~~~~

****TODO**** - log of changes. any changing of the object (by web-interface, by console or by system) will create record in this log

**Log Record**'s attributes:
````````````````````````````
    Item type
        ****TODO****
    Item ID EQ
        ****TODO****
    Event
        ****TODO****
    WHODUNNIT
        ****TODO****
    Created At
        ****TODO****
    IP
        ****TODO****
    TXID
        ****TODO**** - ID of transactions. Actions with same TXID were from one transaction

----

Logic Log
~~~~~~~~~

****TODO**** - log of internal processes (for example long-time import). It is impossible to implement monitoring from web-interface, so you can see status of operations via this log

**Log Record**'s attributes:
````````````````````````````
    Id
       Unique Record's id.
    Time Stamp
        ****TODO****
    TXID
        ****TODO****
    Level
        ****TODO****
    Source
        ****TODO**** 	Dialpeer (3) - third process of Dialpeers import
    MSG
        ****TODO****

----

Email Log
~~~~~~~~~

****TODO**** - email that were or weren't sent by some reason

**Email Log Record**'s attributes:
``````````````````````````````````
    Id
       Unique Record's id.
    Batch
        ****TODO****
    Contact
        ****TODO****
    SMTP Connection
        ****TODO****
    Mail To
        ****TODO****

----

Events
~~~~~~

****TODO**** - order of events. used by SEMS for loading something from the DB (need to clarify) )

**Event**'s attributes:
```````````````````````
    Id
       Unique Event's id.
    Node
        ****TODO****
    Retries
        ****TODO****
    Command
        ****TODO****
