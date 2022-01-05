
Balance notifications
~~~~~~~~~~~~~~~~~~~~~

Balance notifications are used for storing records about breaking of the low or high threshold of some :ref:`Account <accounts>` (where these properties are configured).

**Balance notification**'s properties:
``````````````````````````````````````
    Id
       Unique Balance notification's id.
    Created At
       Date and time of this record creation.
    Direction
        "Low" in case if balance of :ref:`Account <accounts>` is become less than low threshold.
        "High" in case if balance of :ref:`Account <accounts>` is become bigger than high threshold.
    Action
        "Fire" - in case of breaking some of threshold for :ref:`Account <accounts>` that is related this *Balance notification*.
        "Clear" - in case of restoring some of threshold for :ref:`Account <accounts>` that is related this *Balance notification*.
    Is Processed
        "Yes" - if this *Balance notification* was processed, "No" - otherwise.
    Processed At
       Date and time whet this *Balance notification* was processed.
    Data
        Specific data of :ref:`Account <accounts>` that is related this *Balance notification*.