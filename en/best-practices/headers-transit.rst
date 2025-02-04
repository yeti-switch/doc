
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
    * Transit headers from origination= X-TEST-H, X-YETI*
    * Transit headers from termination= X-YETI-AUTH-11
    
term_gw:
    * Transit headers from origination= X-TEST-H
    * Transit headers from termination= X-YETI-AUTH*

Then in case of receiving INVITE from **orig_gw** with such headers:
::

    X-TEST-H: 123
    X-TEST-H2: 000
    X-YETI-H1: 321
    X-YETI-AUTH-HEADER: 333


It will be filtered sequentially twice (with the filter X-TEST-H, X-YETI* and X-TEST-H) and, after filtering, INVITE will be formed to the **term_gw** with such headers:
::

    X-TEST-H: 123
    
    
.. mermaid::

    graph LR
        gw1[Call originator]
        gw2[Termination provider]
               
    
        gw1 -->|<p style='text-align:left'>legA initial INVITE with headers<br>X-TEST-H: 123<br>X-TEST-H2: 000<br>X-YETI-H1: 321<br>X-YETI-AUTH-HEADER: 333</p>| sip-session1
        
        sip-session1 -->|<p style='text-align:left'>X-TEST-H: 123<br>X-YETI-H1: 321<br>X-YETI-AUTH-HEADER: 333</p>| sip-session2
        
        sip-session2 -->|<p style='text-align:left'>legB SIP initial INVITE<br>X-TEST-H: 123</p>| gw2
        
        
        subgraph yeti[Yeti SBC]
            sip-session1[Origination gateway<br>**Transit headers from origination** = X-TEST-H, X-YETI*]
            sip-session2[Termination gateway<br>**Transit headers from origination** = X-TEST-H]
        end
        

Thus, in case if from **term_gw** will be received **200OK** message with headers:
::

    X-YETI-AUTH-324: 333
    X-YETI-AUTH-11: 11
    X-YETI-TEST: 333

The headers will be filtered twice (by the filter X-YETI-AUTH*, and then by the X-YETI-AUTH-11 filter) and after filtering, a **200OK** message will be generated to **orig_gw** with the following headers:
::

    X-YETI-AUTH-11: 11
    

    
.. mermaid::

    graph RL
        gw1[Call originator]
        gw2[Termination provider]
               
    
        gw2 -->|<p style='text-align:left'>legB 200ok with headers<br>X-YETI-AUTH-324: 333<br>X-YETI-AUTH-11: 11<br>X-YETI-TEST: 333</p>| sip-session2
    
        sip-session2 -->|<p style='text-align:left'>X-YETI-AUTH-324: 333<br>X-YETI-AUTH-11: 11</p>| sip-session1
        
        
        sip-session1 -->|<p style='text-align:left'>legA 200ok with headers<br>X-YETI-AUTH-11: 11</p>| gw1
        
        subgraph yeti[Yeti SBC]
            sip-session1[Origination gateway<br>**Transit headers from termination** = X-YETI-AUTH-11]
            sip-session2[Termination gateway<br>**Transit headers from termination** = X-YETI-AUTH*]
        end
        
