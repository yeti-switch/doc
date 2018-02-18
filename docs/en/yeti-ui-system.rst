======
System
======

YETI WEB interface - System menu description. This section describes general configuration parameters for Yeti.


Info
~~~~

General information about current build of Yeti and current state of Yeti's database is provided in this window. There are four separate sections: TOP10 tables in Routing database, TOP10 tables in CDR database, Build info and Replication. Detailed information about size of data (together with whole size) for top ten tables from the both (Routing and CDR) databases is provided.

----

.. _admin_users:

Admin Users
~~~~~~~~~~~

Users that have access to this YETI WEB interface.

**User**'s attributes:
``````````````````````
    Id
       Unique User's id.
    Email
       Email of this *Admin Users*.
    Username
       Unique User's name.
    Password
       Password for authentication.
    Password confirmation
       Confirmation of the password.
    Ssh key
        SSH key that can be used for authentication.
    Stateful filters
        ****TODO**** - need to clarify

----

API Accesses
~~~~~~~~~~~~

Application Programming Interface (API) is used for interactions between external systems (for example billings) and Yeti.

**API Access**'s attributes:
````````````````````````````
    Id
       API Access's id.
    Login
        Unique login of user that is used for authentication of access wia Application Programming Interface (API).
    Password
        Password of user that is used for authentication of access wia Application Programming Interface (API).
    Customer
        :ref:`Customer <contractors>` that is associated with this *API Access*.
    Accounts
        :ref:` <Accounts accounts>` that are associated with this *API Access*.
    Allowd IPs
        Array of IP addresses that is divided by comma. It is possible to use hosts or networks addresses here.

----

.. _api_log_configs:

Api Log Configs
~~~~~~~~~~~~~~~

Api Log Configs are used for setting (where necessary) Debug mode for storing records to the :ref:`API Log <api_log>`.
You can click on the  "Yes/No" button near the records for changing their state.

**Api Log Config**'s properties:
````````````````````````````````
    Controller
        Controller that will be used for applying of the Debug mode of storing records to the :ref:`API Log <api_log>` in case of enabling Debug property bellow.
    Debug
        In case of enabling this property (by clicking on it) additional fields (Request Body, Response Body, Request Headers, Response Headers) will be stored to the :ref:`API Log <api_log>` for the Controller above.

----

Alerts
~~~~~~

Alerts are used for configuring :ref:`Contact <contacts>` or :ref:`Admin User <admin_users>` for sending notifications in case of some Events. Following Events are available for configuration:

    **AccountHighThesholdCleared** - event when the balance of some :ref:`Account <accounts>` has become in norm after was becoming bigger than high threshold. :ref:`Balance high threshold <account_balance_high_threshold>` should be configured for the :ref:`Account <accounts>`;

    **AccountLowThesholdCleared** - event when the balance of some :ref:`Account <accounts>` has become in norm after was becoming less than low threshold. :ref:`Balance low threshold <account_balance_low_threshold>` should be configured for the :ref:`Account <accounts>`;

    **AccountHighThesholdReached** - event when the balance of some :ref:`Account <accounts>` has become bigger than high threshold. :ref:`Balance high threshold <account_balance_high_threshold>` should be configured for the :ref:`Account <accounts>`;

    **AccountLowThesholdReached** - event when the balance of some :ref:`Account <accounts>` has become less than low threshold. :ref:`Balance low threshold <account_balance_low_threshold>` should be configured for the :ref:`Account <accounts>`;

    **DestinationQualityAlarmCleared** - event when one of the quality parameters (Asr, Acd or Short Calls) of some :ref:`Destination <destinations>` has become in norm after were becoming less than :ref:`Asr Limit, Acd Limit or Short Calls Limit <quality_notification_config>` values accordingly;

    **DestinationQualityAlarmFired** - event when one of the quality parameters (Asr, Acd or Short Calls) of some :ref:`Destination <destinations>` has become less than :ref:`Asr Limit, Acd Limit or Short Calls Limit <quality_notification_config>` values accordingly;

    **GatewayUnlocked** - ****TODO****;

    **DialpeerUnlocked** - ****TODO****;

    **GatewayLocked** - ****TODO****;

    **DialpeerLocked** - ****TODO****.

**Alert**'s properties:
```````````````````````
    Id
        Unique Alert's id.
    Event
        Name of Event for this "Alert".
    Send To
        :ref:`Contact <contacts>` or :ref:`Admin User <admin_users>` for sending this *Alert*.

----

Background Tasks
~~~~~~~~~~~~~~~~

Background Tasks are used for storing records about ongoing tasks that are making in background. Task will be removed from this list after finishing of its action. In normal mode this list is empty.

**Background Task**'s properties:
`````````````````````````````````
    Priority
        Priority of this *Background Task*.
    Attempts
        Current amount of attempts of make action for this *Background Task*.
    Hadler
        Some serialized data that is related to this *Background Task*.
    Last Error
        Last Error of action's attempt for this *Background Task*.
    Run At
        Date and time of running this *Background Task*.
    Locked At
        Date and time of locking action's attempt (by some working process) for this *Background Task*.
    Failed At
        Date and time of failing action's attempt for this *Background Task*.
    Locked By
        Process ID of working process that is locked this *Background Task*.
    Queue
        Name of Queue where this *Background Task* is staying.
    Created At
        Date and time of this Background Task item creation.
    Updated At
        Date and time of last updating of this Background Task item.

----

.. _disconnect_codes:

Disconnect Codes
~~~~~~~~~~~~~~~~

Disconnect Codes are used for ****TODO****

**Disconnect Code**'s attributes:
`````````````````````````````````
    Id
       Disconnect Code's id.
    Namespace
       Namespace that is related to this *Disconnect Code*. Following Namespaces are available: TM (traffic manager), RADIUS, TS (traffic switch), SIP.
    Code
        Numeric SIP code for this *Disconnect Code*.
    Reason
        Textual Reason for this *Disconnect Code*.
    Success
        In case of enabling of this field this *Disconnect Code* will be recognized by Yeti as successful.
    Successnozerolen
        ****TODO****
    Stop hunting
        In case of enabling of this field Yeti will stop ****TODO****
    Pass reason to originator
        In case of enabling of this field Yeti will transfer reason from termination :ref:`Gateway <gateways>` to origination.
    Rewrited code
        If this field is not empty new numeric code from this field will be transfer to origination :ref:`Gateway <gateways>`.
    Rewrited reason
        If this field is not empty new textual reason from this field will be transfer to origination :ref:`Gateway <gateways>`.
    Store cdr
        In case of enabling of this field Yeti will store CDRs for calls that were terminated with this *Disconnect Code*.
    Silently drop
        ****TODO****

----

Jobs
~~~~
        ****TODO**** - schedulers that could be run by cron or manually. Run or Unlock (for the failed) actions

**Job**'s properties:
`````````````````````
    Id
        Job's id.
    Type
        ****TODO****
    Description
        ****TODO****
    Executed
        ****TODO****
    Running
        ****TODO****

----

.. _pops:

PoPs
~~~~

Points of Presence (PoPs) are used for separate calls between different switching platforms (f.e. in different countries).

**PoP**'s attributes:
`````````````````````
    Id
       PoP's id.
    Name
        Name of the Point of Presence.

----

.. _countries:

Countries
~~~~~~~~~
       Countries are used for systematizing destination numbers and source numbers by countries that are identified by international country code. With using *Countries* Yeti could apply some additional routing rules to the calls.

**Country**'s properties:
`````````````````````````

    .. _country_id:

    Id
       Unique Country's id.
    Name
       Unique Country's name.
    ISO2
       Official ISO Country Code.

----

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

----

CDR Writer Configuration
~~~~~~~~~~~~~~~~~~~~~~~~
        ****TODO**** - Call duration round mode

----


Load Balancers
~~~~~~~~~~~~~~

****TODO****

**Load Balancer**'s attributes:
```````````````````````````````
    Id
       Load Balancer's id.
    Name
        ****TODO****
    Signalling IP
        ****TODO****

----

.. _nodes:

Nodes
~~~~~

List of YETI nodes connected to current cluster.
Every node represents independent installation of YETI-SEMS, which communicate to management interface via RPC protocol.

**Node**'s attributes:
``````````````````````
    Id
       Node's id.
    Name
       Node's name.
    Pop
        Point of presence. Might be useful for logic grupping of nodes (different data-centers, as example).
    Signalling ip
        IP address of node.
    Signaling port
        Network port for sending SIP-packets (dafault value 5060).
    Rpc endpoint
        IP address and port on which YETI-SEMS is waiting for RPC connections.

In view mode user can use next tabs:

Details
        Common information about node.
Active Calls Chart
        Show the next graphs:
        - Active calls for 24 hours.
        - Calls count for month.
Comments
        Comments of user for current node.

----


LNP Resolvers
~~~~~~~~~~~~~

Local number portability (LNP) Resolvers are used for ****TODO****

**LNP Resolver**'s attributes:
``````````````````````````````
    Id
       LNP Resolver's id.
    Name
       Unique name of this *LNP Resolver*.
    Address
       IP-address or domain name for connection to this *LNP Resolver*.
    Port
       Network port for connection to this *LNP Resolver*. ****TODO****

----

.. _networks:

Networks
~~~~~~~~

    Catalogue of carriers. It contains names of carriers and uses in **Network prefixes** then.


**Network**'s attributes:
`````````````````````````
    .. _network_id:

    Id
       Network's id.
    Name
        Name of the Network (Carrier).

----

.. _network_prefixes:

Network Prefixes
~~~~~~~~~~~~~~~~

Catalogue of phone prefixes. Yeti database contains preloaded data of prefixes. User could edit them or add another.

**Network Prefixe**'s attributes:
`````````````````````````````````
    Id
       Network Prefixe's id.
    Prefix
         This field is used for setting prefix for the *Network*. Call will be associated with this *Network* (Source or Destination) only in case of matching this *Prefix* with first symbols of relevant number (A or B).
    Country
        :ref:`Country <countries>` that is associated to the *Prefix* above.
    Network
        :ref:`Network <networks>` that is associated to the *Prefix* above.

----

Sensors
~~~~~~~

System supports mirroring of signaling and media traffic.
This functionality can be used for Lawful Interception.
Currently system supports two encapsulation methods:

    - IP-IP tunnel
        Original packets will be encapsulated into additional IP-IP tunnel header.
        This mode allows to route mirrored traffic,
        it's especially useful when destination equipment not available in the same broadcast domain.
    - IP over Ethernet
        In this mode original packets will be encapsulated directly into Ethernet frame using raw sockets.
        Intended to use for cases when destination equipment is in the same L2 domain.

Sensor and logging level can be chosen in gateway settings.
Sensor configuration is separate for A and B leg, thus for both legs mirroring - sensors must be configured for both termination and origination gateway.

**Sensor**'s attributes:
````````````````````````
    Id
       Sensor's id.
    Name
        Sensor's name.
    Mode
        IP-IP encapsulation
        IP-Ethernet encapsulation
        HEPv3 ****TODO****
    Source Interface
        The name of the source interface of this *Sensor*. This field is used for "IP-Ethernet encapsulation" mode. ****TODO****
    Target MAC
        MAC address of target gateway. This field is used for "IP-Ethernet encapsulation" mode. ****TODO****
    Source IP
        ****TODO****
    Target IP
        ****TODO****
    Target Port
        ****TODO****
    Hep Capture
        ****TODO****

----

.. _smtp_connections:

SMTP connections
~~~~~~~~~~~~~~~~

It is necessary to have an SMTP connection in order to YETI can send invoices and alerts to customers. Then user can choose SMTP connection for Customer.

**SMTP connection**'s attributes:
`````````````````````````````````
    Id
       SMTP connection's id.
    Name
        Unique name of SMTP connection.
        Uses for informational purposes and doesn't affect system behaviour.
    Host
        IP address or hostname of SMTP server.
    Port
        TCP port on which SMTP server wait for requests (*default value: 25*).
    From address
        E-mail address of sender.
    Auth user
        Username for Authorization procedure on external SMTP server.
    Auth password
        Password for Authorization procedure on external SMTP server.
    Global
        Set as global for all customers.
