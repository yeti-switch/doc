======
System
======

YETI WEB interface - System menu description. This section describes general configuration parameters for Yeti.


Info
~~~~

****TODO****

----

Admin Users
~~~~~~~~~~~

****TODO****

**User**'s attributes:
``````````````````````
    Id
       Unique User's id.
    Email
        ****TODO****
    Username
        ****TODO****
    Password
        ****TODO****
    Password confirmation
        ****TODO****
    Ssh key
        ****TODO****
    Stateful filters
        ****TODO****

----

API Accesses
~~~~~~~~~~~~

****TODO****

**API Access**'s attributes:
````````````````````````````
    Id
       API Access's id.
    Login
        ****TODO****
    Password
        ****TODO****
    Customer
        ****TODO****
    Accounts
        ****TODO****
    Allowd IPs
        ****TODO****

----

Api Log Configs
~~~~~~~~~~~~~~~

    ****TODO****

----

Alerts
~~~~~~

****TODO****

----

Background Tasks
~~~~~~~~~~~~~~~~

****TODO****

**Background Task**'s attributes:
`````````````````````````````````
    Priority
        ****TODO****
    Attempts
        ****TODO****
    Hadler
        ****TODO****
    Last Error
        ****TODO****
    Run At
        ****TODO****
    Locked At
        ****TODO****
    Failed At
        ****TODO****
    Locked By
        ****TODO****
    Queue
        ****TODO****
    Created At
        ****TODO****
    Updated At
        ****TODO****

----

.. _disconnect_codes:

Disconnect Codes
~~~~~~~~~~~~~~~~

****TODO****

**Disconnect Code**'s attributes:
`````````````````````````````````
    Id
       Disconnect Code's id.
    Namespace
        ****TODO****
    Code
        ****TODO****
    Reason
        ****TODO****
    Success
        ****TODO****
    Successnozerolen
        ****TODO****
    Stop hunting
        ****TODO****
    Pass reason to originator
        ****TODO****
    Rewrited code
        ****TODO****
    Rewrited reason
        ****TODO****
    Store cdr
        ****TODO****
    Silently drop
        ****TODO****

----

Jobs
~~~~
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
       ****TODO****

**Country**'s attributes:
`````````````````````````

    .. _country_id:

    Id
       ****TODO****
    Name
       ****TODO****

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
    Number of threads for import from CSV proccess.
Import Helpers Dir
    Helper directory where YETI saves temporary files durring import from CSV process.
Active Calls Require Filter
    Requre any filter on the *RT data -> Active Calls* page.
Registrations Require Filter
    Require any filter on the *RT data -> Outgoing Registrations* page.
Active Calls Show Chart
    If **true** YETI shows chart of active calls on the *RT data -> Active Calls* page.
Active Calls Autorefresh Enable
    If **true** YETI will refresh *RT data -> Active Calls* page every 20 seconds.
Max Call Duration
    Global parameter of maximum call duration (seconds).
Random Disconnect Enable
    If **true** YETI will randomly disconnect calls whose duration more than **Random Disconnect Length** by sendind BYE message to parties.
Random Disconnect Length
    Duration of calls (seconds) which YETI will disconnect if **Random Disconnect Enable** enabled.
Drop Call If LNP Fail
    If **true** YETI drops calls if request to LNP database is not successfull.
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
        ****TODO****

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

Nodes
~~~~~

List of YETI nodes connected to current cluster.
Every node represents independent installation of YETI-SEMS, which communicate to management interface via RPC protocol.

**Node**'s attributes:
``````````````````````
    Id
       Node's id.
    Name
        Node name.
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

****TODO****

**LNP Resolver**'s attributes:
``````````````````````````````
    Id
       LNP Resolver's id.
    Name
        ****TODO****
    Address
        ****TODO****
    Port
        ****TODO****

----

Networks
~~~~~~~~

    Catalogue of carriers. It contains names of carriers and uses in **Network prefixes** then.


**Network**'s attributes:
`````````````````````````
    .. _network_id:

    Id
       Network's id.
    Name
        ****TODO****

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
        ****TODO****
    Country
        Country this prefix belongs to. ****TODO****
    Network
        Operator network name. ****TODO****


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
        ****TODO****
    Mode
        ****TODO****
    Source Interface
        ****TODO****
    Target MAC
        ****TODO****
    Source IP
        ****TODO****
    Target IP
        ****TODO****
    Target Port
        ****TODO****
    Hep Capture
        ****TODO****

----

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
