
========
REST API
========

Yeti-Switch providing two REST API interfaces for integrations with external systems.


.. _admin_api:

Admin API
=========

Admin API is designed automate Yeti-Switch configuration and data provisioning from external systems. Access to Admin API controlled at :ref:`System->Admin Users <admin_users>` because Admin API client has same access level as regular system administrator. Administration API based on `JSONAPI speficication <https://jsonapi.org>`_.

Automatically generated API documentation included to yeti-web distribution and available at path **/doc/api/admin/index.html**

API documentation on demo instance `<https://demo.yeti-switch.org/doc/api/admin/index.html>`_


.. warning:: Accesss to admin API endpoint **/api/rest/admin/** is blocked by default in supplied NGINX configuration file **yeti-web.dist.nginx**


.. _customer_api:

Customer API
============

Customer API is designed to be backend for customer portals to allow end-user fetch Rates, Account information, CDRs, Statistics and other customer-specific data. Access to Customer API controlled at :ref:`Customer Portal Logins <api_access>` Admin WEB Interface section. Customer API based on `JSONAPI speficication <https://jsonapi.org>`_ and perfectly fit for JS SPA clients.

Automatically generated API documentation included to yeti-web distribution and available at path **/doc/api/customer/v1/index.html**

API documentation on demo instance `<https://demo.yeti-switch.org/doc/api/customer/v1/index.html>`_


Logging
=======

All API requests logged. Logs located in Admin Web interface :ref:`Logs->Api Log <api_logs>`


Debug mode
==========

By default API log doesn't contain request payload(body) and response. To enable verbose debug mode - create record in :ref:`System->Api Log Configs <api_log_configs>`
