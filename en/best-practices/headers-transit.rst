
.. :maxdepth: 2

===============
Headers transit
===============

.. _headers_fitering:

By default Yeti are not relaying any headers from one call leg to another. Headers transit mechanism allows to configure such relaying.


After the routing, YETI performs filtering twice: for the origination :ref:`Gateway <gateways>` and for the termination :ref:`Gateway <gateways>`.
Gateway's parameter **Transit headers from origination** describes the transfer of headers from LegA to LegB, the parameter **Transit headers from termination** - from LegB to LegA.

For example, an incoming call arrives via the :ref:`Gateway <gateways>` **orig_gw** and terminates via the :ref:`Gateway <gateways>` **term_gw** with the corresponding settings.

orig_gw:
    * Transit headers from origination= X-TEST-HEADER, X-YETI*
    * Transit headers from termination= X-YETI*
    
term_gw:
    * Transit headers from origination= X-TEST-HEADER
    * Transit headers from termination= X-YETI-AUTH*

Then in case of receiving INVITE from **orig_gw** with such headers:
::

    X-TEST-HEADER: 123
    X-YETI-HEADER1: 321
    X-YETI-AUTH-HEADER: 333


It will be filtered sequentially twice (with the filter X-TEST-HEADER, X-YETI* and X-TEST-HEADER) and, after filtering, INVITE will be formed to the **term_gw** with such headers:
::

    X-TEST-HEADER: 123


Thus, in case if from **term_gw** will be received **200OK** message with hiders:
::

    X-YETI-AUTH-324: 333
    X-YETI-TEST: 333

The headers will be filtered twice (by the filter X-YETI-AUTH*, and then by the X-YETI* filter) and after filtering, a **200OK** message will be generated to **orig_gw** with the following headers:
::

    X-YETI-AUTH-324: 333







