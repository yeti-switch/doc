
.. _nodes:

Nodes
~~~~~

List of YETI nodes connected to current cluster.
Every node represents independent installation of YETI-SEMS, which communicate to management interface via RPC protocol.

**Node**'s attributes:
``````````````````````
    Id
       Node's id.
    Name
       Node's name.
    Pop
        Point of presence. Might be useful for logic grupping of nodes (different data-centers, as example).
    Signalling ip
        IP address of node.
    Signaling port
        Network port for sending SIP-packets (dafault value 5060).
    Rpc endpoint
        IP address and port on which YETI-SEMS is waiting for RPC connections.

In view mode user can use next tabs:

Details
        Common information about node.
Active Calls Chart
        Show the next graphs:
        - Active calls for 24 hours.
        - Calls count for month.
Comments
        Comments of user for current node.


