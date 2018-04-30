
.. _routing_tag_detection_rules:

Routing Tag detection Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Routing Tag detection Rules are used for choosing :ref:`Routing tag <routing_tag>` (that is used for routing of calls) by source and destination :ref:`Areas <areas>` that are determined via :ref:`Area prfixes <area_prefixes>` table.

**Routing Tag detection Rule**'s attributes:
````````````````````````````````````````````
    Id
       Unique Routing Tag detection Rule's id.

    Routing tag ids **TODO**

    Src area
        Source :ref:`Area <areas>` (could be empty).

    Dst area
        Destination :ref:`Area <areas>` (could be empty).

    Tag action
        Describes one of the possible actions that could be applied to the current set of :ref:`Routing Tags <routing_tag>` that are applied for the call with using *Tag action value* below. *Routing Tag detection Rule* it is third (and last) step (after *Numberlists*) where :ref:`Routing Tags <routing_tag>` can be added to (or removed from) the call.  Following actions can be selected in this field:

            -   **Clear tags**. Removes all :ref:`Routing Tags <routing_tag>` from the call (if any were added early);

            -   **Remove selected tags**. Removes only :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) from the call;

            -   **Append selected tags**. Appends :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) to the call;

            -   **Intersection with selected tags**. Yeti leaves as is :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) in the call in case of their presence in the current set of :ref:`Routing Tags <routing_tag>` and removes any other :ref:`Routing Tags <routing_tag>` from the call.

    Tag action value
        In this field :ref:`Routing Tags <routing_tag>` for making some *Tag action* above could be chosen.

