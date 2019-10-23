
Incoming Registrations
~~~~~~~~~~~~~~~~~~~~~~

Incoming Registrations page contains up-to-date bindings between an address-of-record and contact address(es), to which SIP requests for the AOR should be forwarded.

These are such items:

    Gateway
        Name and Id of the Gateway used by UA.

    Contact
        Contact header field value of REGISTER request.

    Expires
        Indicates how long the binding between AOR and the Contact to be valid. The value is a number indicating seconds and taken from "expires" parameter of Contact header or value of the Expires header.

    Path
        Comma separated list of Path header values from incoming REGISTER request. For more details see `RFC3327 <https://tools.ietf.org/html/rfc3327>`_.

    User Agent
        User-Agent header value from incoming REGISTER.
