.. :maxdepth: 2


==================
Module **jsonrpc**
==================


Module **jsonrpc** implements `JSONRPC <https://www.jsonrpc.org/specification>`_ management interface for SEMS.

.. code-block:: c


    module "jsonrpc" {
        listen {
            address = 10.17.93.13
            port = 7080
        }
        server_threads = 2
    }

  
listen.address
	IP address of JSONRPC socket

listen.port
	TCP port of JSONRPC socket
	
server_threads
    How many worker threads will be forked for JSONRPC requets handling
    
    
.. note:: :doc:`yeti-cli <../yeti-cli/index>` console is client for SEMS JSONRPC interface.
