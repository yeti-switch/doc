
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


