
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


