
.. _lnp_caches:

LNP Caches
~~~~~~~~~~

LNP Caches are used for storing information about requests to the Local number portability Databases that were made by Yeti. Period of storing of *LNP Cache* in the system is regulated by :ref:`LNP Cache TTL <system_global_configuration_lnp_cache_ttl>` parameter from :ref:`Global configuration <global_configuration>`.

**LNP Cache**'s attributes:
```````````````````````````
    Id
       Unique LNP Cache's id.
    DST
        Destination number that was used in the LNP request.
    LRN
        Destination number that was received from :ref:`LNP Database <lnp_databases>`.
    TAG
        Additional information that was received from :ref:`LNP Database <lnp_databases>`.
    DATA
        Information that was received from :ref:`LNP Database <lnp_databases>` in raw format.
    DATABASE
        :ref:`LNP Database <lnp_databases>` that was used for request Local number portability information.


