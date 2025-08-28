.. :maxdepth: 2

===========
STIR/SHAKEN
===========

.. _stir_shaken:

Yeti-Switch is compatible with STIR/SHAKEN mechanisms and allows you to perform both Identity validation and signing.
The Yeti system does not require any external components to perform these operations.

.. mermaid::

    graph LR
        gw1[Call originator]
        gw2[Termination provider]


        gw1 -->|legA SIP initial INVITE<br>**Identity:.....;info=https:\/\/example.com/certs/pub.pem**| validation-logic
        validation-logic --> call-routing
        validation-logic --> call-reject
        call-routing --> signing-logic

        signing-logic -->|legB SIP initial INVITE| gw2

        signing-certificate-repository -->|Fetching private certificate| signing-logic


        public-certificate-repository[Public certificate repository<br>**https:\/\/example.com/certs/pub.pem**]
        public-certificate-cache[Certificate Cache]

        validation-logic -->|Fetching public certificate| public-certificate-cache
        public-certificate-cache -->|Fetching public certificate| public-certificate-repository


        subgraph yeti[Yeti SBC]
            validation-logic[Signature Validation]
            public-certificate-cache
            signing-certificate-repository
            signing-logic[Signing]
            call-routing
            call-reject
        end


Signature Validation
====================

.. _stir_shaken_validation:

Signature validation logic is controlled by :ref:`Customers Auth STIR/SHAKEN settings <customer_auth_stir_shaken>`.
Depending on the configuration, Yeti may take different actions if the signature is missing or invalid.

The validation procedure requires a public key certificate to perform the cryptographic signature check.
This certificate is retrieved from a public repository according to the ``info`` parameter of the incoming Identity header.

During signature validation, Yeti performs the following steps:

    - Check if Identity header patameter ``info`` is same as Identity payload claim ``x5u``
    - Check if the public certificate repository URL from the ``info`` parameter and ``x5u`` claim is allowed by :ref:`Trusted repository configuration <stir_shaken_trusted_repositories>`
    - Retrieve the public certificate from the repository URL or from the internal cache
    - Verify that the public certificate is valid and not expired
    - Ensure that the certificate chain is linked to a trusted root certificate defined in :ref:`Trusted certificates configuration <stir_shaken_trusted_certificates>`
    - Validate the JWT signature
    - Check the ``iat`` (issued-at) timestamp for expiration
    - Confirm that the ``orig.tn`` and ``dest.tn`` attributes in the Identity header match the Source and Destination numbers present in SIP signaling

The results of signature validation are stored in the CDR fields: ``Lega Ss Status`` and ``Lega Identity``.


Signing
=======

.. _stir_shaken_signing:

When sending a call to the termination gateway, Yeti can either:

    - pass the original Identity header as-is,
    - remove it,
    - generate and attach its own signature.

This behavior is controlled by :ref:`Termination gateway STIR/SHAKEN settings <gateway_stir_shaken>`.

To perform signing, a private certificate and key material are required.
These are defined in :ref:`Signing Certificates configuration <stir_shaken_signing_certificates>`.

Yeti supports multiple signing certificates, and you can choose which certificate will be used for signing in :ref:`Termination gateway STIR/SHAKEN settings <gateway_stir_shaken>`.
Additionally, it is possible to override the certificate in :ref:`Customers Auth STIR/SHAKEN settings <customer_auth_stir_shaken>`, allowing different certificates to be used for different call originators (customers).
