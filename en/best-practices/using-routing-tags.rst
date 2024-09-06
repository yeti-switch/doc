.. :orphan:

==================
Using Routing tags
==================
The Yeti Switch has rich abilities for routing traffic. And one of them is tags.

Let's imagine that you need to route some calls relying on their A or B numbers (or even both) - that's not a problem.

We have to use the next entities for that (see the "Routing" menu group):
Routing tags - we attach them to dialpeers. It holds areas within.
Areas - implies some geographic area (or whatever you want) and holds prefixes within.
Area prefixes - that's where our A or B prefixes live. 
Routing tags detection - the place where the magic goes. I.e. there we combine a Routing Tag with Areas.

I think I'll better show you a diagram

.. image:: images/routing_tags_usage.png

Here, we've created the special tag named VIP for Bender (we check his A number) who calls to Robonia (we check its prefixes).

We can easily create another one Routing tag and Routing tag detection, where we may use the same ROBONIA area as Src area for calls so that we could detect calls from Robonia to our system (maybe, we don't want to charge them or on the contrary charge them more).


What's the next?
Now, we may attach our newly created tag to a dialpeer

.. image:: images/routing_tags_decision.png

So, if any particular call already has a tag than Yeti is going to choose dialpeers having such a tag, than all others dialpeers.
If a call don't have any tags than a routing decision will be based on all dialpeers.
