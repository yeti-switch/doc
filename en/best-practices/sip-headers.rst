

.. _sip_headers:

===========
SIP Headers
===========

This document explains some common SIP message headers


Headers formats. URI
====================

 * `RFC2806 <https://datatracker.ietf.org/doc/html/rfc2806>`_- Standard - URLs for Telephone Calls
 * `RFC5630 <https://datatracker.ietf.org/doc/html/rfc5630>`_ - Standard - The Use of the SIPS URI Scheme in the Session Initiation Protocol (SIP)
 * `RFC3966 <https://datatracker.ietf.org/doc/html/rfc3966>`_ - Standard - The tel URI for Telephone Numbers


sip uri with **user=phone** parameter:

 `RFC3398 <https://datatracker.ietf.org/doc/html/rfc3398>`_ - Standard - Integrated Services Digital Network (ISDN) User Part (ISUP) to Session Initiation Protocol (SIP) Mapping
 `RFC3261 Section-19.1.6 <https://datatracker.ietf.org/doc/html/rfc3261#section-19.1.6>`_ - Relating SIP URIs and tel URLs


P-Asserted-Identity
===================

The P-Asserted-Identity header field can be used to convey the proven identity of the originator of a request within a trusted network. Since the From header field is populated by the originating UA it may not necessarily contain the actual identity. It usually is established by means of authentication between the originating UA and its outgoing proxy. The outgoing proxy then adds a P-Asserted-Identity header field to assert the identity of the originator to other proxies.

This header field has only meaning within what is called a trusted network by mutual agreement on the requirements for its use by the parties involved.

The P-Asserted-Identity header field is defined in RFC 3325.

Source: `z9hg4bk.org <http://www.z9hg4bk.org/sip/hf/p-asserted-identity.html>`_

- `RFC3325 <https://datatracker.ietf.org/doc/html/rfc3325>`_ - Informational - Private Extensions to the Session Initiation Protocol (SIP) for Asserted Identity within Trusted Networks


P-Preferred-Identity
====================



.. _sip_headers_privacy:

Privacy
=======

Privacy framework allows to hide address information from non-trusted network elements(usually end-user terminals or gateways). In Yeti trusted domain boundaries configured by customers auth Privacy mode and termination gateway Privacy mode.

RFCs to read:

    - `RFC3323 <https://datatracker.ietf.org/doc/html/rfc3323>`_ - Standard - A Privacy Mechanism for the Session Initiation Protocol (SIP)
    - `RFC3325 <https://datatracker.ietf.org/doc/html/rfc3325>`_ - Informational - Private Extensions to the Session Initiation Protocol (SIP) for Asserted Identity within Trusted Networks
    - `RFC5379 <https://datatracker.ietf.org/doc/html/rfc5379>`_ - Informational - Guidelines for Using the Privacy Mechanism for SIP


.. _sip_headers_privacy_critical:

Critical private calls
    Calls where Privacy header includes value **critical**. Such calls should be dropped if system can't provide proper privacy level.
    See `RFC3323 section-4.2 <https://datatracker.ietf.org/doc/html/rfc3323#section-4.2>`_ for details


.. _sip_headers_diversion:

Diversion Header
================

`RFC5806 <https://datatracker.ietf.org/doc/html/rfc5806>`_ - Historical
`RFC4244 <https://datatracker.ietf.org/doc/html/rfc4244>`_ - History-Info header


Call scenarios Examples
=======================

`RFC5359 <https://datatracker.ietf.org/doc/html/rfc5359>`_

