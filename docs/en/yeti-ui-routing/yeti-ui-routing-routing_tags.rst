
.. _routing_tag:

Routing Tags
~~~~~~~~~~~~

Routing Tags are used for creating transparent routing rules within Yeti's routing logic. Routing Tags for every call are detected after processing call with using :ref:`Numberlists <numberlists>` on the basis :ref:`Routing Tag detection Rules <routing_tag_detection_rules>` and later they could be used for choosing :ref:`Destinations <destinations>` and :ref:`Dialpeers <dialpeers>` for the call routing.

Example of using Routing Tags for markuping call is represented on the picture below:

 .. graphviz:: ../graphviz/routing_tags.dot

At the beginning of routing procedure the call hasn't any Routing Tags.

During the :ref:`Authentication procedure <customer_auth_algorithm>` Yeti could change state of Routing Tags for the call. As it shown on picture (example) above :ref:`Customers Auth <customer_auth>` settings contain **Append selected tags** in the :ref:`Routing Tags options <routing_tags_options>` with **Tag action value** = **Tag1; Tag2; Tag3**. As a result of :ref:`Customers Auth <customer_auth>` Tags Processing procedure Yeti will append to the call three Routing Tags: **Tag1**, **Tag2** and **Tag3**.

The next step where Routing Tags can be changed - :ref:`Destination Numberlist <numberlists>` Tags Processing procedure. As it shown on picture (example) above :ref:`Destination Numberlist <numberlists>` settings contain **Remove selected tags** in the :ref:`Routing Tags options <numberlists_routing_tags_options>` with **Tag action value** = **Tag2**. As a result of :ref:`Destination Numberlist <numberlists>` Tags Processing procedure Yeti will remove from the call one Routing Tag: **Tag2**. Resulting state of call's Routing Tags after this procedure is: **Tag1** and **Tag3**.

The next step where Routing Tags can be changed - :ref:`Source Numberlist <numberlists>` Tags Processing procedure. As it shown on picture (example) above :ref:`Source Numberlist <numberlists>` settings contain **Intersection with selected tags** in the :ref:`Routing Tags options <numberlists_routing_tags_options>` with **Tag action value** = **Tag2, Tag3, Tag4**. As a result of :ref:`Source Numberlist <numberlists>` Tags Processing procedure Yeti will remove from the call all Routing Tags that aren't presented in both intersected sets. Resulting state of call's Routing Tags after this procedure is: **Tag3**.

The last step where Routing Tags can be changed - :ref:`Routing Tag detection Rule <routing_tag_detection_rules>` Tags Processing procedure. As it shown on picture (example) above :ref:`Routing Tag detection Rule <routing_tag_detection_rules>` settings contain **Clear tags** in the :ref:`Routing Tags options <routing_tag_detection_rules_tag_action>` with **Tag action value** = **null**. As a result of :ref:`Routing Tag detection Rule <routing_tag_detection_rules>` Tags Processing procedure Yeti will remove from the call all Routing Tags. Resulting state of call's Routing Tags after this procedure is: **null**.


Example of using *Routing Tags* for selecting :ref:`Destinations <destinations>` and :ref:`Dialpeers <dialpeers>` records  for the call routing is represented on the picture below:

 .. graphviz:: ../graphviz/routing_tags_using.dot


As you can see on this picture above, after the routing procedure Call has three Tags: **Tag1; Tag2; Tag3**.
At same time in the Yeti's Database three :ref:`Destinations <destinations>` and three :ref:`Dialpeers <dialpeers>` records are stored:

    -   Destination 1 is marked by three Tags **Tag1; Tag2; Tag3** and **AND** mode used for the comparision of *Routing Tags*;
    -   Destination 2 is marked by **Tag1** only and **OR** mode used for the comparision of  *Routing Tags*;
    -   Destination 3 is marked by **Tag1** only and **AND** mode used for the comparision of *Routing Tags*;
    -   Dialpeer 1 is marked by **Tag1; Tag2; Tag3** and **AND** mode used for the comparision of *Routing Tags*;
    -   Dialpeer 2 is marked by **Tag2** only and **AND** mode used for the comparision of *Routing Tags*;
    -   Dialpeer 3 is marked by **Tag1; Tag2; Tag3; Tag4** and **AND** mode used for the comparision of *Routing Tags*.

After selection procedures with using parameters above only two Destinations (Destination 1 and Destination 2) and one Dialpeer (Dialpeer 1) records were selected via following reasons:

    -   Destination 3 wasn't selected because in **AND** mode of comparision record should contain the same set of *Routing Tags*, but in the example above it contains only one Tag;
    -   Dialpeer 2 wasn't selected by the same reasons (in **AND** mode of comparision record should contain the same (with a call) set of *Routing Tags*);
    -   Dialpeer 3 wasn't selected because this record contains one additional Tag (**Tag4**) and could not be selected in the **AND** mode.



**Routing Tag**'s attributes:
`````````````````````````````

    .. _routing_tag_id:

    Id
       Unique Routing Tag's id.
    Name
       Unique Routing Tag's name.


