

.. _stir_shaken_signing_certificates:

================================
STIR/SHAKEN Signing Certificates
================================

This configuration section defines the certificates and private keys used for the :ref:`Identity Signing procedure <stir_shaken_signing>`.

Attributes
==========

Name
    A user-friendly name for the signing certificate.

Certificate
    The certificate in PEM format.
    The certificate must use the ``ecdsa-with-SHA256`` signature algorithm.

Private Key
    The corresponding ECDSA private key in PEM format.

X5U
    The **X5U** parameter for the Identity header.
    The URL in X5U must point to your certificate and be publicly accessible.
    Remote systems will use this URL to fetch your certificate during their own Identity validation procedure.
