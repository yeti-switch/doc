
.. _tags_truth_table:

Truth table for tags
~~~~~~~~~~~~~~~~~~~~

Truth table for :ref:`tags <routing_tag>` is used for better understanding how different modes of routing tag comparation are used for selecting dialpeers that are related to the current call. Rows, in the table bellow, represent four different states of Call Tags. At same time, columns represent eight different states of Dialpeer Tags. In the cells at the intersection of these states different levels of coincidence are presented (for OR and AND modes of comparation). The highest level of coincidence is 3, the lowest level is 0. During selection of Dialpeers, in case if two or more Dialpeers have level of coincidence with current call (by comparation Dialpeer Tags and Call Tags) more than 0, Dialpeers with highest level of coincidence will be selected.

+--------------+----------+-----------+-------------+-----------------+-----------+-----------+-----------+-----------+
|              |                                    Dialpeer Tags                                                     |
+  Call Tags   +----------+-----------+-------------+-----------------+-----------+-----------+-----------+-----------+
|              |  No tags |   Tag 1   | Tag 1,Tag 2 | Tag 1,Tag 2, Any| Tag 1,Any |   Tag 2   | Tag 2,Any |    Any    |
+--------------+----------+-----------+-------------+-----------------+-----------+-----------+-----------+-----------+
|   No tags    |  OR = 3  |  OR = 0   |  OR = 0     |     OR = 0      |  OR = 0   |  OR = 0   |  OR = 0   |  OR = 0   |
|              |  AND = 3 |  AND = 0  |  AND = 0    |     AND = 0     |  AND = 0  |  AND = 0  |  AND = 0  |  AND = 0  |
+--------------+----------+-----------+-------------+-----------------+-----------+-----------+-----------+-----------+
|     Tag 1    |  OR = 0  | OR = 3    |  OR = 2     |    OR = 2       |  OR = 3   |  OR = 0   |  OR = 1   |  OR = 1   |
|              |  AND = 0 | AND = 3   |  AND = 0    |    AND = 0      |  AND = 3  |  AND = 0  |  AND = 0  |  AND = 1  |
+--------------+----------+-----------+-------------+-----------------+-----------+-----------+-----------+-----------+
| Tag 1, Tag 2 |  OR = 0  |  OR = 0   |  OR = 3     |    OR = 3       |  OR = 1   |  OR = 0   |  OR = 1   |  OR = 1   |
|              |  AND = 0 |  AND = 0  |  AND = 3    |    AND = 3      |  AND = 1  |  AND = 0  |  AND = 1  |  AND = 1  |
+--------------+----------+-----------+-------------+-----------------+-----------+-----------+-----------+-----------+
|    Tag 2     |  OR = 0  |  OR = 0   |  OR = 2     |    OR = 2       |  OR = 1   |  OR = 3   |  OR = 3   |  OR = 1   |
|              |  AND = 0 |  AND = 0  |  AND = 0    |    AND = 0      |  AND = 0  |  AND = 3  |  AND = 3  |  AND = 1  |
+--------------+----------+-----------+-------------+-----------------+-----------+-----------+-----------+-----------+


    .. note:: Levels of coincidence:

              0 - Dialpeer does not match
              1 - Dialpeer could be selected because ANY TAG mode was enabled
              2 - Dialpeer could be selected because one of the Tags is coincided (only for OR mode)
              3 - Dialpeer could be selected because all Dialpeer's tags are the same as call's tags