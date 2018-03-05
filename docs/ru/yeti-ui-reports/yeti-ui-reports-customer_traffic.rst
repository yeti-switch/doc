
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


