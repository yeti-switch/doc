
Nodes
~~~~~

RealTime information about current state of the :ref:`Nodes <nodes>` (independent installations of YETI-SEMS).

**Node**'s filtering parameters:
````````````````````````````````
    Name
        Node's name. It is possible to use statement for this field (contains, equals, starts with, ends with).
    POP
        :ref:`Point of Presence <pops>` (PoP) that will be used for filtering Nodes. In case of specification - only Nodes that are related to selected PoP will be shown. For monitoring Nodes from all :ref:`Points of Presence <pops>`, please, choose "Any" in this field.

**Node**'s properties:
``````````````````````
    Name
        Node's name.
    Active Calls Count
        Count of active calls that a currently going via :ref:`Node <nodes>`.
    Version
        Version of SEMS that is used on :ref:`Node <nodes>`.
    Shutdown Req Time
        Time for requesting shutdown of the :ref:`Node <nodes>`. This is time for planned shutdown (or restart) of software. During period before this Time new calls will be rejected by the :ref:`Node <nodes>`. If this field is empty :ref:`Node <nodes>` is working in normal mode.
    Sessions Num
        General amount of active sessions between Yeti and :ref:`Gateways <gateways>`.
    Uptime
        Time from last reboot for this :ref:`Node <nodes>`.


