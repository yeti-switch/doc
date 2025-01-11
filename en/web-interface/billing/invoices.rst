
.. _invoices:

Invoices
~~~~~~~~

Invoice provides possibility to summarize billing information for mutual settlements with customers and vendors.

**Invoice**'s attributes:
`````````````````````````
    Id
        Unique invoice id.
    Contractor
        :ref:`Contractor <contractors>` that is related to this invoice.
    Account
        :ref:`Account <accounts>` that is related to this invoice.
    State
        Status of the invoice. New invoices are created with status *Pending*.
        After changing status of invoice to *Approve*, it is considered confirmed and is sent to the contractor's email (configured in account settings).
        If account has invoice template, system also will generate PDF document.
    Start date
        Date and time of beginning of the billing period in the invoice.
    End date
        Date and time of ending of the billing period in the invoice.
    Amount
        Total amount of invoice in the monetary units.
    Calls count
        Count of calls that are billed in the invoice.
    Successful calls count
        Count of successful calls that are billed in the invoice.
    Calls duration
        Duration (in seconds) of successful calls that are billed in the invoice. Calculated as **sum(duration)** from CDRs.

.. _invoice_billing_duration:


    Billing duration
	Billed calls duration calculated based on call duration and billing intervals(initial and next interval length). Calculated as sum(customer_duration) from CDRs.
    Type
        Generation of the invoice can be performed manually or automatically, if invoices auto-generation period for account was chosen.
        Three types of invoices are available: Auto, Auto partial and Manual.
    Direction
        The invoice can have on the two possible directions: Vendor or Customer.
    Created at
        Date and time of the invoice creation.
    First call at
        Date and time of of the first call from all calls that are billed in the invoice.
    Last call at
        Date and time of of the last call from all calls that are billed in the invoice.
    First successful call at
        Date and time of of the first successful call from all calls that are billed in the invoice.
    Last successful call at
        Date and time of of the last successful call from all calls that are billed in the invoice.
            
