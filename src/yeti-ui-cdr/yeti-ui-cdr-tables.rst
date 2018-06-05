
.. _cdr_tables:

Tables
~~~~~~

Tables are used for review general information about Call Delivery Records (CDR) that are stored in the system.

**CDR Table**'s attributes:
```````````````````````````
    Id
       Unique CDR Table's id.
    Name
        Unique CDR Table's name.
    Active
        Yes - if CDRs of this *Table* are available in the :ref:`CDR History <cdr_history>`.
        No - if  CDRs of this *Table* are available in the :ref:`CDR Archive <cdr_archive>`.
    Date Start
        Date of *Table* creation (date of the first CDR record in the *Table*).
    Date Stop
        Date of *Table* closing (date of the last CDR record in the *Table*).
    Data Size
        Size of data that are represented in this *Table* without system information.
    Full Size
        Full size of data that are represented in this *Table* including system information.


