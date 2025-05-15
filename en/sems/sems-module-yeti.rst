.. :maxdepth: 2


===============
Module **yeti**
===============


Module **yeti** implements SBC functions for Yeti-switch project

.. code-block::

    module "yeti" {
        # pop_id = 0

        # db_refresh_interval = 300

        # msg_logger_dir = /var/spool/sems/dump

        # audio_recorder_dir = /var/spool/sems/record
        # audio_recorder_compress = true
        # audio_recorder_http_destination =

        # core_options_handling = true
        # pcap_memory_logger = false

        # ip_auth_header = X-ORIG-IP
        # ip_auth_reject_if_no_matched = false

        # http_events_destination =

        # write_internal_disconnect_code = false

        # postgresql_debug = false

        # supported_tags = {}
        # allowed_methods = {INVITE, ACK, BYE, CANCEL, OPTIONS, NOTIFY, INFO, UPDATE, PRACK}

        /*
        routing {
            # schema = switch21
            # function = route_release
            # init =

            # new_codec_groups = true
            # pass_input_interface_name = false
            # connection_lifetime = 0

            /*
            master_pool {
                # host = 127.0.0.1
                # port = 5432
                # name = yeti
                # user = yeti
                # pass = yeti

                # size = 10
                # check_interval = 25
                # statement_timeout = 5
            }
            */

            # failover_to_slave = false
            /*
            slave_pool {
                # host = 127.0.0.1
                # port = 5432
                # name = yeti
                # user = yeti
                # pass = yeti

                # size = 10
                # check_interval = 25
                # statement_timeout = 5
            }
            */

            /*
            headers {
                # header(header_name[, sql_type = varchar, [format[, format_param]])
            }
            */
        }
        */

        /*
        cdr {
            # pool_size = 10
            # batch_size = 50
            # batch_timeout = 10000

            # auth_pool_size = pool_size
            # auth_batch_size = batch_size
            # auth_batch_timeout = batch_timeout

            # check_interval = 25

            # connection_lifetime = 0

            # schema = switch
            # function = writecdr

            /*
            master {
                # host = 127.0.0.1
                # port = 5432
                # name = cdr
                # user = cdr
                # pass = cdr
            }
            */

            # failover_to_slave = true

            /*
            slave {
                # host = 127.0.0.1
                # port = 5432
                # name = cdr
                # user = cdr
                # pass = cdr
            }
            */
        }
        */

        /*
        resources {
            # reject_on_error = false
            # reduce_operations = false
            # scripts_dir = /usr/lib/sems/scripts/yeti
            /*
            write {
                # hosts = 127.0.0.1:6379
                # timeout = 5000
                # username =
                # password =
            }
            */
            /*
            read {
                # hosts = 127.0.0.1:6379
                # timeout = 5000
                # username =
                # password =
            }
            */
        }
        */

        /*
        lega_cdr_headers {
            # header(header_name, none|string|array|smallint|integer [, active_call_key, String])
            # add_sip_reason = false
            # add_q850_reason = false
        }
        */

        /*
        legb_cdr_headers {
            # header(header_name, string|array|smallint|integer)
        }
        */

        /*
        legb_response_cdr_headers {
            # header(header_name, string|array|smallint|integer)

            # add_sip_reason = false
            # add_q850_reason = false
        }
        */

        /*
        rpc {
            # calls_show_limit = 100
        }
        */

        /*
        statistics {
            /*
            active-calls {
                # period = 60
                /*
                clickhouse {
                    # table = active_calls
                    # destinations = {}
                    # buffering = false
                    # allowed_fields = { }
                }
                */
            }
            */
        }
        */

        /*
        auth {
            # realm = hostname
            # skip_logging_invite_success = false
            # skip_logging_invite_challenge = false
        }
        */

    }

pop_id (default: 0)
    Point of presence id

db_refresh_interval (default: 300)
    Database refresh timer in seconds. Sets period between ``check_states()`` DB calls to check entities versions

msg_logger_dir (default: /var/spool/sems/dump)
    Directory to store \*.pcap files

audio_recorder_dir (default: /var/spool/sems/record)
    Directory to store \*.mp3 or \*.rsr files. Works for ``audio_recorder_compress = true`` only.

audio_recorder_compress (default: true)
    Sets recordings storing format.
  
    * true. store MP3 audio file for each leg
        * {audio_recorder_dir}/{global_tag}_{node_id}_lega.mp3
        * {audio_recorder_dir}/{global_tag}_{node_id}_legb.mp3
    * false. store single multichannel RSR file
        * {general.rsr_path}/{global_tag}.rsr

audio_recorder_http_destination (default: empty)
    Destination name in the **http_client** module to automatically upload RSR files. Works for ``audio_recorder_compress = false`` only.

core_options_handling (default: true)
    Handle SIP OPTIONS requests on SEMS core level, do not forward such requests to yeti application

pcap_memory_logger (default: false)
    Enable workaround to write 100 Trying sent before session creation to the PCAP file

ip_auth_header (default: X-ORIG-IP)
    Set tech SIP header name to lookup for source IP in the origination pre-auth routine

ip_auth_reject_if_no_matched (default: false)
    Whether to pass origination requests not matched by pre-auth to the DB routing

http_events_destination (default: empty)
    Destination name in the **http_client** module to call HTTP hooks for *started*, *connected*, *disconnected* call events

write_internal_disconnect_code (default: false)
    Add field *disconnect_code_id* with internal call disconnect reason after the *disconnect_rewrited_reason*

postgresql_debug (default: false)
    Log *getprofile*, *cdr*, *auth_log* requests and *getprofile* replies at the debug loglevel

supported_tags (default: {})
    Additional tags to add to the `Supported` header (*timer* and *100rel* will be added automatically by the related handlers)

allowed_methods (default: {INVITE, ACK, BYE, CANCEL, OPTIONS, NOTIFY, INFO, UPDATE, PRACK})
    Methods list to declare in the `Allowed` header

Section **routing**
-------------------

schema (default: switch21)
    Database schema to be added to the search_path in addition to the *public* for the routing connections

function (default: route_release)
    Database function to be called to get call profile

init (default: empty)
    Function to run for routing connection initialization. Usually is used to initialize yeti pg extension to process LNP requests

new_codecs_groups (default: true)
    What function to use for codecs preloading

    * true. use ``load_codec_groups()``
    * false. use ``load_codecs()``

pass_input_interface_name (default: false)
    Add input interface name to the DB routing requests

connection_lifetime (default: 0)
    Force reconnect each `connection_lifetime` seconds for *routing* connections. Used as workaround on memory leaks in PG backends

header(header_name[, sql_type = varchar, [format[, format_param]])
    Add SIP header from initial incoming SIP request to be used for routing DB requests. Function can be used multiple times.
    Overrides ``load_interface_in()`` usage

    .. list-table:: routing.header(...) params
        :header-rows: 1

        * - parameter
          - description
        * - header_name
          - | SIP header name to search in the initial incoming SIP request.
            | name will be normalized: converted to lowercase, ``-`` replaced with ``_``
        * - sql_type (default: varchar)
          - SQL type name for the value in the routing request
        * - format (optional)
          - | parse header and use part specified by **format** as value
            | allowed values:
            | ``uri_user``, ``uri_domain``, ``uri_port``, ``uri_json``, ``uri_param``
            | each **format** value can be suffixed by ``_array`` to get array of the headers instead of the first one.
            | so we have ``uri_user_array`` ... ``uri_param_array`` in addition
        * - format_param (required for ``uri_param``, ``uri_param_array``)
          - uri param name to extract from parsed URI

failover_to_slave (default: false)
    Enable failover for routing DB requests. Slave connections pool is configured in the `routing.slave_pool` subsection

Sub-sections **routing.master_pool**, **routing.slave_pool**
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Connection pools parameters for *routing*

host (default: 127.0.0.1)
    Database host

port (default: 5432)
    Database port

name (default: yeti)
    Database name

user (default: yeti)
    Database user

pass (default: yeti)
    Database password

size (default: 10)
    Connections pool size

check_interval (default: 25)
    Reconnect delay on connection errors in seconds

statement_timeout (default: 5)
    Routing transaction timeout in seconds

Section **cdr**
---------------

pool_size (default: 10)
    Connections pool size

batch_size (default: 50)
    **cdr** count for single transaction. We collect *batch_size* CDRs before writing to optimize database usage

batch_timeout (default: 10000)
    **cdr** batch timeout in milliseconds. Write CDRs after the *batch_timeout* even if *batch_size* is not reached

auth_pool_size (default: 10)
    Connections pool size

auth_batch_size (default: 50)
    **auth_log** count for single transaction

auth_batch_timeout (default: 10000)
    **auth_log** batch timeout in milliseconds

check_interval (default: 25)
    Reconnect and retransmit delay in seconds

connection_lifetime (default: 0)
    Force reconnect each `connection_lifetime` seconds for *cdr*, *auth_log* connections. Used as workaround on memory leaks in PG backends

schema (default: switch)
    Database schema to be added to the search_path in addition to the *public* for the *cdr* and *auth_log* connections

function (default: writecdr)
    Database function to be called to write CDRs (function for *auth_log* is hard-coded to be ``write_auth_log``)

failover_to_slave (default: false)
    Enable failover for *cdr* and *auth_log* DB requests. Slave connections pool is configured in the `cdr.slave` subsection

Sub-sections **cdr.master**, **cdr.slave**
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Connection pools parameters for *cdr* and *auth_log*

host (default: 127.0.0.1)
    Database host

port (default: 5432)
    Database port

name (default: cdr)
    Database name

user (default: cdr)
    Database user

pass (default: cdr)
    Database password

Section **resources**
---------------------

reject_on_error (default: false)
    Whether to reject calls on resources accounting errors (e.g redis availability)

reduce_operations (default: false)
    Merge increments/decrements for the same resources to decrease requests count to redis.
    Recommended value: true. Default is false historically because of testing

scripts_dir (default: /usr/lib/sems/scripts/yeti)
    Directory to lookup for resources management redis LUA scripts


Sub-sections **resources.read**, **resources.write**
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Redis connections configuration for resources

hosts (default: 127.0.0.1:6379)
    Endpoint for redis connections

timeout (default: 5000)
    Timeout for redis requests in milliseconds

username (default: empty)
    username for redis ``AUTH`` command

password (default: empty)
    password for redis ``AUTH`` command

Section **lega_cdr_headers**
----------------------------

header(header_name, sql_type: none|string|array|smallint|integer [, active_call_key, active_call_key_type = String])
    Add SIP header value from initial incoming SIP request to be saved in CDR. Function can be used multiple times

    .. list-table:: lega_cdr_headers.header(...) params
        :header-rows: 1

        * - parameter
          - description
        * - header_name
          - | SIP header name to search in the initial incoming SIP request.
            | Name will be normalized: converted to lowercase, ``-`` replaced with ``_``
        * - sql_type (default: varchar)
          - SQL type name for the value in CDR writing request. `none` means skip saving to CDR and used together with **active_call_key**
        * - active_call_key (optional)
          - field name to add header value to the active calls and statistics snapshots (see: **statistics** section)
        * - active_call_key_type (required for **active_call_key**)
          - active call key type name. only ``String`` is allowed for now

add_sip_reason (default: false)
    Parse **Reason** header from legA BYE request.
    Save serialized SIP cause, text, params as value for 'reason' field in legA headers CDR field

add_q850_reason (default: false)
    Parse **Reason** header from legA BYE request.
    Save serialized Q.850 cause, text, params as value for 'reason' field in legA headers CDR field

Section **legb_cdr_headers**
----------------------------

header(header_name, sql_type: string|array|smallint|integer)
    Add SIP header value from legB outgoing SIP request to be saved in CDR. Function can be used multiple times

    .. list-table:: legb_cdr_headers.header(...) params
        :header-rows: 1

        * - parameter
          - description
        * - header_name
          - | SIP header name to search in the SIP requests sent from legB.
            | Name will be normalized: converted to lowercase, ``-`` replaced with ``_``
        * - sql_type (default: varchar)
          - SQL type name for the value in CDR writing request.

Section **legb_response_cdr_headers**
-------------------------------------

header(header_name, sql_type: string|array|smallint|integer)
    Add SIP header value from legB 200 OK reply to be saved in CDR. Function can be used multiple times

    .. list-table:: legb_response_cdr_headers.header(...) params
        :header-rows: 1

        * - parameter
          - description
        * - header_name
          - | SIP header name to search in the Bleg 200 OK SIP reply.
            | Name will be normalized: converted to lowercase, ``-`` replaced with ``_``
        * - sql_type (default: varchar)
          - SQL type name for the value in CDR writing request.

add_sip_reason (default: false)
    Parse **Reason** header from legB BYE requests and error/redirect replies (code >= 300).
    Save serialized SIP cause, text, params as value for 'reason' field in legB headers CDR field

add_q850_reason (default: false)
    Parse **Reason** header from legB BYE requests and error/redirect replies (code >= 300).
    Save serialized Q.850 cause, text, params as value for 'reason' field in legB headers CDR field

Section **rpc**
---------------

calls_show_limit (default: 100)
    Active calls limit for **yeti.show.calls** and **yeti.show.calls.filtered** jsonRPC methods output

Section **statistics**
----------------------

Configure periodic reporting of the active calls to the clickhouse.
Set both **clickhouse.table** and **clickhouse.destinations** to enable functionality

Sub-section **statistics.active-calls**
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

period (default: 60)
    Interval between active calls snapshots sending in seconds

Sub-section **statistics.active-calls.clickhouse**
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

table (default: active_calls)
    Clickhouse table name for inserting.
    Resulting query first line will be: *INSERT INTO {table} FORMAT JSONEachRow*

destinations (default: *empty*)
    Destinations names list for the **http_client** module. Destinations should be configured with *mode=post* and *content_type='application/vnd.api+json'*

buffering (default: false)
    Buffer small calls which were started and finished between snapshots and merge them into the nearest snapshot

allowed_fields (default: {})
    Reduce fields for active calls data to the specified ones. Send all available fields if empty

Section **auth**
----------------

Configure authorization for incoming SIP requests

realm (default: *hostname*)
    Set realm to match for SIP digest authorization. Will use *hostname* if not specified

skip_logging_invite_success (default: false)
    Do not write *auth_log* for successfully authorized requests

skip_logging_invite_challenge (default: false)
    Do not write *auth_log* for incoming requests without Authorization header that were challenged with 401 reply
