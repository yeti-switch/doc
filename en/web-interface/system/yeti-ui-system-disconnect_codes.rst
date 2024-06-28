
.. _disconnect_codes:

Disconnect Codes
~~~~~~~~~~~~~~~~

Disconnect Codes are used for defining special actions for some SIP disconnect codes and for rewriting them (if necessary) during call routing for compatibility between different VoIP platforms.

**Disconnect Code**'s attributes:
`````````````````````````````````
    Id
       Disconnect Code's id.
    Namespace
       Namespace that is related to this *Disconnect Code*. Following Namespaces are available: TM (traffic manager), RADIUS, TS (traffic switch), SIP.
    Code
        Numeric SIP code for this *Disconnect Code*.
    Reason
        Textual Reason for this *Disconnect Code*.
    Success
        In case of enabling of this field this *Disconnect Code* will be recognized by Yeti as successful.
    Successnozerolen
        In case of enabling of this field this *Disconnect Code* will be recognized by Yeti as successful only for calls with no zero length.
    Stop hunting
        In case of enabling of this field Yeti will not re-route call after receiving this *Disconnect Code*.
    Pass reason to originator
        In case of enabling of this field Yeti will transfer reason from termination :ref:`Gateway <gateways>` to origination.
    Rewrited code
        If this field is not empty new numeric code from this field will be transfer to origination :ref:`Gateway <gateways>`.
    Rewrited reason
        If this field is not empty new textual reason from this field will be transfer to origination :ref:`Gateway <gateways>`.
    Store cdr
        In case of enabling of this field Yeti will store CDRs for calls that were terminated with this *Disconnect Code*.
    Silently drop
        In case of enabling of this field Yeti won't answer anything to legA (origination :ref:`Gateway <gateways>`) when Yeti's routing procedure returned this *Disconnect Code*. This field is used only with TM (traffic manager) namespace and can be used for preventing fake authorization attempts from the network bots.

