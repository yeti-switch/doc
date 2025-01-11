
.. _posix_regular_expressions2:

.. |br| raw:: html

   <br />

====================
Numbers translations
====================

Yeti has flexible configuration of numbers modifications - it allows to change source and destination numbers on different call processing stages:

#. Before routing, immediately after call authorization at :ref:`Customers Auth <customers_auth_number_translation>`.
#. Before routing, during :ref:`Numberlist <numberlists_rewrite_rules>` processing.
#. After routing in :ref:`Dialpeer <dialpeer_number_translation_settings>`.
#. After routing at termination :ref:`Gateway <gateways_number_translation>`.

In most cases numbers translations implemented using `POSIX Regular Expressions <https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. This section describes general principles and examples of using POSIX Regular Expressions in Yeti. 

Yeti uses PostgreSQL `REGEXP_REPLACE(phonenumber, rewrite_rule, rewrite_result) <https://www.postgresql.org/docs/current/functions-matching.html>`_ function with following arguments:

phonenumber
    It is a phone number (source or destination) that replacement should be taken place.

rewrite_rule
    It is a POSIX regular expression for matching sub-strings that should be replaced.

rewrite_result
    It is a string that to replace the sub-strings which match the *rewrite_rule*.


The REGEXP_REPLACE() function returns a new phonenumber with the elements, which match a regular expression pattern, replaced by a new sub-string.


Examples
========

How to add prefix 888 to number
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    **rewrite_rule** = ^(.*)$
    |br|
    **rewrite_result** = 888\\1

    where ^ - matches at the beginning of the phonenumber, $ - matches at the end of the phonenumber, (.*) - regular expression matches a sequence of 0 or more characters, 888 - prefix to add, \\1 - first marked sub-expression matched (in our case - it is phone number (source or destination) that replacement should be taken place). Some examples of adding digits to the beginning of the phonenumber with using different arguments are provided below:

       a) **original phone number** = 7335255 ;  **rewrite_rule** = ^(.*)$ ; **rewrite_result** = 0\\1 ; **resulting phone number**  = 07335255
       b) **original phone number** = 2296132 ;  **rewrite_rule** = ^(.*)$ ; **rewrite_result** = 066\\1 ; **resulting phone number**  = 0662296132
       c) **original phone number** = 7050460 ;  **rewrite_rule** = ^(.*)$ ; **rewrite_result** = 38048\\1 ; **resulting phone number**  = 380487050460
       

How to remove prefix 999# from number
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    **rewrite_rule** = ^999#(.*)$
    |br|
    **rewrite_result** = \\1
    
    
How to add suffix 1235 to number
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    **rewrite_rule** = ^(.*)$
    |br|
    **rewrite_result** = \\11235
    
    
How to replace prefix 123# with prefix 321#
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    **rewrite_rule** = ^123#(.*)$
    |br|
    **rewrite_result** = 321#\\1


How to add 8 random digits to the end of phonenumber
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    to generate random digits **r(N)** function may be used:

    **rewrite_rule** = ^(.*)$
    |br|
    **rewrite_result** = \\1r(8)
        
How to replace 4 last digits to random values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    **rewrite_rule** = ^(.*)(\\d{4})$
    |br|
    **rewrite_result** = \\1r(4)


