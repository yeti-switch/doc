
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
        Level of importance of this record of *Logic Log*.
    Source
        Type of item and process number (f.e. Dialpeer (3) - third process of the import of Dialpeers).
    MSG
        Status of the internal process (started, finished, success, Validation failed) and detailed message with additional information (if any).


