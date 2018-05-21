
.. _routing_tag:

Routing Tags
~~~~~~~~~~~~

Routing Tags are used for creating transparent routing rules within Yeti's routing logic. Routing Tag for every call is detected after processing call with using :ref:`Numberlists <numberlists>` on the basis :ref:`Routing Tag detection Rules <routing_tag_detection_rules>`.

Example of using Routing Tags is represented on the picture below:

 .. graphviz:: ../graphviz/routing_tags.dot

At the beginning of routing procedure the call hasn't any Routing Tags.

During the :ref:`Authentication procedure <customer_auth_algorithm>` Yeti could change state of Routing Tags for the call. As it shown on picture (example) above :ref:`Customers Auth <customer_auth>` settings contain **Append selected tags** in the :ref:`Routing Tags options <routing_tags_options>` with **Tag action value** = **Tag1; Tag2; Tag3**. As a result of :ref:`Customers Auth <customer_auth>` Tags Processing procedure Yeti will append to the call three Routing Tags: **Tag1**, **Tag2** and **Tag3**.

The next step where Routing Tags can be changed - :ref:`Destination Numberlist <numberlists>` Tags Processing procedure. As it shown on picture (example) above :ref:`Destination Numberlist <numberlists>` settings contain **Remove selected tags** in the :ref:`Routing Tags options <numberlists_routing_tags_options>` with **Tag action value** = **Tag2**. As a result of :ref:`Destination Numberlist <numberlists>` Tags Processing procedure Yeti will remove from the call one Routing Tag: **Tag2**. Resulting state of call's Routing Tags after this procedure is: **Tag1** and **Tag3**.

The next step where Routing Tags can be changed - :ref:`Source Numberlist <numberlists>` Tags Processing procedure. As it shown on picture (example) above :ref:`Source Numberlist <numberlists>` settings contain **Intersection with selected tags** in the :ref:`Routing Tags options <numberlists_routing_tags_options>` with **Tag action value** = **Tag2, Tag3, Tag4**. As a result of :ref:`Source Numberlist <numberlists>` Tags Processing procedure Yeti will remove from the call all Routing Tags that aren't presented in both intersected sets. Resulting state of call's Routing Tags after this procedure is: **Tag3**.

The last step where Routing Tags can be changed - :ref:`Routing Tag detection Rule <routing_tag_detection_rules>` Tags Processing procedure. As it shown on picture (example) above :ref:`Routing Tag detection Rule <routing_tag_detection_rules>` settings contain **Clear tags** in the :ref:`Routing Tags options <routing_tag_detection_rules_tag_action>` with **Tag action value** = **null**. As a result of :ref:`Routing Tag detection Rule <routing_tag_detection_rules>` Tags Processing procedure Yeti will remove from the call all Routing Tags. Resulting state of call's Routing Tags after this procedure is: **null**.


**Routing Tag**'s attributes:
`````````````````````````````

    .. _routing_tag_id:

    Id
       Unique Routing Tag's id.
    Name
       Unique Routing Tag's name.


