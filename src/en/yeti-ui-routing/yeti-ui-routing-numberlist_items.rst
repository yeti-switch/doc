
.. _numberlist_items:

Numberlist items
~~~~~~~~~~~~~~~~

Numberlist items allow to do something with source or destination number or reject call in general before its routing and after rewriting on the level of :ref:`Customer Auth <customer_auth>`.

**Numberlist item**'s attributes:
`````````````````````````````````
    Id
        Unique Numberlist item's id.
    Numberlist
        :ref:`Numberlist <numberlists>` that is associated with this *Numberlist item*.

.. _numberlist_items_key:

    Key
        Full number or Prefix. Interpretation of this field depends on Mode of comparison that was chosen in the :ref:`Numberlist <numberlists>`.
    Action
        This action will be applied to the call in case of conformity source (A) or destination (B) number and the Key field (according to the Mode that was chosen in the :ref:`Numberlist <numberlists>`):

        **Default action**  - Action that is set for the :ref:`Numberlist <numberlists>`) will be used.

        **Reject call** - Reject call in case of conformity source (A) or destination (B) number and the Key field (according to the Mode that was chosen  in the :ref:`Numberlist <numberlists>`).  Action from the :ref:`Numberlist <numberlists>`) will be ignored in case of choosing this action.

        **Allow call** - Allow call in case of conformity source (A) or destination (B) number and the Key field (according to the Mode that was chosen  in the :ref:`Numberlist <numberlists>`). Action from the :ref:`Numberlist <numberlists>`) will be ignored in case of choosing this action.

.. _numberlist_items_rewrite_rules:

    Src rewrite rule
        *Pattern* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used source number (number A), as a *Replacement* parameter of **regexp_replace** function is used value from *Src rewrite result* bellow. Returned value of **regexp_replace** function will be used as source number (number A) for the call during future routing. It helps to change format of the source number for providing compatibility.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Src rewrite result
        *Replacement* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used source number (number A), as a *Pattern* parameter of **regexp_replace** function is used value from *Src rewrite rule* above. Returned value of **regexp_replace** function will be used as source number (number A) for the call during future routing. It helps to change format of the source number for providing compatibility.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst rewrite rule
        *Pattern* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B), as a *Replacement* parameter of **regexp_replace** function is used value from *Dst rewrite result* bellow. Returned value of **regexp_replace** function will be used as destination number (number B) for the call during future routing. It helps to change format of the destination number for providing compatibility.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.
    Dst rewrite result
        *Replacement* parameter of **regexp_replace** function from the `POSIX Regular Expressions <https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP>`_. As *Source* parameter of **regexp_replace** function is used destination number (number B), as a *Pattern* parameter of **regexp_replace** function is used value from *Dst rewrite rule* above. Returned value of **regexp_replace** function will be used as destination number (number B) for the call during future routing. It helps to change format of the destination number for providing compatibility.
        See :ref:`how to use POSIX Regular Expressions in Yeti <posix_regular_expressions2>`.

    Tag action
        Describes one of the possible actions that could be applied to the current set of :ref:`Routing Tags <routing_tag>` that are applied for the call with using *Tag action value* below. *Numberlist* it is second step (after *Authentication*) where :ref:`Routing Tags <routing_tag>` can be added to (or removed from) the call. Destination *Numberlist* is processed before the Source *Numberlist*. Following actions can be selected in this field:

            -   **Clear tags**. Removes all :ref:`Routing Tags <routing_tag>` from the call (if any were added early);

            -   **Remove selected tags**. Removes only :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) from the call;

            -   **Append selected tags**. Appends :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) to the call;

            -   **Intersection with selected tags**. Yeti leaves as is :ref:`Routing Tags <routing_tag>` that were chosen in the *Tag action value* field bellow (if any were chosen) in the call in case of their presence in the current set of :ref:`Routing Tags <routing_tag>` and removes any other :ref:`Routing Tags <routing_tag>` from the call.

    Tag action value
        In this field :ref:`Routing Tags <routing_tag>` for making some *Tag action* above could be chosen.

    Created At
        Date and time of this Numberlist item creation.
    Updated At
        Date and time of last updating of this Numberlist item.


