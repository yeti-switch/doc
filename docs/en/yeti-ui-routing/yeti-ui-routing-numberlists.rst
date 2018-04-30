
.. _numberlists:

Numberlists
~~~~~~~~~~~

Numberlists are used for describing common parameters that can be applied for set of :ref:`Numberlist items <numberlist_items>`.


**Numberlist**'s attributes:
````````````````````````````
    Id
        Unique Numberlist's id.
    Name
        Unique Numberlist's name.

.. _numberlists_mode:

    Mode
        Mode of comparison :ref:`Key <numberlist_items_key>` field of :ref:`Numberlist item <numberlist_items>` and with source (A) or destination (B) number of the call:

        **Strict number match** - In this mode :ref:`Key <numberlist_items_key>` field of :ref:`Numberlist item <numberlist_items>` should contain full source (A) or destination (B) number of the call.

        **Prefix match**    - In this mode :ref:`Key <numberlist_items_key>` field of :ref:`Numberlist item <numberlist_items>` should contain Prefix. Only in case of matching *Prefix* with first symbols of the source (A) or destination (B) number - according  action will be applied to the call.

.. _numberlists_action:

    Default action
        This action will be applied to the call by default in case of conformity source (A) or destination (B) number and the :ref:`Key <numberlist_items_key>` field (according to the Mode that was chosen above) of :ref:`Numberlist item <numberlist_items>` that is associated with this *Numberlist*. You can rewrite this action for concrete :ref:`Numberlist item <numberlist_items>` by specifying action in the :ref:`Numberlist item <numberlist_items>` attributes:

        **Reject call** -   Reject call in case of conformity source (A) or destination (B) number and the :ref:`Key <numberlist_items_key>` field (according to the Mode that was chosen above) of :ref:`Numberlist item <numberlist_items>` that is associated with this *Numberlist*.

        **Allow call** -  Allow call in case of conformity source (A) or destination (B) number and the :ref:`Key <numberlist_items_key>` field (according to the Mode that was chosen above) of :ref:`Numberlist item <numberlist_items>` that is associated with this *Numberlist*.

.. _numberlists_rewrite_rules:

    Default src rewrite rule
        *Pattern* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/9.4/static/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used source number (number A), as a *Replacement* parameter of **regexp_replace** function is used value from *Default src rewrite result* bellow. Returned value of **regexp_replace** function will be used as source number (number A) for the call during future routing. It helps to change format of the source number for providing compatibility. This field is used only in case of missing specific :ref:`Numberlist item <numberlist_items>` for the call in the framework of this *Numberlist*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Default src rewrite result
        *Replacement* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/9.4/static/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used source number (number A), as a *Pattern* parameter of **regexp_replace** function is used value from *Default src rewrite rule* above. Returned value of **regexp_replace** function will be used as source number (number A) for the call during future routing. It helps to change format of the source number for providing compatibility. This field is used only in case of missing specific :ref:`Numberlist item <numberlist_items>` for the call in the framework of this *Numberlist*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Default dst rewrite rule
        *Pattern* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/9.4/static/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B), as a *Replacement* parameter of **regexp_replace** function is used value from *Default dst rewrite result* bellow. Returned value of **regexp_replace** function will be used as destination number (number B) for the call during future routing. It helps to change format of the destination number for providing compatibility. This field is used only in case of missing specific :ref:`Numberlist item <numberlist_items>` for the call in the framework of this *Numberlist*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Default dst rewrite result
        *Replacement* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/9.4/static/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B), as a *Pattern* parameter of **regexp_replace** function is used value from *Default dst rewrite rule* above. Returned value of **regexp_replace** function will be used as destination number (number B) for the call during future routing. It helps to change format of the destination number for providing compatibility. This field is used only in case of missing specific :ref:`Numberlist item <numberlist_items>` for the call in the framework of this *Numberlist*.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

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


