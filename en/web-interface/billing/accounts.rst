
.. _accounts:

Accounts
~~~~~~~~

Accounts are used for describing separate billing account of some :ref:`Contractor <contractors>`. :ref:`Contractor <contractors>` could have more than one *Account*. It is necessary to configure :ref:`Contractor <contractors>` before creating *Account*.
Initial balance for newly created account is always zero.
Balance can be changed as result of calls billing or new :ref:`payments <payments>`.

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
        :ref:`Contractor <contractors>` that is related to this *Account*.

    .. _account_balance:

    Balance
        Current account balance.

    .. _account_min_balance:

    Min balance
        If account balance become less than this limit, then traffic for this account will be blocked.

    .. _account_max_balance:

    Max balance
        If account balance become greater than this limit, then routes, which are belongs to this account, will not be used for calls termination.

    .. _account_balance_low_threshold:

    Balance low threshold
        If account balance become less than this limit, notification will be send by email.

    .. _account_balance_high_threshold:

    Balance high threshold    
        If account balance become greater than this limit, notification will be send by email.
    Origination capacity
        Maximum capacity which can be originated for this account.
        If incoming calls number exceed origination capacity, then traffic will be blocked.
    Termination capacity
        Maximum capacity which can be terminated for this account.
        If outgoing calls number exceed origination capacity, then routes, which are belongs to this account, will not be used for new calls.
    Total capacity
        Shared capacity either for incoming or outgoing calls, i.e. summarized traffic in both directions (but not in particular one) is limited by this number (see the picture below).

    .. figure:: images/accounts_capacity.png
       :scale: 100 %
       :align: center
       :alt: YETI Account capacity
     
    Invoice period
        Automatic invoices generation period.
    Invoice template
        Template for generation of PDF invoice documents. (Templates can be configured at *Billing->Invoice templates*)
    Sent invoices to
        Contacts list to send invoices that were generated.
    Timezone
        Timezone which will be used for invoices generation and statistics for this account.


