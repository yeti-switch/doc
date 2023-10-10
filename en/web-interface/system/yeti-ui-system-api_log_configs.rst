
.. _api_log_configs:

Api Log Configs
~~~~~~~~~~~~~~~

Api Log Configs are used for setting (where necessary) Debug mode for storing additional info to the :ref:`API Log <api_logs>`.
You can create specific API Log Configs or delete them from Admin UI.

The Api Log Configs is a part of our system that enables the configuration of :ref:`API logging <api_logs>` behavior.
It defines how API requests and responses are logged and whether debugging information is captured for specific API controllers.

**Api Log Config**'s properties:
````````````````````````````````
    Controller
        Controller that will be used for applying of the Debug mode of storing records to the :ref:`API Log <api_logs>` in case of enabling Debug property bellow.

Best Practices:
```````````````
Use API log configurations rationally to capture logs only for controllers that require detailed logging.
Regularly review and update API log configurations as your application evolves to maintain an accurate log management strategy.
