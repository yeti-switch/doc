.. :maxdepth: 2


==============================
Management server installation
==============================

Since version 1.6.3-175 we started to use central configuration server
to store yeti module configuration for all nodes in cluster.

Packages installation
---------------------

.. code-block:: console

    # apt update && apt install yeti-management

Configuration files
-------------------

/etc/yeti/management.cfg
~~~~~~~~~~~~~~~~~~~~~~~~

This file contains configuration for management daemon.

Set desired logging level and address to listen.

You can set multiple addresses separated by comma to listen on multiple interfaces.

Possible log_level values are: (1 - error, 2 - info, 3 - debug)

.. code-block:: c

    daemon {
      listen = {
        "tcp://0.0.0.0:4444"
      }
      log_level = 2
    }

/etc/yeti/system.cfg
~~~~~~~~~~~~~~~~~~~~

This file contains configuration for all nodes.
Each top-level section defines configuration for node of certain type
(signaling is for traffic switch nodes).
All top-level sections contains mandatory section globals
which must have all possible values common for all nodes.
Then there is named sections for each node_id which may contain
values overriding ones set in global section.

Note: even if your node does not have
any specific values you have to define empty section
for this node anyway, otherwise management node
will not provide configuration for node with this id.

Example of minimal configuration file for node with id 8

.. code-block:: c

    signalling {
      globals {
        yeti {
          pop_id = 4
          msg_logger_dir = /var/spool/sems/dump
          log_dir = /var/spool/sems/logdump
          routing {
            schema = switch14
            function = route_release
            init = init
            master_pool {
              host = 127.0.0.1
              port = 5432
              name = yeti
              user = yeti
              pass = yeti
              size = 4
              check_interval = 10
              max_exceptions = 0
              statement_timeout=3000
            }
            failover_to_slave = false
            slave_pool {
              host = 127.0.0.1
              port = 5432
              name = yeti
              user = yeti
              pass = yeti
              size = 4
              check_interval = 10
              max_exceptions = 0
              statement_timeout=3000
            }
            cache {
              enabled = false
              check_interval = 60
              buckets = 100000
            }
          }
          cdr {
           dir = /var/spool/sems/cdrs
           completed_dir = /var/spool/sems/cdrs/completed
           pool_size = 2
           schema = switch
           function = writecdr
           master {
             host = 127.0.0.1
             port = 5432
             name = cdr
             user = cdr
             pass = cdr
          }
           failover_to_slave = false
           slave {
             host = 127.0.0.1
             port = 5432
             name = cdr
             user = cdr
             pass = cdr
           }
           failover_requeue = true
           failover_to_file = false
           serialize_dynamic_fields = true
         }
         resources {
           reject_on_error = false
           write {
             host = 127.0.0.1
             port = 6379
             size = 2
             timeout = 500
           }
           read {
             host = 127.0.0.1
             port = 6379
             size = 2
             timeout = 1000
           }
         }
         registrations {
           check_interval = 5000
         }
         rpc {
           calls_show_limit = 1000
         }
       }
      }
      node 8 { }
    } 
    
.. warning:: You should define all Nodes that has been created at web interface by their IDs. See :ref:`System->Nodes <nodes>` menu. SEMS node will refuse to start if corresponding node is not defined at system.cfg


Management server launch
------------------------

Launch configured management server instance:

.. code-block:: console

    # service yeti-management start

Checks
------

Check file /var/log/yeti/yeti-management.log for daemon logs:

.. code-block:: console

    # tail -2 /var/log/yeti/yeti-management.log
    Sep 12 12:54:47 evial yeti-management[25376]: [25376] 
      info: server/src/yeti_mgmt_server.cpp:148: starting version 1.0.5
    Sep 12 12:54:47 evial yeti-management[25376]: [25376]
      info: server/src/mgmt_server.cpp:123: listen on tcp://0.0.0.0:4444

Check listening port:

.. code-block:: console

    # netstat -lpn | grep yeti_management
    4444 tcp 0 0 0.0.0.0:4444 0.0.0.0:* LISTEN 25376/yeti_manageme

