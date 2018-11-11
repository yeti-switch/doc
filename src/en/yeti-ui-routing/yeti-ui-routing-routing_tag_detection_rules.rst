
.. _routing_tag_detection_rules:

Routing Tag detection Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Routing Tag detection Rules are used for changing set of :ref:`Routing tags <routing_tag>` (that are used for routing of calls) by source and destination :ref:`Areas <areas>` that are determined via :ref:`Area prefixes <area_prefixes>` table and by source and destination prefixes. Rule will be chosen only in case of matching all conditions (Src & Dst Areas, Src & Dst prefixes) that are not empty.

**Routing Tag detection Rule**'s attributes:
````````````````````````````````````````````
    Id
       Unique Routing Tag detection Rule's id.

    Routing tag ids
       Allows to choose :ref:`Routing tags <routing_tag>` that should be set for the call at the previous steps (Authentication, Numberlist processing etc.). In case of matching between :ref:`Routing tags <routing_tag>` that were chosen for the call and :ref:`Routing tags <routing_tag>` that were chosen in this field - Yeti will check :ref:`Area <areas>` (source and destination) and will apply (if any) *Tag actions* bellow.

    Routing tag mode
       Allows to choose :ref:`Routing tags <routing_tag>` comparison mode (**OR** or **AND**). In the **OR** mode at least one :ref:`Routing Tag <routing_tag>` (from the list of :ref:`Routing Tags <routing_tag>` that were chosen for the call during the routing algorithm) should be included in the set of :ref:`Routing Tags <destination_routing_tag>` that are chosen for this *Routing Tag detection Rule* record. In the **AND** mode all :ref:`Routing Tags <routing_tag>` (that were chosen for the call during the routing algorithm) should be the same with the set of :ref:`Routing Tags <destination_routing_tag>` that are chosen for this *Routing Tag detection Rule* record.

    Src area
       Source :ref:`Area <areas>` (could be empty).

    Dst area
        Destination :ref:`Area <areas>` (could be empty).

    Src prefix
        This field is used for setting prefix of source number (A-number). This *Rule* will be chosen only in case of matching this Prefix with first symbols of A-number (together with other conditions). This field could be empty.

    Dst prefix
        This field is used for setting prefix of source number (B-number). This *Rule* will be chosen only in case of matching this Prefix with first symbols of B-number (together with other conditions). This field could be empty.

.. _routing_tag_detection_rules_tag_action:

    Tag action
        Describes one of the possible actions that could be applied to the current set of :ref:`Routing Tags <routing_tag>` that are applied for the call with using *Tag action value* below. *Routing Tag detection Rule* it is third (and last) step (after *Numberlists*) where :ref:`Routing Tags <routing_tag>` can be added to (or removed from) the call.  Following actions can be selected in this field:

            -   **Clear tags**. Removes all :ref:`Routing Tags <routing_tag>` from the call (if any were added early);

            -   **Remove selected tags**. Removes only :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) from the call;

            -   **Append selected tags**. Appends :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) to the call;

            -   **Intersection with selected tags**. Yeti leaves as is :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) in the call in case of their presence in the current set of :ref:`Routing Tags <routing_tag>` and removes any other :ref:`Routing Tags <routing_tag>` from the call.

    Tag action value
        In this field :ref:`Routing Tags <routing_tag>` for making some *Tag action* above could be chosen.

