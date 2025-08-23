
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
        HU1ldGFzd2l0Y2ggU1RJLUNBIFNIQUtFTiBSb290MB4XDTIwMTEyNTExMjEwM1oX
        DTQwMTEyMDExMjEwM1owKDEmMCQGA1UEAwwdTWV0YXN3aXRjaCBTVEktQ0EgU0hB
        S0VOIFJvb3QwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAATyreklRBPdqnX38C+h
        gk2SSlc0wql13TIvWTOt0sme07R9UDramRRqolR58Qz04CCtO8EPeuZKzqE0Xdb0
        RJQoo2MwYTAdBgNVHQ4EFgQUOVRpugxs9p9X0ZsBMUWKoPv/eGowHwYDVR0jBBgw
        FoAUOVRpugxs9p9X0ZsBMUWKoPv/eGowDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8B
        Af8EBAMCAgQwCgYIKoZIzj0EAwIDSQAwRgIhAN+DEVzNLBjOsq8TbDHbkhO1MDUh
        vcv6Kxxaj1puvAi5AiEAtbkNa56M4Sip0yLbWTXKdXcqAC5DHxbF4ab45aor220=
        -----END CERTIFICATE-----

Notes
=====

- In the USA, trusted root certificates can be obtained from:
  https://authenticatereg.iconectiv.com/download-lists

- In France, trusted root certificates can be fetched from:
  https://api.man-bpco.fr/ca/certs/16.cer
