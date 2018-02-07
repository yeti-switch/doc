
=======
Reports
=======

YETI WEB interface - Reports menu description. This section describes reports entities.


Custom CDR report
~~~~~~~~~~~~~~~~~

Custom CDR reports are used for creating customized reports and schedulers (for sending regular reports to the user) about all calls that were passed via Yeti. Following information is provided in this *CDR report*: Calls Count, Calls Duration, ACD (average call duration), ASR (answer-seizure ratio) Origination, ASR Termination, Origination Cost, Termination Cost, Profit.

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
        Date and time when this regular *CDR report* was prepared last time (empty if never).
    Next Run At
        Date and time when this regular *CDR report* will be prepared next time.

----

Customer traffic
~~~~~~~~~~~~~~~~

Customer traffic reports are used for creating reports and schedulers (for sending regular reports to the user) about all traffic that is related to some :ref:`Customer <contractors>`. Following information is provided in this *Customer traffic* report: Calls Count, Success Call Count, Short Calls Count, Calls Duration, ASR (answer-seizure ratio), ACD (average call duration), Origination Cost, Termination Cost, Profit, First Call At (date and time of first CDR), Last Call At (date and time of the last CDR). Calls can be grouped by Vendors and/or Destinations.

**Customer Traffic**'s attributes:
``````````````````````````````````
    Id
       Unique Customer Traffic's id.
    Date start
        Date and time of the beginning of reporting period for this *Customer traffic* report.
    Date end
        Date and time of the ending of reporting period for this *Customer traffic* report.
    Customer
        :ref:`Customer <contractors>` that is related to the calls that will be used for selecting CDRs for this *Customer traffic* report.
    Send to
        :ref:`Contact <contacts>` for sending this  *Customer traffic* report.


**Customer Traffic Scheduler**'s attributes:
````````````````````````````````````````````
    Id
       Unique Customer Traffic Scheduler's id.
    Created At
        Date and time of this Customer Traffic Scheduler creation.
    Period
        Period of creating and sending regular *Customer traffic*. You can use following periods:

         **Hourly** - 1 time per hour (at the beginning of next hour);

         **Daily** - 1 time per day (at the beginning of next day);

         **Weekly** - 1 time per week (at the beginning of next week);

         **BiWeekly** - 1 time per 2 weeks (at the beginning next 2 weeks period);

         **Monthly** - 1 time per month (at the beginning of next month)).

    Customer
            :ref:`Customer <contractors>` that is related to the calls that will be used for selecting CDRs for this regular *Customer traffic* report.
    Send to
        :ref:`Contact <contacts>` for sending this regular *Customer traffic* report.
    Last Run At
        Date and time when this regular *Customer traffic* report was prepared last time (empty if never).
    Next Run At
        Date and time when this regular *Customer traffic* report will be prepared next time.

----

Vendor traffic
~~~~~~~~~~~~~~

Vendor traffic reports are used for creating reports and schedulers (for sending regular reports to the user) about all traffic that is related to some :ref:`Vendor <contractors>`. Following information is provided in this *Vendor traffic* report: Calls Count, Success Call Count, Short Calls Count, Calls Duration, ASR (answer-seizure ratio), ACD (average call duration), Origination Cost, Termination Cost, Profit, First Call At (date and time of first CDR), Last Call At (date and time of the last CDR). Calls are grouped by Customers.

**Vendor Traffic**'s attributes:
````````````````````````````````
    Id
       Unique Vendor Traffic's id.
    Date start
        Date and time of the beginning of reporting period for this *Vendor traffic* report.
    Date end
        Date and time of the ending of reporting period for this *Vendor traffic* report.
    Vendor
        :ref:`Vendor <contractors>` that is related to the calls that will be used for selecting CDRs for this *Vendor traffic* report.
    Send to
        :ref:`Contact <contacts>` for sending this  *Vendor traffic* report.


**Vendor Traffic Scheduler**'s attributes:
``````````````````````````````````````````
    Id
       Unique Vendor Traffic Scheduler's id.
    Created At
        Date and time of this Vendor Traffic Scheduler creation.
    Period
        Period of creating and sending regular *Vendor traffic*. You can use following periods:

         **Hourly** - 1 time per hour (at the beginning of next hour);

         **Daily** - 1 time per day (at the beginning of next day);

         **Weekly** - 1 time per week (at the beginning of next week);

         **BiWeekly** - 1 time per 2 weeks (at the beginning next 2 weeks period);

         **Monthly** - 1 time per month (at the beginning of next month)).

    Vendor
            :ref:`Vendor <contractors>` that is related to the calls that will be used for selecting CDRs for this regular *Vendor traffic* report.
    Send to
        :ref:`Contact <contacts>` for sending this regular *Vendor traffic* report.
    Last Run At
        Date and time when this regular *Vendor traffic* report was prepared last time (empty if never).
    Next Run At
        Date and time when this regular *Vendor traffic* report will be prepared next time.


----

Interval CDR report
~~~~~~~~~~~~~~~~~~~

****TODO****

**Interval CDR report**'s attributes:
`````````````````````````````````````
    Id
       Unique Interval CDR report's id.
    Date start
        Date and time of the beginning of reporting period for this *Interval CDR report*.
    Date end
        Date and time of the ending of reporting period for this *Interval CDR report*.
    Interval length
        ****TODO****    5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 1 Day
    Aggregation function
        ****TODO****
        Sum
        Count
        Avg
        Max
        Min
    Aggregate by
        ****TODO****
    Filter
        ****TODO****
    Group by fields
        ****TODO****
    Send to
        :ref:`Contact <contacts>` for sending this  *Interval CDR report*.

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
