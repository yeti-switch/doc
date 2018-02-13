
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
        Statement (f.e. "vendor_price < 10") that will be used for filtering records for this *CDR report*.
    Group by
        Attributes of CDR that will be used for grouping records for this *CDR report*.
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
        Statement (f.e. "vendor_price < 10") that will be used for filtering records for this regular *CDR report*.
    Group by
        Attributes of CDR that will be used for grouping records for this regular *CDR report*.
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

Interval CDR reports are used for creating reports and schedulers (for sending regular reports to the user) about all traffic in the system grouped by discrete intervals of time. As an output of this *Interval CDR report* Yeti will provide table where presented only intervals where calls were made. At the *Timestamp* field beginning of the time interval will be presented.

**Interval CDR report**'s attributes:
`````````````````````````````````````
    Id
       Unique Interval CDR report's id.
    Date start
        Date and time of the beginning of reporting period for this *Interval CDR report*.
    Date end
        Date and time of the ending of reporting period for this *Interval CDR report*.
    Interval length
        Interval of time that will be used for grouping records in this *Interval CDR report*. Following intervals are available: 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 1 Day.
    Aggregation function
        Aggregation function that will be used for calculation reporting parameter for this *Interval CDR report*. Following functions are available: Sum, Count, Avg, Max, Min.
    Aggregate by
        Parameter of CDR that will be used for calculation with using aggregation function above.
    Filter
        Statement (f.e. "vendor_price < 10") that will be used for filtering records for this *Interval CDR report*.
    Group by fields
        Attributes of CDR that will be used for grouping records for this *Interval CDR report*.
    Send to
        :ref:`Contact <contacts>` for sending this *Interval CDR report*.

----

Termination Distribution
~~~~~~~~~~~~~~~~~~~~~~~~

Termination Distribution report is used for monitoring list of vendors that were used for termination of the calls (from the whole system or from the separate customer) during the short period of time (less than 1 Day).

**Termination Distribution**'s attributes:
``````````````````````````````````````````
    Time Interval
        Period of time for selecting CDRs that will be used for creating this *Termination Distribution* report. Following intervals are available: 1 minute, 5 minutes, 10 minutes, 15 minutes, 1 hour, 3 hours, 1 Day.
    Customer
        :ref:`Customer <contractors>` that is related to the calls that will be used for selecting CDRs for this *Termination Distribution report*. Choose "Any" for selecting calls from all Customers.

----

Origination performance
~~~~~~~~~~~~~~~~~~~~~~~

Origination performance report is used for monitoring originated calls (from the whole system or from the separate customer) during the short period of time (less than 1 Day). Only authorized calls are taken into account during creating this *Origination performance* report.

**Origination performance**'s attributes:
`````````````````````````````````````````
    Time Interval
        Period of time for selecting CDRs that will be used for creating this *Origination performance* report. Following intervals are available: 1 minute, 5 minutes, 10 minutes, 15 minutes, 1 hour, 3 hours, 1 Day.
    Customer
        :ref:`Customer <contractors>` that is related to the calls that will be used for selecting CDRs for this *Origination performance*. Choose "Any" for selecting calls from all Customers.

----

Bad routing
~~~~~~~~~~~

Bad routing report is used for monitoring failed attempts of the call's routing  (from the whole system or from the separate customer) during the short period of time (less than 1 Day).


**Bad routing**'s attributes:
`````````````````````````````
    Id
       Unique Bad routing's id.
    Time Interval
       Period of time for selecting CDRs that will be used for creating this *Bad routing* report. Following intervals are available: 1 minute, 5 minutes, 10 minutes, 15 minutes, 1 hour, 3 hours, 1 Day.
    Customer
       :ref:`Customer <contractors>` that is related to the calls (bad routing attempts) that will be used for selecting CDRs for this *Bad routing* report. Choose "Any" for selecting calls from all Customers.
    Rateplan
       :ref:`Rateplan <rateplans>` that was applied to the calls (bad routing attempts) that will be used for selecting CDRs for this *Bad routing* report. Choose "Any" for selecting calls for all Ratepalns.
    Routing Plan
       :ref:`Routing plan <routing_plan>` that was applied to the calls (bad routing attempts) that will be used for selecting CDRs for this *Bad routing* report. Choose "Any" for selecting calls for all Routing plans.
    Internal Disconnect Code
       Internal :ref:`Disconnect code <disconnect_codes>` of termination the calls (bad routing attempts) that will be used for selecting CDRs for this *Bad routing* report. It is possible to use statement for this field (equals, greater than, less than).
    Internal Disconnect Reason
       Internal Disconnect Reason of termination the calls (bad routing attempts) that will be used for selecting CDRs for this *Bad routing* report. It is possible to use statement for this field (contains, equals, starts with, ends with).

----

Not authenticated attempts
~~~~~~~~~~~~~~~~~~~~~~~~~~

Not authenticated attempts report is used for monitoring failed authentication attempts (from the whole system) during the short period of time (less than 1 Day).


**Not authenticated attempt**'s attributes:
```````````````````````````````````````````
    Time Interval
        Period of time for selecting CDRs that will be used for creating this *Not authenticated attempts* report. Following intervals are available: 1 minute, 5 minutes, 10 minutes, 15 minutes, 1 hour, 3 hours, 1 Day.
