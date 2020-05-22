.. :maxdepth: 2


=================
Module **di_log**
=================


The **di_log**  module provides a ring buffer logging facility which on request dumps the ring buffer contents either as result of the DI call or in a file on HD. dumping the ring buffer can be invoked via JSONRPC interface (for example remotely from the stats module).
Ring buffer size and string length can be customized at compile time, see DILog.h. **di_log**  module allows to run sems with logleve=3(debug) in production without significant performance loss.


.. code-block:: c

    module "di_log" {}
    
**di_log** module doesn't require any configuration.



JSONRPC methods
===============

**di_log**  provides JSONRPC method **core.request.log.dump** to save ring buffer content on disk.
