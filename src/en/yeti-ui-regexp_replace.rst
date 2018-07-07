
.. _posix_regular_expressions2:

==================================
Using of POSIX Regular Expressions
==================================

`POSIX Regular Expressions <https://www.postgresql.org/docs/9.4/static/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_ used in many places of Yeti's configurations for changing format of phone numbers. It helps to provide compatibility between different VoIP platforms. This section describes general principles and examples of using POSIX Regular Expressions in Yeti.

Arguments
~~~~~~~~~


Yeti uses `REGEXP_REPLACE <http://www.postgresqltutorial.com/regexp_replace/>`_ function:

    .. note:: REGEXP_REPLACE(phonenumber, rewrite_rule, rewrite_result)


 with following arguments:


1) **phonenumber**

It is a phone number (source or destination) that replacement should be taken place.

2) **rewrite_rule**

It is a POSIX regular expression for matching substrings that should be replaced.

3) **rewrite_result**

It is a string that to replace the substrings which match the *rewrite_rule*.


The REGEXP_REPLACE() function returns a new phonenumber with the elements, which match a regular expression pattern, replaced by a new substring.


Examples
~~~~~~~~

1)  How to add one or more digits to the beginning of the phonenumber

    For adding one or more digits to the beginning of the phonenumber you should use following arguments:

        **rewrite_rule** = ^(.*)$

        **rewrite_result** = XXX\\1

    where ^ - matches at the beginning of the phonenumber, $ - matches at the end of the phonenumber, (.*) - regular expression matches a sequence of 0 or more characters, XXX - digits for adding to the beginning of the phonenumber, \\1 - first marked subexpression matched (in our case - it is phone number (source or destination) that replacement should be taken place). Some examples of adding digits to the beginning of the phonenumber with using different arguments are provided below:

       a) **original phone number** = 7335255 ;  **rewrite_rule** = ^(.*)$ ; **rewrite_result** = 0\\1 ; **resulting phone number**  = 07335255
       b) **original phone number** = 2296132 ;  **rewrite_rule** = ^(.*)$ ; **rewrite_result** = 066\\1 ; **resulting phone number**  = 0662296132
       c) **original phone number** = 7050460 ;  **rewrite_rule** = ^(.*)$ ; **rewrite_result** = 38048\\1 ; **resulting phone number**  = 380487050460

2)  How to remove one or more digits or symbols from the beginning of the phonenumber

    For removing one or more digits or symbols from the beginning of the phonenumber you should use following arguments:

        **rewrite_rule** = ^XXX(.*)$

        **rewrite_result** = \\1

    where ^ - matches at the beginning of the phonenumber, $ - matches at the end of the phonenumber, (.*) - regular expression matches a sequence of 0 or more characters, XXX - digits or symbols for removing from the beginning of the phonenumber, \\1 - first marked subexpression matched (in our case - it is phone number that is following after **XXX**). Some examples of removing digits from the beginning of the phonenumber with using different arguments are provided below:

       a) **original phone number** = 07335255 ;  **rewrite_rule** = ^0(.*)$ ; **rewrite_result** = \\1 ; **resulting phone number**  = 7335255
       b) **original phone number** = 0662296132 ;  **rewrite_rule** = ^066(.*)$ ; **rewrite_result** = \\1 ; **resulting phone number**  = 2296132
       c) **original phone number** = 380487050460 ;  **rewrite_rule** = ^38048(.*)$ ; **rewrite_result** = \\1 ; **resulting phone number**  = 7050460


3)  How to replace digits or symbols withing the phonenumber

    For replacing one or more digits or symbols withing the phonenumber you should use following arguments:

        **rewrite_rule** = ^(.*)XXX(.*)$

        **rewrite_result** = \\1YYY\\2

    where ^ - matches at the beginning of the phonenumber, $ - matches at the end of the phonenumber, (.*) - regular expression matches a sequence of 0 or more characters, XXX - digits or symbols for removing from the phonenumber,  YYY - digits or symbols for adding to the phonenumber on place of XXX,  \\1 - first marked subexpression matched (in our case - part of phone number (if any) before XXX), \\2 - second marked subexpression matched (in our case - part of phone number (if any) after XXX). Some examples of replacing one or more digits or symbols withing the phonenumber with using different arguments are provided below:

       a) **original phone number** = 7335255 ;  **rewrite_rule** = ^(.*)733(.*)$ ; **rewrite_result** = \\1000\\2 ; **resulting phone number**  = 0005255
       b) **original phone number** = 0662296132 ;  **rewrite_rule** = ^(.*)229(.*)$ ; **rewrite_result** = \\1999\\2 ; **resulting phone number**  = 0669996132
       c) **original phone number** = 380487050460 ;  **rewrite_rule** = ^(.*)460(.*)$ ; **rewrite_result** = \\1464\\2 ; **resulting phone number**  = 380487050464


4)  How to add random digits to the end of phonenumber

    For adding one or more random digits to the end of phonenumber you should use following arguments:

        **rewrite_rule** = ^(.*)$

        **rewrite_result** = \\1r(NN)

    where ^ - matches at the beginning of the phonenumber, $ - matches at the end of the phonenumber, (.*) - regular expression matches a sequence of 0 or more characters, r(NN) - placeholder that will be replaced to the string (random numeric characters from 0 to 9) with NN  length (NN should be within the range from 0 to 64), \\1 - first marked subexpression matched (in our case - it is phone number (source or destination) that replacement should be taken place). Some examples of adding one or more random digits to the end of the phonenumber with using different arguments are provided below:

       a) **original phone number** = 7335255 ;  **rewrite_rule** = ^(.*)$ ; **rewrite_result** = \\1#r(3) ; **resulting phone number**  = 7335255#456
       b) **original phone number** = 2296132 ;  **rewrite_rule** = ^(.*)$ ; **rewrite_result** = \\1##r(1) ; **resulting phone number**  = 2296132##5
       c) **original phone number** = 7050460 ;  **rewrite_rule** = ^(.*)$ ; **rewrite_result** = \\1-r(5) ; **resulting phone number**  = 7050460-53467


