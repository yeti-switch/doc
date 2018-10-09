
.. _cdr_auth_logs:

Auth Logs
~~~~~~~~~

Auth Logs are used for review authorization attempts that were fixed by Yeti.

**Auth Logs**'s attributes:
```````````````````````````
    Id
       Unique Auth Logs's id.
    Request Time
        Time when authorization attempt was made.
    Gateway
        :ref:`Gateway <gateways>` that was associated with authorization attempt.
    Success
        Status of success (Yes) or failure (No) of this *Auth Log* record.
    Code
        Numeric code with status of authorization attempt.
    Reason
        Textual status of authorization attempt that was sent to the remote host.
    Internal Reason
        Internal Reason of the result of authorization attempt (for example success - "Response matched" or failure - "User mismatch").
    Originator
        **TODO**
    Remote Socket
        **TODO**
    Local Socket
        **TODO**
    PoP
        **TODO**
    Node
        **TODO**
    Username
        **TODO**
    Realm
        **TODO**
    Request Method
        **TODO**
    Ruri
        **TODO**
    From Uri
        **TODO**
    To Uri
        **TODO**
    Call
        **TODO**
    Nonce
        **TODO**
    Response
        **TODO**
    X Yeti Auth
        **TODO**
    Diversion
        Value of SIP Diversion header that is received from remote host during authorization attempt.
    Pai
        P-Asserted-Identity (PAI) privacy field of SIP header that was received from remote host during authorization attempt.
    Ppi
        P-Preferred-Identity (PPI) privacy field of SIP header that was received from remote host during authorization attempt.
    Privacy
        SIP Privacy field of SIP header that was received from remote host during authorization attempt.
    Rpid
        Remote Party ID field of SIP header that was received from remote host during authorization attempt.
    Rpid Privacy
        SIP RPID Privacy field of SIP header that was received from remote host during authorization attempt.


