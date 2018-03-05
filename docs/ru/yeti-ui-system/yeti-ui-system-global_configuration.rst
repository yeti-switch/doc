
.. _global_configuration:

Global configuration
~~~~~~~~~~~~~~~~~~~~

The page contains global parameters of YETI.

**Global configuration**'s attributes:
``````````````````````````````````````

Rows Per Page
    This option affords to change drop-down 'Per page' element, which is exists on every list-type page in YETI.
    You can add additional values to that drop-down list if default values '30,50,100' are not sufficient.
CDR Unload Dir
    Directory where YETI unload CDR tables on the *CDR -> Tables* page.
CDR Unload URI
    URL for external CDR viewer program. YETI redirects to that program from *CDR -> Tables* page when user press **Unloaded files** button.

.. _system_global_configuration_cdr_archive_delay:

CDR Archive Delay
    Move CDRs to archive table after **N** months.
CDR Remove Delay
    Remove archived tables after **N** months.
Max Records
    Maximum amount of records which YETI can save to CSV file on every list-type page (*Download: CSV* button at the bottom of page).
Import Max Threads
    Number of threads for import from CSV process.
Import Helpers Dir
    Helper directory where YETI saves temporary files during import from CSV process.

.. _system_global_configuration_active_calls_require_filter:

Active Calls Require Filter
    Requre any filter on the *RT data -> Active Calls* page.
Registrations Require Filter
    Require any filter on the *RT data -> Outgoing Registrations* page.

.. _system_global_configuration_active_calls_show_chart:

Active Calls Show Chart
    If **true** YETI shows chart of active calls on the *RT data -> Active Calls* page.

.. _system_global_configuration_active_calls_autorefresh_enable:

Active Calls Autorefresh Enable
    If **true** YETI will refresh *RT data -> Active Calls* page every 20 seconds.
Max Call Duration
    Global parameter of maximum call duration (seconds).
Random Disconnect Enable
    If **true** YETI will randomly disconnect calls whose duration more than **Random Disconnect Length** by sendind BYE message to parties.
Random Disconnect Length
    Duration of calls (seconds) which YETI will disconnect if **Random Disconnect Enable** enabled.
Drop Call If LNP Fail
    If **true** YETI drops calls if request to LNP database is not successful.

.. _system_global_configuration_lnp_cache_ttl:

LNP Cache TTL
    Time to life of LNP cache (seconds).
LNP E2E Timeout
    Timeout for requests to LNP database (seconds). YETI will drop calls if **Drop Call If LNP Fail** enabled and timeout expired or bad response returned.

.. _short_call_length:

Short Call Length
    User may decide which calls are 'short' by this settings (seconds). It involves **Short Calls** filter button on the *CDR -> CDR History* page.
Termination Stats Window
    Interval (hours) for generating of stats for gateway or dialpeer (*Short Window Stats* panel on page of every gateway or dialpeer).
Quality Control Min Calls
    Minimum number of calls for building **Quality Control** statistics.
Quality Control Min Duration
    Total duration of calls for building **Quality Control** statistics.


