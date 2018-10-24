
.. _prefix_truth_table:

Truth table for prefixes
~~~~~~~~~~~~~~~~~~~~~~~~

Truth table for prefixes is used for better understanding how matching between Prefix field of :ref:`Destinations <destinations>` or/and :ref:`Dialpeers <dialpeers>` and destination number (number B) for the current call is working.
Rows, in the table bellow, represent different examples of the destination number for the current call. At same time, columns represent examples of the Prefix field of :ref:`Destinations <destinations>` or/and :ref:`Dialpeers <dialpeers>`. In the cells at the intersection of these rows & columns states of matching are presented (T - true, F - false).

+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|   Destination    |                                  Prefix value                                       |
+                  +-------------+-----------------+-----------------+-----------------+-----------------+
|     number       |     380     |      380[6-8]   |      38066      |   38066[2-3]    |     380[4-5]    |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|   380662296132   |      T      |        T        |        T        |        T        |        F        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|   380972296132   |      T      |        F        |        F        |        F        |        F        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|   380779101005   |      T      |        T        |        F        |        F        |        F        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|   380663294134   |      T      |        T        |        T        |        T        |        F        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|   380447101812   |      T      |        F        |        F        |        F        |        T        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|   441821347689   |      F      |        F        |        F        |        F        |        F        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+
|   380881234567   |      T      |        T        |        F        |        F        |        F        |
+------------------+-------------+-----------------+-----------------+-----------------+-----------------+




