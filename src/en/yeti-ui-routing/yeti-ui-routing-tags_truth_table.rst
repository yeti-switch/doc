
.. _tags_truth_table:

Truth table for tags
~~~~~~~~~~~~~~~~~~~~

Truth table for :ref:`tags <routing_tag>` is used for better understanding how different modes of routing tag comparation are used for selecting dialpeers that are related to the current call. Rows, in the table bellow, represent eight different states of Dialpeer Tags each of them are presented by two comparation modes (OR & AND). At same time, columns represent four different states of Call Tags. In the cells at the intersection of these states different levels of matching are presented. The highest level of matching is 3, the lowest level is 0. During selection of Dialpeers, in case if two or more Dialpeers have level of matching with current call (by comparation Dialpeer Tags and Call Tags) more than 0, Dialpeers with highest level of matching will be selected.

+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|                  | Comparation |                              Call Tags                                |
+   Dialpeer Tags  +             +-----------------+-----------------+-----------------+-----------------+
|                  |    mode     |      No tags    |       Tag 1     |   Tag 1, Tag 2  |       Tag 2     |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|                  |      OR     |        3        |        0        |        0        |        0        |
+    No tags       +-------------+-----------------+-----------------+-----------------+-----------------+
|                  |     AND     |        3        |        0        |        0        |        0        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|                  |      OR     |        0        |        3        |        0        |        0        |
+     Tag 1        +-------------+-----------------+-----------------+-----------------+-----------------+
|                  |     AND     |        0        |        3        |        0        |        0        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|                  |      OR     |        0        |        2        |        3        |        2        |
+  Tag 1,Tag 2     +-------------+-----------------+-----------------+-----------------+-----------------+
|                  |     AND     |        0        |        0        |        3        |        0        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|                  |      OR     |        0        |        2        |        3        |        2        |
+ Tag 1,Tag 2, Any +-------------+-----------------+-----------------+-----------------+-----------------+
|                  |     AND     |        0        |        0        |        3        |        0        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|                  |      OR     |        0        |        3        |        1        |        1        |
+    Tag 1,Any     +-------------+-----------------+-----------------+-----------------+-----------------+
|                  |     AND     |        0        |        3        |        1        |        0        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|                  |      OR     |        0        |        0        |        0        |        3        |
+       Tag 2      +-------------+-----------------+-----------------+-----------------+-----------------+
|                  |     AND     |        0        |        0        |        0        |        3        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|                  |      OR     |        0        |        1        |        1        |        3        |
+    Tag 2,Any     +-------------+-----------------+-----------------+-----------------+-----------------+
|                  |     AND     |        0        |        0        |        1        |        3        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|                  |      OR     |        0        |        1        |        1        |        1        |
+       Any        +-------------+-----------------+-----------------+-----------------+-----------------+
|                  |     AND     |        0        |        1        |        1        |        1        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+


    .. note:: Levels of matching:

              - 0 - Dialpeer does not match;

              - 1 - Dialpeer could be selected because ANY TAG mode was enabled;

              - 2 - Dialpeer could be selected because one of the Tags is coincided (only for OR mode);

              - 3 - Dialpeer could be selected because all Dialpeer's tags are the same as call's tags.