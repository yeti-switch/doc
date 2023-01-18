.. :maxdepth: 2


==========
Monitoring
==========

Yeti switch have designed to be used in pair with `Prometheus <https://prometheus.io/>`_ monitoring stack.


Yeti-web
========

To enable yeti-web prometheus exporter change configuration  in **yeti_web.yml**:

.. code-block:: yaml

	prometheus:
	  enabled: true
	  host: localhost
	  port: 8080
	  default_labels:
	    host: yeti.example.com

  
address
	IP address where exporter will listen

port
	port to listen

label
	label function allow to add custom labels to all metrics exposed by exporter. Label can be used multiple times

Prometheus exporter require additional daemon to be started. To start and enable **yeti-prometheus** daemon run:

.. code-block:: console

        root@yeti:/# systemctl start yeti-prometheus
        root@yeti:/# systemctl enable yeti-prometheus

SEMS
====

See :ref:`SEMS prometheus module <sems_prometheus>` documentation for information how to enable SEMS prometheus exporter

