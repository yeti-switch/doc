
.. _numberlists:

Numberlists
~~~~~~~~~~~

Numberlist is configuration object that allow to configure actions depends on Source or Destination number. Depends on configuration numberlist may act as blocklist and allowlist of phone numbers.

Numberlist object contains one or multiple :ref:`Numberlist items <numberlist_items>` to describe behavior for specific number.


**Numberlist**'s attributes
```````````````````````````
    Id
        Unique Numberlist's id.
    Name
        Unique Numberlist's name.

.. _numberlists_mode:

    Mode
        Mode defines :ref:`Numberlist item <numberlist_items>` key lookup logic.
        
        **Strict number match** - In this mode :ref:`Key <numberlist_items_key>` field of :ref:`Numberlist item <numberlist_items>` should contain full source (A) or destination (B) number of the call.

        **Prefix match** - In this mode :ref:`Key <numberlist_items_key>` field of :ref:`Numberlist item <numberlist_items>` should contain Prefix. Only in case of matching *Prefix* with first symbols of the source (A) or destination (B) number - according  action will be applied to the call.
        
        **Random** - Numberlist Item will be randomly selected. In this mode Numberlist Item always will be matched(if there are at least one Item in this Numberlist)

.. _numberlists_action:

    Default action
        Default action will be applied in case when Numberlist Item was not found.

        **Reject call** - Reject call in case of :ref:`Numberlist item <numberlist_items>` is not found

        **Allow call** - Allow call in case of :ref:`Numberlist item <numberlist_items>` is not found

.. _numberlists_rewrite_rules:

    Default src rewrite rule
        *Pattern* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used source number (number A), as a *Replacement* parameter of **regexp_replace** function is used value from *Default src rewrite result* bellow. Returned value of **regexp_replace** function will be used as source number (number A) for the call during future routing. It helps to change format of the source number for providing compatibility. This field is used only in case of missing specific :ref:`Numberlist item <numberlist_items>` for the call in the framework of this *Numberlist*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Default src rewrite result
        *Replacement* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used source number (number A), as a *Pattern* parameter of **regexp_replace** function is used value from *Default src rewrite rule* above. Returned value of **regexp_replace** function will be used as source number (number A) for the call during future routing. It helps to change format of the source number for providing compatibility. This field is used only in case of missing specific :ref:`Numberlist item <numberlist_items>` for the call in the framework of this *Numberlist*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Default dst rewrite rule
        *Pattern* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B), as a *Replacement* parameter of **regexp_replace** function is used value from *Default dst rewrite result* bellow. Returned value of **regexp_replace** function will be used as destination number (number B) for the call during future routing. It helps to change format of the destination number for providing compatibility. This field is used only in case of missing specific :ref:`Numberlist item <numberlist_items>` for the call in the framework of this *Numberlist*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Default dst rewrite result
        *Replacement* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B), as a *Pattern* parameter of **regexp_replace** function is used value from *Default dst rewrite rule* above. Returned value of **regexp_replace** function will be used as destination number (number B) for the call during future routing. It helps to change format of the destination number for providing compatibility. This field is used only in case of missing specific :ref:`Numberlist item <numberlist_items>` for the call in the framework of this *Numberlist*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
        
.. _numberlists_routing_tags_options:

    Tag action
        Describes one of the possible actions that could be applied to the current set of :ref:`Routing Tags <routing_tag>` that are applied for the call with using *Tag action value* below. *Numberlist* it is second step (after *Authentication*) where :ref:`Routing Tags <routing_tag>` can be added to (or removed from) the call. Destination *Numberlist* is processed before the Source *Numberlist*. This field and field bellow are used only in case of missing specific :ref:`Numberlist item <numberlist_items>` for the call in the framework of this *Numberlist*. Following actions can be selected in this field:

            -   **Clear tags**. Removes all :ref:`Routing Tags <routing_tag>` from the call (if any were added early);

            -   **Remove selected tags**. Removes only :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) from the call;

            -   **Append selected tags**. Appends :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) to the call;

            -   **Intersection with selected tags**. Yeti leaves as is :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) in the call in case of their presence in the current set of :ref:`Routing Tags <routing_tag>` and removes any other :ref:`Routing Tags <routing_tag>` from the call.

    Tag action value
        In this field :ref:`Routing Tags <routing_tag>` for making some *Tag action* above could be chosen.

    Created At
        Date and time of this Numberlist creation.
    Updated At
        Date and time of last updating of this Numberlist.
        
        
**Numberlist**' Usage
`````````````````````

Numberlist may be used in Customer Auth object as SRC or DST Numberlist. In this case it will be used before call routing(during Customer auth processing).

    * For SRC numberlist system will try to find Numberlist Item by key, comparing it with SRC number.
    * For DST numberlist system will try to find Numberlist Item by key, comparing it with DST number.

    
Numberlist may be used in Routing Plan as SRC or DST Numberlist. Routing plan Numberlist processing processed on next step after Customer Auth Numberlist. Usual use case for Routing Plan Numberlist is global call blocking to/from some numbers.


Numberlist may be used in termination gateways. In this mode it is possible to skip termination gw during routing process depends on numberlist item matching results.


