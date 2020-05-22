.. :maxdepth: 2


==============================
Module **prometheus_exporter**
==============================


Module **prometheus_exporter** allows to expose SEMS internal metrics to `Prometheus <https://prometheus.io/>`_ metric storage. To enable exporter just add new module to your **sems.conf**:

.. code-block:: c

    modules {
        ...
        module "prometheus_exporter" {
            address = 127.0.0.1
            port = 8080
            label(system, yeti)
            label(pop, us-east-1)
            label(host, yeti.example.com)
        }
        ...
    }

  
address
	IP address where exporter will listen

port
	port to listen

label
	label function allow to add custom labels to all metrics exposed by exporter. Label can be used multiple times

