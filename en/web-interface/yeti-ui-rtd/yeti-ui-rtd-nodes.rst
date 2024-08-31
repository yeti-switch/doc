
Nodes
~~~~~

RealTime information about current state of the :ref:`Nodes <nodes>`. Web UI fetching information about nodes using JRPC connection.

Attributes:

    Name
        Node's name.
    Active Calls Count
        Count of active calls that a currently going via :ref:`Node <nodes>`.
    Version
        Version of SEMS Yeti module on :ref:`Node <nodes>`.
    Core Version
        Version of SEMS that on :ref:`Node <nodes>`.
    Shutdown Req Time
        Time when node was switched to shutdown mode. If this field is empty node is working in normal mode. In shutdown mode node processing active calls but not accept new calls. In this mode load balancer routing calls to other nodes.
    Sessions Num
        General amount of active sessions between. Yeti creating separate session for each call leg so usually each active call requires 2 sessions.
    Uptime
        Time from last reboot for this :ref:`Node <nodes>`.


