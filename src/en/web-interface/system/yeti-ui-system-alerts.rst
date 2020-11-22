
Alerts
~~~~~~

Alerts are used for configuring :ref:`Contact <contacts>` or :ref:`Admin User <admin_users>` for sending notifications in case of some Events. Following Events are available for configuration:

    **AccountHighThesholdCleared** - event when the balance of some :ref:`Account <accounts>` has become in norm after was becoming bigger than high threshold. :ref:`Balance high threshold <account_balance_high_threshold>` should be configured for the :ref:`Account <accounts>`;

    **AccountLowThesholdCleared** - event when the balance of some :ref:`Account <accounts>` has become in norm after was becoming less than low threshold. :ref:`Balance low threshold <account_balance_low_threshold>` should be configured for the :ref:`Account <accounts>`;

    **AccountHighThesholdReached** - event when the balance of some :ref:`Account <accounts>` has become bigger than high threshold. :ref:`Balance high threshold <account_balance_high_threshold>` should be configured for the :ref:`Account <accounts>`;

    **AccountLowThesholdReached** - event when the balance of some :ref:`Account <accounts>` has become less than low threshold. :ref:`Balance low threshold <account_balance_low_threshold>` should be configured for the :ref:`Account <accounts>`;

    **DestinationQualityAlarmCleared** - event when one of the quality parameters (Asr, Acd or Short Calls) of some :ref:`Destination <destinations>` has become in norm after were becoming less than :ref:`Asr Limit, Acd Limit or Short Calls Limit <quality_notification_config>` values accordingly;

    **DestinationQualityAlarmFired** - event when one of the quality parameters (Asr, Acd or Short Calls) of some :ref:`Destination <destinations>` has become less than :ref:`Asr Limit, Acd Limit or Short Calls Limit <quality_notification_config>` values accordingly;

    **GatewayLocked** - event when :ref:`Gateway <gateways>` has been locked because threshold  of the quality parameters (Acd limit, Asr limit or Short Calls limit) of the :ref:`Gateway <gateways>` was overcome. In locked mode :ref:`Gateway <gateways>` could not be used for termination of calls.

    **GatewayUnlocked** - event when :ref:`Gateway <gateways>` has been unlocked because quality parameters (Acd limit, Asr limit and Short Calls limit) of the :ref:`Gateway <gateways>` had become in norm;

    **DialpeerLocked** - event when :ref:`Dialpeer <dialpeers>` has been locked because threshold of the quality parameters (Acd Limit, Asr Limit or Short Calls Limit) of the :ref:`Dialpeer <dialpeers>` was overcome. In locked mode :ref:`Dialpeer <dialpeers>` could not be used for routing of calls in case of using *sorting method* with **ACD&ASR control** in the relevant :ref:`Routing Plan <routing_plan>`.

    **DialpeerUnlocked** - event when :ref:`Dialpeer <dialpeers>` has been unlocked because quality parameters (Acd Limit, Asr Limit and Short Calls Limit) of the :ref:`Dialpeer <dialpeers>` had become in norm;


**Alert**'s properties:
```````````````````````
    Id
        Unique Alert's id.
    Event
        Name of Event for this "Alert".
    Send To
        :ref:`Contact <contacts>` or :ref:`Admin User <admin_users>` for sending this *Alert*.


