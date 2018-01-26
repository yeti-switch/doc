=======
Billing
=======

YETI WEB interface - Billing menu description. This section describes billing and accounting entities.


Contractors
~~~~~~~~~~~

Contractor is a company which will interact with the system.

Contractor may act as **Customer** - Use provided call termination service and **Vendor** - Provide call termination service. Same contractor can be either customer and vendor.

**Contractor** has the following attributes:
````````````````````````````````````````````

    .. _contractor_id:

    Id
        Unique contractor id.

    .. _contractor_name:

    Name
        Unique contractor name.
    Enabled
        Self-descriptive.
        If flag is off (contractor disabled) this contractor will not be used for routing and billing.
    Vendor
        If enabled contractor can act as vendor and system may terminate calls to it.
    Customer
        If enabled contractor can act as customer and originate calls to the system.
    Description
        Optional description of the contractor.
    Address
        Optional contractor address.
    Phones
        List of phone numbers to contact with contractor.
    Smtp Connection
        Connection to the mail server which will be used to send mails, invoices and notifications
        (SMTP connection must be configured previously in *System->SMTP connections*)

.. note:: Fields **Description**, **Address**, **Phones** are informational and not used in routing or billing logic.

----

.. _contacts:

Contacts
~~~~~~~~

Contact:
    Address information about contractor or system operator (contact belongs to the contractor or to the system operator).
    All email notification and reports use only addresses which were added to the contacts.

**Contact** has the following attributes:
`````````````````````````````````````````
    Id
        Unique contract id.
    Contractor
        Choose Contractors if this contact belongs to them.
    Admin user
        Administrative user which may own contact.
        Contractors names or admin user name must be entered.
    E-mail
        Address for notifications, invoices and other emails.
    Notes
        Optional notes.

----

Accounts
~~~~~~~~

Initial balance for newly created account is always zero.
Balance can be changed as result of calls billing or new payments.

For each call:
account balance will be **decreased** on call cost if it uses account for **origination** (customer)
and **increased** if it uses account for **termination** (vendor).


**Account**'s attributes:
`````````````````````````

    .. _account_id:

    Id
        Unique account id.

    .. _account_name:

    Name
        Unique account name.
    Contractor
        Contractor who own this account.
    Balance
        Current account balance.
    Min balance
        If account balance become less than this limit, then traffic for this account will be blocked.
    Max balance
        If account balance become greater than this limit, then routes, which are belongs to this account, will not be used for calls termination.
    Balance low threshold
        If account balance become less than this limit, notification will be send by email.
    Balance high threshold    
        If account balance become greater than this limit, notification will be send by email.
    Origination capacity
        Maximum capacity which can be originated for this account.
        If incoming calls number exceed origination capacity, then traffic will be blocked.
    Termination capacity
        Maximum capacity which can be terminated for this account.
        If outgoing calls number exceed origination capacity, then routes, which are belongs to this account, will not be used for new calls.
    Vendor invoice period
        Automatic invoices generation period in case when account acts as vendor.
    Customer invoice period
        Automatic invoices generation period in case when account acts as customer.
    Vendor invoice template
        Template for generation of PDF invoices for vendor.
        (Templates can be configured at *Billing->Invoice templates*)
    Customer invoice template
        Template for generation of PDF invoices for customer.
        (Templates can be configured at *Billing->Invoice templates*)
    Sent invoices to
        Contacts list to send invoices that were generated.
    Timezone
        Timezone which will be used for invoices generation and statistics for this account.

----

Payments
~~~~~~~~

Payments intended to change account balance.

**Payment**'s attributes:
`````````````````````````
    Id
        Unique payment id.
    Amount
        Amount of payment in the monetary units.
    Notes            
        Additional information about payment transactions.
    Created at
        Date and time of the payment creation.

----


Invoices
~~~~~~~~

Invoice provides possibility to summarize billing information for mutual settlements with customers and vendors.

**Invoice**'s attributes:
`````````````````````````
    Id
        Unique invoice id.
    Contractor
        Contractor that is related to this invoice.
    Account
        Account that is related to this invoice.
    State
        Status of the invoice. New invoices are created with status *Pending*.
        After changing status of invoice to *Approve*, it is considered confirmed and is sent to the contragent's email (configured in account settings).
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
        Duration (in seconds) of successful calls that are billed in the invoice.
    Type
        Generation of the invoice can be performed manually or automatically, if invoices autogeneration period for account was choosen.
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
            
Invoice Templates
~~~~~~~~~~~~~~~~~

PDF document templates which will be used to generate invoice.
Template - it is the file in .odt format with special placeholders.
Placeholders will be replaced with actual data during PDF document generation.
System can store many different templates and you can choose desired template for each account independently.

**Invoice Template**'s attributes:
``````````````````````````````````
    Id
        Unique invoice temlpate id.
    Name
        Unique invoice template name.
    Filename 
        Name of file in .odt format with invoice template.
    Sha1
        Result of calculation of Secure Hash Algorithm 1 (SHA1) for the file with invoice template.
    Created at
        Date and time of the invoice template creation.

.. note:: Currently following placeholders are supported in the invoice templates:

   -    [ACC_NAME]	Account name

   -    [ACC_BALANCE]	Account balance

   -    [ACC_BALANCE_DECORATED]	Account balance rounded

   -    [ACC_MIN_BALANCE]	Account minimal balance threshold
   -    [ACC_MIN_BALANCE_DECORATED]	Account minimal balance threshold rounded
   -    [ACC_MAX_BALANCE]	Account minimal balance threshold
   -    [ACC_MAX_BALANCE_DECORATED]	Account minimal balance threshold rounded
   -    [ACC_INV_PERIOD]	Account invoice period
   -    [CONTRACTOR_NAME]	Contractor name
   -    [CONTRACTOR_ADDRESS]	Contractor address
   -    [CONTRACTOR_PHONES]	Contractor phones
   -    [INV_ID]	ID of generated invoice
   -    [INV_CREATED_AT]	Date and time of the invoice creation
   -    [INV_START_DATE]	Begin of the invoice period
   -    [INV_END_DATE]	End of invoice period
   -    [INV_AMOUNT]	Invoice total amount
   -    [INV_AMOUNT_DECORATED]	Invoice total amount in human format
   -    [INV_CALLS_COUNT]	Total count of calls that are billed in the invoice
   -    [INV_SUCCESSFUL_CALLS_COUNT]	Count of successful calls that are billed in the invoice
   -    [INV_CALLS_DURATIONM]	Duration of successful calls that are billed in the invoice (format MINUTES:SECONDS, f.e. 5:30 = 5 minutes and 30 seconds)
   -    [INV_CALLS_DURATION_DEC]	Duration of successful calls (in minutes) that are billed in the invoice (format MINUTES.PART_OF_MINUTES, f.e. 5.5 = 5 minutes and 30 seconds)
   -    [INV_CALLS_DURATION]	Duration (in seconds) of successful calls that are billed in the invoice
   -    [INV_FIRST_CALL_AT]	Date and time of of the first call from all calls that are billed in the invoice
   -    [INV_FIRST_SUCCESSFUL_CALL_AT]	Date and time of of the first successful call from all calls that are billed in the invoice
   -    [INV_LAST_CALL_AT]	Date and time of of the last call from all calls that are billed in the invoice
   -    [INV_LAST_SUCCESSFUL_CALL_AT]	Date and time of of the last successful call from all calls that are billed in the invoice

