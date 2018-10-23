
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
        URI of the host that is initiated authorization attempt. Format of this fields includes information about used network protocol, IP-address and network port.
    Remote Socket
        URI of the remote host (for example URI of :ref:`Load Balancer <load_balancers>`) from that the authorization attempt was received. Format of this fields includes information about used network protocol, IP-address and network port.
    Local Socket
        IP-address and network port that were used by Yeti for receiving authorization attempt.
    PoP
        :ref:`Point of Presence (PoPs) <pops>` that was associated with authorization attempt.
    Node
        :ref:`Node <nodes>` that was associated with authorization attempt.
    Username
        Username that was received from remote host during authorization attempt.
    Request Method
        SIP request method that was used by remote host during authorization attempt.
    Ruri
        "R-URI" field of SIP header that was received from remote host during authorization attempt.
    From Uri
        From field of SIP header that was received from remote host during authorization attempt.
    To Uri
        To field of SIP header that was received from remote host during authorization attempt.
    Call
        Value of the *Call id* SIP header that was received from remote host during authorization attempt.
    Nonce
        Value of the *Nonce* parameter in the SIP Proxy-Authentication header that was received from remote host during authorization attempt.
    Response
        Value of the *Response* parameter in the SIP Proxy-Authentication header that was received from remote host during authorization attempt.
    X Yeti Auth
        Value of the custom SIP-header **X-Yeti-Auth** that was received from remote host during authorization attempt.
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


