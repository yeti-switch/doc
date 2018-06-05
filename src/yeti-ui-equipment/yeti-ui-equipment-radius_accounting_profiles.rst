
.. _radius_accounting_profile:

RADIUS Accounting Profiles
~~~~~~~~~~~~~~~~~~~~~~~~~~

Yeti supports additional accounting of calls on external RADIUS server. RADIUS Accounting Profile describes communication with that server.

**RADIUS Accounting Profile**'s attributes:
```````````````````````````````````````````
    Id
       Unique RADIUS Accounting Profile's id.
    Name
        Unique name of Accounting profile.
        Uses for informational purposes and doesn't affect system behaviour.
    Server
        IP address or hostname of external RADIUS server.
    Port
        UDP port on which RADIUS server wait for requests.
    Secret
        Password for Authorization procedure on external RADIUS server.
    Timeout
        Timeout of request after which a request will be repeated (millisecond).
    Attempts
        Maximum amount of of requests for every call.
    Enable start accounting
        If enabled, YETI will send Start-accounting packets to external RADIUS server.
    Enable interim accounting
        If enabled, YETI will send Interim-accounting packets to external RADIUS server.
    Interim accounting interval
        Send Interim packets to external RADIUS server every **interval** seconds.
    Enable stop accounting
        If enabled, YETI will send Stop-accounting packets to external RADIUS server.
    Start packet attributes
        RADIUS Attributes for including specific authentication, authorization, information and configuration details into **Start-accounting packets**. Description of fields, principles of their filling and description of placeholders that can be used as variables in the *value* filed are described in the :ref:`Auth profile attributes <auth_profile_attributes>` section.
    Interim packet attributes
        RADIUS Attributes for including specific authentication, authorization, information and configuration details into **Interim packet attributes**. Description of fields, principles of their filling and description of placeholders that can be used as variables in the *value* filed are described in the :ref:`Auth profile attributes <auth_profile_attributes>` section.
    Stop packet attributes
        RADIUS Attributes for including specific authentication, authorization, information and configuration details into **Stop packet attributes**. Description of fields, principles of their filling and description of placeholders that can be used as variables in the *value* filed are described in the :ref:`Auth profile attributes <auth_profile_attributes>` section.


