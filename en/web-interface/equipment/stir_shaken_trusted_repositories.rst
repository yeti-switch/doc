
.. _stir_shaken_trusted_repositories:

================================
STIR/SHAKEN Trusted Repositories
================================

This configuration section defines the list of trusted URLs from which Yeti may fetch STIR/SHAKEN public certificates during the :ref:`Identity Validation procedure <stir_shaken_validation>`.

Attributes
==========

URL Pattern
    A regex pattern or specific URL that defines which repositories are allowed. Examples:

        - ``https://\*`` — allows requests to any HTTPS URL
        - ``https://example.com/\*`` — allows fetching any certificate from the **example.com** domain

Validate HTTPS Certificate
    When using the HTTPS protocol, this flag enforces validation of the HTTPS server certificate to ensure authenticity.
