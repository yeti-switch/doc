
.. _lnp_databases:

LNP databases
~~~~~~~~~~~~~
see https://en.wikipedia.org/wiki/Local_number_portability

Yeti supports interaction with LNP databases by SIP and HTTP REST protocols.
We welcome requests to implement additional protocols or LNP database specific formats.

**LNP database**'s attributes:
``````````````````````````````

    .. _lnp_database_id:

    Id
        Unique LNP database's id.
    Name
        Database name. Unique field.
    Driver
        Driver which will be used. Available options:
            UDP SIP 301/302 redirect
            thinQ RESR LRN driver
            In-memory hash
    Host
        Database host (will be ignored by In-memory hash driver).
    Port
        Database port.
    Timeout
        Maximum time to wait for response from database.
        Request will fail with appropriate code and reason.
    Thinq username
        Authorization username for thinQ API.
    Thinq token
        Authorization token for thinQ API.
    Csv file
        Path to the file with data to preload (for In-memory hash driver only).


