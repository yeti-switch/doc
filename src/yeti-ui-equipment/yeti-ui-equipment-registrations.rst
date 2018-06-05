
.. _registrations:

Registrations
~~~~~~~~~~~~~

YETI allows to use outgoing SIP registrations on remote vendor's or customer's equipment.

**Registration**'s attributes:
``````````````````````````````
    Id
        Unique Registration's id.
    Name
	    Name of this registration.
    Enabled
        Disabled registrations will be ignored.
    Pop
        Point of presence for registration requests.
    Node
        Node which will hold registration.
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
        SIP Proxy to use for registration.
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
	    Maximum amount of attempts for sending a REGISTER request, when an error code received from a registrar or timeout occured. In order to re-enable attempts of registration, you should disable the registration and then enable again.


