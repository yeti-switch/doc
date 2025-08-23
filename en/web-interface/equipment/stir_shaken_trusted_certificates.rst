
.. _stir_shaken_trusted_certificates:

================================
STIR/SHAKEN Trusted Certificates
================================

This configuration section defines the trusted root certificates required for validating public certificates.
See :ref:`Identity Validation procedure <stir_shaken_validation>` for details.

Attributes
==========

Name
    A user-friendly name for the trusted root certificate.

Certificate
    The trusted root certificate in PEM format. Example::

        -----BEGIN CERTIFICATE-----
        MIIBqzCCAVCgAwIBAgIJALwomIWcKYBrMAoGCCqGSM49BAMCMCgxJjAkBgNVBAMM
        .........
        .........
        vcv6Kxxaj1puvAi5AiEAtbkNa56M4Sip0yLbWTXKdXcqAC5DHxbF4ab45aor220=
        -----END CERTIFICATE-----

Notes
=====

- In the USA, trusted root certificates can be obtained from:
  https://authenticatereg.iconectiv.com/download-lists

- In France, trusted root certificates can be fetched from:
  https://api.man-bpco.fr/ca/certs/
