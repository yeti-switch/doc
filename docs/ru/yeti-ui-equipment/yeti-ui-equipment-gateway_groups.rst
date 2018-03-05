
.. _gateway_groups:

Gateway groups
~~~~~~~~~~~~~~

Gateway group allows to use multiple gateways for traffic termination to the same vendor if these gateways have similar billing configuration.

**Gateway group**'s attributes:
```````````````````````````````
    .. _gateway_id:

    Id
        Unique gateway group id.
    Name
        Unique gateways group name.
    Vendor
        Gateway group owner.

    .. _gateway_group_prefer_same_pop:
    
    Prefer same pop
        If enabled, firstly use termination gateways with the same POP as origination traffic has.

