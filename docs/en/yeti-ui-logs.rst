====
Logs
====

YETI WEB interface - Logs menu description. This section describes logs and notifications entities.


API Log
~~~~~~~ - log of request to the System by external clients or by internal cron procedures

****TODO****

**Log Record**'s attributes:
````````````````````````````
    Created At
        ****TODO****
    Path
        ****TODO****
    Method
        ****TODO****
    Status
        ****TODO****
    Controller
        ****TODO****
    Action
        ****TODO****
    Page Duration
        ****TODO****
    DB Duration
        ****TODO****
    Params
        ****TODO****
    Request Body
        ****TODO****
    Response Body
        ****TODO****
    Request Headers
        ****TODO****
    Response Headers
        ****TODO****

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
