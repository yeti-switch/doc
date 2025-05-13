
CDR Writer Configuration
~~~~~~~~~~~~~~~~~~~~~~~~

The page contains settings related to CDR writing logic.


Call duration round mode
    Yeti store call duration as integer amount of seconds, real call duration may be not exact integer value, so rounding procedure required. Following modes are available:

    Always Up:
        - duration 1.41 seconds will be rounded to 2 seconds
        - duration 1.5 seconds will be rounded to 2 seconds
        - duration 1.6 seconds will be rounded to 2 seconds

    Always Down:
        - duration 1.41 seconds will be rounded to 1 seconds
        - duration 1.5 seconds will be rounded to 1 seconds
        - duration 1.6 seconds will be rounded to 1 seconds

    Math rules
        - duration 1.41 seconds will be rounded to 1 seconds
        - duration 1.5 seconds will be rounded to 2 seconds
        - duration 1.6 seconds will be rounded to 2 seconds


After call duration rounding Yeti perform customer and vendor price calculations. Customer and vendor prices may be also rounded.

Customer price round mode
    Round mode of :ref:`Customer's price <customer_price_calc_rules>`. Following values are available:

        - Disable rounding
        - Always UP
        - Always DOWN
        - Math rules (up if >= 0.5).

Customer amount round precision
    Level of precision for the :ref:`Customer's price <customer_price_calc_rules>`. Number of digits after point (in the floating point numbers) for rounding.

Vendor price round mode
    Round mode of :ref:`Vendors's price <vendor_price_calc_rules>`. Following values are available:

        - Disable rounding
        - Always UP
        - Always DOWN
        - Math rules (up if >= 0.5).

Vendor amount round precision
    Level of precision for the :ref:`Vendors's price <vendor_price_calc_rules>`. Number of digits after point (in the floating point numbers) for rounding.

Disable Realtime Statistics
    This settings allow to disable calculation of statistics during CDR writing.
