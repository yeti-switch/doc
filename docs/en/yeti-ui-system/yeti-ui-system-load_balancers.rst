
Load Balancers
~~~~~~~~~~~~~~

Load Balancers are used as proxy-servers for SIP-signaling between  :ref:`Gateways <gateways>` and :ref:`YETI-SEMS nodes <nodes>`. Load Balancer could distribute calls to the :ref:`YETI-SEMS nodes <nodes>`. It is useful for cases when it is necessary to switch-off, reboot or reconfigure one or more :ref:`YETI-SEMS nodes <nodes>` without stopping work of whole system. Yeti will recognize only Load Balancers that are included in this list. In this case Yeti will search information about source :ref:`Gateway <gateways>` in the special headers that were received from Load Balancer.

**Load Balancer**'s attributes:
```````````````````````````````
    Id
       Load Balancer's id.
    Name
        Load Balancer's name.
    Signalling IP
        Signalling IP address for this *Load Balancer*.


