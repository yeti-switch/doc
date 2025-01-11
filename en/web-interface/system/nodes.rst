
.. _nodes:

Nodes
~~~~~

List of YETI nodes connected to current cluster.
Every node represents independent installation of YETI-SEMS, which communicate to management interface via RPC protocol.

**Node**'s attributes:
``````````````````````
    Id
       Node's id. Should be unique.
    Name
       Node's name.
    Pop
        Point of presence. Might be useful for logic grouping of nodes (different data-centers, as example).
    Rpc endpoint
        IP address and port on which YETI-SEMS is waiting for RPC connections. Value of this field should have format IP:PORT, for example 127.0.0.1:7080. See :ref:`SEMS sems.conf <sems_conf_1.13>` for details

 
In view mode user can use next tabs:

Details
        Common information about node.
Active Calls Chart
        Show the next graphs:
        - Active calls for 24 hours.
        - Calls count for month.
Comments
        Comments of user for current node.


