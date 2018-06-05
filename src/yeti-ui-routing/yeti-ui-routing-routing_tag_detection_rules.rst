
.. _routing_tag_detection_rules:

Routing Tag detection Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Routing Tag detection Rules are used for changing set of :ref:`Routing tags <routing_tag>` (that are used for routing of calls) by source and destination :ref:`Areas <areas>` that are determined via :ref:`Area prefixes <area_prefixes>` table.

**Routing Tag detection Rule**'s attributes:
````````````````````````````````````````````
    Id
       Unique Routing Tag detection Rule's id.

    Routing tag ids
       Allows to choose :ref:`Routing tags <routing_tag>` that should be set for the call at the previous steps (Authentication, Numberlist processing etc.). In case of matching between :ref:`Routing tags <routing_tag>` that were chosen for the call and :ref:`Routing tags <routing_tag>` that were chosen in this field - Yeti will check :ref:`Area <areas>` (source and destination) and will apply (if any) *Tag actions* bellow.

    Routing tag mode
       Allows to choose mode (**OR** or **AND**) of :ref:`Routing tags <routing_tag>` comparison.

    Src area
       Source :ref:`Area <areas>` (could be empty).

    Dst area
        Destination :ref:`Area <areas>` (could be empty).

.. _routing_tag_detection_rules_tag_action:

    Tag action
        Describes one of the possible actions that could be applied to the current set of :ref:`Routing Tags <routing_tag>` that are applied for the call with using *Tag action value* below. *Routing Tag detection Rule* it is third (and last) step (after *Numberlists*) where :ref:`Routing Tags <routing_tag>` can be added to (or removed from) the call.  Following actions can be selected in this field:

            -   **Clear tags**. Removes all :ref:`Routing Tags <routing_tag>` from the call (if any were added early);

            -   **Remove selected tags**. Removes only :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) from the call;

            -   **Append selected tags**. Appends :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) to the call;

            -   **Intersection with selected tags**. Yeti leaves as is :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) in the call in case of their presence in the current set of :ref:`Routing Tags <routing_tag>` and removes any other :ref:`Routing Tags <routing_tag>` from the call.

    Tag action value
        In this field :ref:`Routing Tags <routing_tag>` for making some *Tag action* above could be chosen.

