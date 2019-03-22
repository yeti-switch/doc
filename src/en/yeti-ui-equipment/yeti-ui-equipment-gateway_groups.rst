
.. _gateway_groups:

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
    
    Prefer same pop
        If enabled, firstly use termination gateways with the same POP as origination traffic has.

