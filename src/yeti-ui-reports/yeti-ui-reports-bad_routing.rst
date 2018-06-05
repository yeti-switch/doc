
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


