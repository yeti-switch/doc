
.. _events:

Events
~~~~~~

Events log contains records about tasks that are in queue to the SEMS. Tasks are adding to this queue in case of changing some critical (for SEMS working) properties (like Codec's configuration). SEMS will re-load data from Yeti's database after receiving this event. Record will be removed from this *Events* log after successful sending it to the SEMS by **EventProcessor** :ref:`Job Procedure <jobs>`. In the normal working mode this log will be empty. It is possible to use filters to select necessary records.

**Event**'s properties:
```````````````````````
    Id
       Unique Event's id.
    Node
       :ref:`Node <nodes>` that is related to this *Event*.
    Retries
        Current amount of retries for sending this command (task) to the SEMS.
    Command
        Command that was sent to the SEMS.


