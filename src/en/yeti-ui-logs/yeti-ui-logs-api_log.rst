
.. _api_logs:

API Log
~~~~~~~

API Log contains records about all requests via Application Programming Interface (API) to the System from external clients or from internal cron procedures. It is possible to use filters to select necessary records.

**Log Record**'s properties:
````````````````````````````
    Created At
        Date and time of request.
    Status
        Status of operation (HTTP-response code).
    Method
        HTTP-request (PUT, GET, POST, DELETE) method that was used for this API-request.
    Path
        Relative path to requested procedure.
    DB Duration
        Duration (im milliseconds) of processing request by Database.
    Page Duration
        Total response time (im milliseconds).
    Controller
        Controller that is contained procedure that was requested.
    Action
        Name of requested procedure.
    Params
        Parameters that were sent with request.
    Request Body
        Body of request in raw format. This field will be recorded only in case of enabling "Debug" mode for the selected Controller in the :ref:`Api Log Configs <api_log_configs>` configuration menu.
    Response Body
        Body of response in raw format. This field will be recorded only in case of enabling "Debug" mode for the selected Controller in the :ref:`Api Log Configs <api_log_configs>` configuration menu.
    Request Headers
        Headers of request in raw format. This field will be recorded only in case of enabling "Debug" mode for the selected Controller in the :ref:`Api Log Configs <api_log_configs>` configuration menu.
    Response Headers
        Headers of response in raw format. This field will be recorded only in case of enabling "Debug" mode for the selected Controller in the :ref:`Api Log Configs <api_log_configs>` configuration menu.


