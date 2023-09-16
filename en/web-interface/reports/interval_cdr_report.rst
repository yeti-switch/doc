
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


