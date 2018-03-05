
.. _routing_plan_lnp_rules:

Routing Plan LNP rules
~~~~~~~~~~~~~~~~~~~~~~

Routing Plan LNP (Local number portability) rules are used for processing ported numbers of calls in case of enabling *Use Lnp* flag of :ref:`Routing plan <routing_plan>`.

**Routing Plan LNP rule**'s attributes:
```````````````````````````````````````
    Id
       Unique Routing Plan LNP rule's id.
    Routing plan
        :ref:`Routing plan <routing_plan>` for that will be applied this Routing plan LNP rule.
    Dst prefix
        This field is used for setting prefix for filtering calls by destination number (number B) for using this *Routing Plan LNP rule*.
    Req dst rewrite rule
        *Pattern* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/9.4/static/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B), as a *Replacement* parameter of **regexp_replace** function is used value from *Req dst rewrite result* bellow. Returned value of **regexp_replace** function will be used for sending to :ref:`LNP Database <lnp_databases>`. It helps to change format of the destination number in the request to the :ref:`LNP Database <lnp_databases>` for providing compatibility.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Req dst rewrite result
        *Replacement* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/9.4/static/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B), as a *Pattern* parameter of **regexp_replace** function is used value from *Req dst rewrite rule* above. Returned value of **regexp_replace** function will be used for sending to :ref:`LNP Database <lnp_databases>`. It helps to change format of the destination number in the request to the :ref:`LNP Database <lnp_databases>` for providing compatibility.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Database
        :ref:`LNP Database <lnp_databases>` that will be used for processing LNP requests for selected calls.
    Lrn rewrite rule
        *Pattern* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/9.4/static/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B) that was received as answer from :ref:`LNP Database <lnp_databases>`, as a *Replacement* parameter of **regexp_replace** function is used value from *Lrn rewrite result* bellow. Returned value of **regexp_replace** function will be used for rewriting of original destination number before sending it to Termination Gateway. It helps to change format of the destination number that was received as answer from :ref:`LNP Database <lnp_databases>` for providing compatibility.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Lrn rewrite result
        *Replacement* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/9.4/static/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B) that was received as answer from :ref:`LNP Database <lnp_databases>`, as a *Pattern* parameter of **regexp_replace** function is used value from *Lrn rewrite rule* above. Returned value of **regexp_replace** function will be used for rewriting of original destination number before sending it to Termination Gateway. It helps to change format of the destination number that was received as answer from :ref:`LNP Database <lnp_databases>` for providing compatibility.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.


