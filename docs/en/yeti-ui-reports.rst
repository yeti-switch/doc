
=======
Reports
=======

YETI WEB interface - Reports menu description. This section describes reports entities.


Custom CDR report
~~~~~~~~~~~~~~~~~

Custom CDR reports are used for creating customized reports and schedulers for sending regular reports to the user. Following information will be provided in this *CDR report*: Calls Count, Calls Duration, ACD (average call duration), ASR (answer-seizure ratio) Origination, ASR Termination, Origination Cost, Termination Cost, Profit.

**CDR report**'s attributes:
````````````````````````````
    Id
       Unique CDR report's id.
    Date start
        Date and time of the beginning of reporting period for this *CDR report*.
    Date end
        Date and time of the ending of reporting period for this *CDR report*.
    Customer
        :ref:`Customer <contractors>` that is related to the calls that will be used for selecting CDRs for this *CDR report*.
    Filter
        ****TODO****
    Group by
        ****TODO****
    Send to
        :ref:`Contact <contacts>` for sending this *CDR report*.


**CDR Scheduler**'s attributes:
```````````````````````````````
    Id
       Unique CDR Scheduler's id.
    Created At
        Date and time of this CDR Scheduler creation.
    Period
        Period of creating and sending regular *CDR report*. You can use following periods:

         **Hourly** - 1 time per hour (at the beginning of next hour);

         **Daily** - 1 time per day (at the beginning of next day);

         **Weekly** - 1 time per week (at the beginning of next week);

         **BiWeekly** - 1 time per 2 weeks (at the beginning next 2 weeks period);

         **Monthly** - 1 time per month (at the beginning of next month)).

    Customer
        :ref:`Customer <contractors>` that is related to the calls that will be used for selecting CDRs for this regular *CDR report*.
    Filter
        ****TODO****
    Group by
        ****TODO****
    Send to
        :ref:`Contact <contacts>` for sending this regular *CDR report*.
    Last Run At
        Date and time when this regular *CDR report* was created (empty if never).
    Next Run At
        Date and time when this regular *CDR report* will be created next time.

----

Customer traffic
~~~~~~~~~~~~~~~~

****TODO****

**Customer Traffic**'s attributes:
``````````````````````````````````
    Id
       Unique Customer Traffic's id.
    Date Start
        ****TODO****
    Date End
        ****TODO****
    Customer
        ****TODO****
    Send to
        ****TODO****

----

Vendor traffic
~~~~~~~~~~~~~~

****TODO****

**Vendor Traffic**'s attributes:
````````````````````````````````
    Id
       Unique Vendor Traffic's id.
    Date Start
        ****TODO****
    Date End
        ****TODO****
    Vendor
        ****TODO****
    Send to
        ****TODO****

----

Interval CDR report
~~~~~~~~~~~~~~~~~~~

****TODO****

**Interval CDR report**'s attributes:
`````````````````````````````````````
    Id
       Unique Interval CDR report's id.
    Date Start
        ****TODO****
    Date End
        ****TODO****
    Interval length
        ****TODO****
    Aggregation function
        ****TODO****
    Aggregate by
        ****TODO****
    Filter
        ****TODO****
    Group by fields
        ****TODO****
    Send to
        ****TODO****

----

Termination Distribution
~~~~~~~~~~~~~~~~~~~~~~~~

****TODO****

**Termination Distribution**'s attributes:
``````````````````````````````````````````
    Time Interval
        ****TODO****
    Customer
        ****TODO****

----

Origination performance
~~~~~~~~~~~~~~~~~~~~~~~

****TODO****

**Origination performance**'s attributes:
`````````````````````````````````````````
    Time Interval
        ****TODO****
    Customer
        ****TODO****

----

Bad routing
~~~~~~~~~~~

****TODO****

**Bad routing**'s attributes:
`````````````````````````````
    Id
       Unique Bad routing's id.
    Time Interval
        ****TODO****
    Customer
        ****TODO****
    Rateplan
        ****TODO****
    Routing Plan
        ****TODO****
    Internal Disconnect Code
        ****TODO****
    Internal Disconnect Reason
        ****TODO****

----

Not authenticated attempts
~~~~~~~~~~~~~~~~~~~~~~~~~~

****TODO****

**Not authenticated attempt**'s attributes:
```````````````````````````````````````````
    Time Interval
        ****TODO****
