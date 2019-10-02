
.. _gateway_groups:

.. |br| raw:: html

   <br />

Gateway groups
~~~~~~~~~~~~~~

Gateway group allows to use multiple gateways for traffic termination to the same vendor. Yeti will load-balance calls between gateways in same gateway group basing on gateways priority/weight.
To terminate calls to Gateway group you should configure dialpeer to point to gateway group instead of gateway.

**Gateway group**'s attributes:
```````````````````````````````
    .. _gateway_id:

    Id
        Unique gateway group id.
    Name
        Unique gateways group name.
    Vendor
        Gateway group owner. Gateway group should include only gateways with same vendor.

    .. _gateway_group_prefer_same_pop:
    
    Balancing Mode
        Algorithm of call distribution between gateways in this gateway group. |br|
        **Priority/Weigth balancing** - Calls will be distributed based on Gateway priority/weight |br|
        **Priority/Weigth balancing. Prefer gateways from same POP** - Gateways where POP = call POP will be prioritized  |br| 
        **Priority/Weigth balancing. Exclude gateways from other POPs** - Gateways where POP != call POP will be excluded from routeset |br|
    
