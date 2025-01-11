
Disconnect policy codes
~~~~~~~~~~~~~~~~~~~~~~~

Code's overriding scenarios that are used by :ref:`Disconnect policies <disconnect_policy>`. More than one scenario can be used with one :ref:`Disconnect policy <disconnect_policy>`.

**Disconnect policy code**'s attributes:
````````````````````````````````````````
    Id
        Unique Disconnect policy code's id.
    Policy
        :ref:`Disconnect policy <disconnect_policy>` that is related to this Code.
    Code
        SIP Response Codes that are specified in the `RFC 3261 -  SIP: Session Initiation Protocol <https://tools.ietf.org/html/rfc3261#section-21>`_.
    Stop hunting
        If this checkbox is enabled re-routing won't be done in case of receiving this SIP Code.
    Pass reason to originator
        If this checkbox is enabled the Reason (text of Response Code) will be transferred to Originator without changing, even if Code was changed by scenario.

    :spelling:ignore:`Rewrited` code
        Response Code that will be transferred to Originator instead of original Code. If this field is empty - original Response Code will be transferred to Originator.
    :spelling:ignore:`Rewrited` reason
        Response Reason that will be transferred to Originator instead of original (default) Reason. If this field is empty - original (default) Response Reason will be transferred to Originator, even if Code was changed by scenario.

