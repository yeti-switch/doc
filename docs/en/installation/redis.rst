.. :maxdepth: 2


==================
Redis installation
==================

Redis is used to synchronize data between traffic switch instances.
It stores information about used resources (e.g gateways capacity limits)
to provide correct limitation among all nodes for distributed installations.

Install packages
================

::

    # aptitude install redis-server

Checks
======

Try to enter redis console from traffic switch host
(redis installed at the same host
with traffic switch in this example)::

    # redis-cli
    127.0.0.1:6379> ping
    PONG
    127.0.0.1:6379> quit
