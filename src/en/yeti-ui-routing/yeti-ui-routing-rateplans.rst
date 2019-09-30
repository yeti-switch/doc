
.. _rateplans:

Rateplans
~~~~~~~~~

Rateplan is tariff used for call originator billing. Each Rateplans can include multiple Destinations that are used for describing billing rates and mode for specific call destination(based on prefix).

**Rateplan**'s attributes:
``````````````````````````

    .. _rateplan_id:

    Id
       Unique Rateplan's identifier.
    Name
        Unique name of Rateplan.

    .. _rateplan_profit_control:

    Profit Control Mode
        Per call
            In this mode Yeti will route calls only in case of receiving some profit from the call or not unprofitable calls. If this mode was chosen Yeti will select :ref:`Dialpeers <dialpeers>` (for routing the call) where price is less or equal (<=) than the price in the :ref:`Destination <destinations>` that was applied for this call.
        No Control
            In this mode Yeti won't control of receiving profit from the call (without comparison price in the applied :ref:`Destination <destinations>` and price in the chosen :ref:`Dialpeer <dialpeers>`).
    Send Quality Alarms To
         This field is used for choosing :ref:`Contact <contacts>` that will be used for sending Quality notifications about all calls that are related to the :ref:`Destinations <destinations>` from this *Ratepalan*. :ref:`Quality notifications configuration <quality_notification_config>` is described in the Destination's attributes description.
    

