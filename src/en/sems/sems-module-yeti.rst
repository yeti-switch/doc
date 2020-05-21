.. :maxdepth: 2


===========
yeti module
===========


Module **yeti** implements SBC funtions for Yeti-switch project

.. code-block:: c

    module "yeti" {
        management {
            address = 127.0.0.1
            port = 4444
            timeout = 60000
        }
        core_options_handling = yes
    }
        
  
address
	IP address for system where yeti-management daemon is running

port
	yeti-management SCTP port
	
timeout
	Configuration fetch timeout
	
core_options_handling
    Handle SIP OPTIONS requests on SEMS core level, to not forward such requests to yeti application
