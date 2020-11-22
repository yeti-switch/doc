
.. _jobs:

Jobs
~~~~
Jobs are used for review schedulers of some regular procedures that are executed by system or could be executed manually.
You could press "Run" link for execute some procedure or "Unlock" in case of some problems during its execution. Following procedures are available:

    -   **CdrPartitioning** - procedure of creating new tables for tables :ref:`CDR History <cdr_history>`, :ref:`Auth logs <cdr_auth_logs>`, :ref:`RTP Statistics <rtp_statistics>` and :ref:`API Logs <api_logs>`

    -   **EventProcessor** - procedure of sending :ref:`Events <events>` to the SEMS;

    -   **CdrBatchCleaner** - procedure of removing old batches of information from temporary table in Routing Database;

    -   **PartitionRemoving** - procedure of removing partitions of tables :ref:`CDR History <cdr_history>`, :ref:`Auth logs <cdr_auth_logs>`, :ref:`RTP Statistics <rtp_statistics>` and :ref:`API Logs <api_logs>`. Storage period for each table defined at regulated by configurations pareter **partition_remove_delay** at /opt/yeti-web/config/yeti_web.yml
    
    -   **CallsMonitoring** - procedure that is used for periodical (once per minute) calculation of cost for all active calls for each :ref:`Account <accounts>` and comparison their cost with current :ref:`Account Balance <account_balance>`. If account balance is less than cost of all active calls for the :ref:`Account <accounts>` all calls will be dropped by Yeti. This procedure also is used for calculating statistics for :ref:`Dushboard <dashboard>` and :ref:`Active calls <active_calls>`;

    -   **StatsClean** - procedure of removing statistics that are used for calculation of quality parameters (ACD, ASR and Short Calls) for :ref:`Gateways <gateways>` and :ref:`Dialpeers <dialpeers>`;

    -   **StatsAggregation** - procedure of aggregation of the data about calls for the graphs;

    -   **Invoice** - procedure of :ref:`Invoice <invoices>` generation according to periods that were configured in the settings of :ref:`Accounts <accounts>`.

    -   **ReportScheduler** - procedure of :ref:`Reports <reports>` generation according to stored Schedulers;

    -   **TerminationQualityCheck** - procedure of checking of the quality parameters of :ref:`Dialpeers <dialpeers>`. :ref:`Dialpeer <dialpeers>` will be locked in case of overcoming of threshold for quality parameters (Acd Limit, Asr Limit or Short Calls Limit) of the :ref:`Dialpeer <dialpeers>`.

    -   **DialpeerRatesApply** - procedure of applying New Rates for :ref:`Dialpeers <dialpeers_new_rates>` and :ref:`Destinations <destinations_new_rates>`.

    -   **AccountBalanceNotify** - procedure of sending :ref:`Account Balance Notifications <account_balance_low_threshold>`.


**Job**'s properties:
`````````````````````
    Id
        Job's id.
    Type
        Name of procedure for this *Job*.
    Description
        Textual description of procedure.
    Executed
        Period of time when this *Job* was executed last time.
    Running
        Running status (Yes or No) of this *Job*.


