.. :maxdepth: 2


==================
Redis installation
==================

Redis is used to synchronize data between switch instances. It stores information about used resources (e.g gateways capacity limits) to provide correct limitation among all nodes for distributed installations.

Install packages
================

.. code-block:: console

    # apt update && apt install redis-server
    
Configuration
=============

Add

.. code-block:: ini

    notify-keyspace-events "Egx"
    
to your ``/etc/redis/redis.conf`` to enable notifications. This configuration required for incoming registrations functionality.

Checks
======

Try to enter redis console from traffic switch host
(redis installed at the same host
with traffic switch in this example):

.. code-block:: console

    # redis-cli
    127.0.0.1:6379> ping
    PONG
    127.0.0.1:6379> quit
