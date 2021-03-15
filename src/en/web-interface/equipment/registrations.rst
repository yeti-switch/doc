
.. _registrations:

Registrations
~~~~~~~~~~~~~

YETI is able to send outgoing SIP REGISTER requests(act as registrar client) to remote vendor's or customer's SIP registrar servers. This object allow to configure this registrar client behavior.

Registration attributes
```````````````````````
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
	    Maximum amount of attempts for sending a REGISTER request, when an error code received from a registrar or timeout occured. In order to re-enable attempts of registration, you should disable the registration and then enable again.
    Sip Interface Name
        Name of signalling interface from sems.conf that will be used to build outgoing REGISTER request.


Registration Flow without Proxy
```````````````````````````````

.. raw:: html

	<embed>
	 <pre class='code xu mscgen_js' data-language='xu' data-named-style='basic'>
	msc {
  
	  arcgradient=0, hscale=2;
 
	  C[label="YETI Node\n11.11.11.11"],
	  S[label="SIP Registrar Server\n13.13.13.13"];
  
	  C => S [label="REGISTER"];
	  S >> C [label="100 Trying(optional)"];
	  S => C [label="401 Unauthorized + WWW-Authenticate header"];
	  C => S [label="ACK"];
	  C => S [label="REGISTER + Authorization header"];
	  S >> C [label="100 Trying(optional)"];
	  S => C [label="200 OK"];
	  C => S [label="ACK"];

	}

    </pre>
    </embed>

    
Registration Flow with Proxy
````````````````````````````
.. _registration_with_proxy:

.. raw:: html

	<embed>
	 <pre class='code xu mscgen_js' data-language='xu' data-named-style='basic'>
	msc {
  
	  arcgradient=0, hscale=2;
 
	  C[label="YETI Node\n11.11.11.11"],
	  L[label="SIP Proxy\n12.12.12.12"],
	  S[label="SIP Registrar Server\n13.13.13.13"];
  
	  C => L [label="REGISTER"];
	  L >> C [label="100 Trying"];
	  L => S [label="REGISTER"];
	  S >> L [label="100 Trying"];
	  S => L [label="401 Unauthorized + WWW-Authenticate header"];
	  L => C [label="401 Unauthorized + WWW-Authenticate header"];
	  C => L [label="ACK"];
	  

  	  C => L [label="REGISTER + Authorization header"];
	  L >> C [label="100 Trying"];
	  L => S [label="REGISTER + Authorization header"];
	  S >> L [label="100 Trying"];
	  S => L [label="200 OK"];
	  L => C [label="200 OK"];
	  C => L [label="ACK"];

	}

    </pre>
    </embed>



