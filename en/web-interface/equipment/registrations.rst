
.. _registrations:

=============
Registrations
=============

YETI is able to send outgoing SIP REGISTER requests(act as registrar client) to remote vendor's or customer's SIP registrar servers. This object allow to configure this registrar client behavior.

Registration attributes
=======================
    Id
        Unique Registration's id.
    Name
	    Name of this registration.
    Enabled
        Disabled registrations will be ignored.
    Pop
        Point of presence for registration requests.
    Node
        Node which will send REGISTER requests.
    Transport protocol
        SIP transport protocol which will be used for send request.
    Domain
        RURI,From domain part.
    Username
        RURI,From user part.
    Display username
        From display name part.
    Auth user
        Authorization username.
    Auth password
        Authorization password.
    Proxy
        SIP Proxy to use for registration. Proxy address should specified in **SIP URI** format eg sip:sip-proxy.example.com. See :ref:`SIP Flow example <registration_with_proxy>`
    Proxy transport protocol
        SIP transport protocol which will used for interaction with proxy.
    Contact
        Contact header. Should be in a SIP-URI format.
    Expire
        Registration expiration time.
    Force expire
        Force re-registration after **Expire** interval even is server set another value in response.
    Retry delay
	    Set the delay before sending a new REGISTER request to a registrar, when received error code or timeout occurred.
    Max attempts
	    Maximum amount of attempts for sending a REGISTER request, when an error code received from a registrar or timeout occurred. In order to re-enable attempts of registration, you should disable the registration and then enable again.
    Sip Interface Name
        Name of signalling interface from sems.conf that will be used to build outgoing REGISTER request.


Registration Flow without Proxy
===============================

.. mermaid::
	:align: center

	sequenceDiagram
		participant N as Yeti Node
		participant S as SIP Registrar server
		N->>S: REGISTER
		S->>N: 100 Trying
		S->>N: 401 Unauthorized + WWW-Authenticate header
		N->>S: ACK
		Note over N: Authorization response calculation<br/>based on nonce, password
		N->>S: REGISTER + Authorization header
		S->>N: 100 Trying
		S->>N: 200 OK
		N->>S: ACK

    
Registration Flow with Proxy
============================

.. _registration_with_proxy:


.. mermaid::
	:align: center

	sequenceDiagram
		participant N as Yeti Node
		participant P as SIP Proxy
		participant S as SIP Registrar server
		N->>P: REGISTER
		P->>N: 100 Trying
		P->>S: REGISTER
		S->>P: 401 Unauthorized + WWW-Authenticate header
		P->>N: 401 Unauthorized + WWW-Authenticate header
		N->>P: ACK
		P->>S: ACK
		Note over N: Authorization response calculation<br/>based on nonce, password
		N->>P: REGISTER + Authorization header
		P->>N: 100 Trying
		P->>S: REGISTER + Authorization header
		S->>P: 100 Trying
		S->>P: 200 OK
		P->>N: 200 OK
		N->>P: ACK
		P->>S: ACK
