.. :maxdepth: 2

=============
Release notes
=============


Changes in 1.12 version
~~~~~~~~~~~~~~~~~~~~~~~
    * Debian 11 support    
    * Ruby upgraded to 2.7
    * Rails upgraded to 6.1
    * Network detection fixes
    * CDR Exports added to Admin API
    * IP ACL for Admin user
    * IP auth and username/password caching on SEMS nodes
    * CNAM drivers support
    * Call destination rewriting based on LNP response
    * HttpOnly cookie auth for Customer API
    * New RTP statistics
    * daily partitioning for CDR tables
    * Asynchronous reports
    * Sentry upgrade
    * SRC and DST numbers validation mechanisms
    


Upgrading to 1.12.79
~~~~~~~~~~~~~~~~~~~~

In yeti-web version 1.12.79 asynchronous CDR statistics calculation was introduced. This new mechanism requires additional configuration after system upgrade.

Enable CDR Stats add configutation for CDR stats process to **/opt/yeti-web/config/pgq_processors.yml**:

.. code-block:: yaml

	cdr_stats:
	  mode: production
	  class: cdr_stat
	  stored_procedure: switch.async_cdr_statistics
	  syslog_program_name: "yeti-cdr-stats"
	

Enable CDR Stats pgq processor:

.. code-block:: console

        root@yeti:/# systemctl enable yeti-cdr-billing@cdr_stats


Start cdr_stats pgq processor:

.. code-block:: console

        root@yeti:/# systemctl start yeti-cdr-billing@cdr_stats

