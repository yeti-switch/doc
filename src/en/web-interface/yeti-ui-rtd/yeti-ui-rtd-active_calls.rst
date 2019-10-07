
.. _active_calls:

Active calls
~~~~~~~~~~~~

Active calls tool is used for monitoring of active calls in the System. Calls can be represented in the form of table (with providing full information) or in the form of graph together with list of calls (with providing short information).
It is possible to request filtering before showing the information about active calls by setting :ref:`Active Calls Require Filter <system_global_configuration_active_calls_require_filter>` parameter in the :ref:`Global configuration <global_configuration>`.
It is also possible add (or remove) graph from the screen by changing :ref:`Active Calls Show Chart <system_global_configuration_active_calls_show_chart>` parameter in the :ref:`Global configuration <global_configuration>` and enable (or disable) automatic update mode by changing :ref:`Active Calls Autorefresh Enable  <system_global_configuration_active_calls_autorefresh_enable>` parameter in the :ref:`Global configuration <global_configuration>`.

**Active call**'s filtering parameters:
```````````````````````````````````````
    Node
        :ref:`Node <nodes>` (independent installation of YETI-SEMS) that will be used for filtering active calls. In case of specification - only calls from selected node will be shown. For monitoring calls from all :ref:`Nodes <nodes>`, please, choose "Any" in this field.
    Destination Country
        :ref:`Destination Country <countries>` that will be used for filtering active calls. In case of specification - only calls that are identified by destination number & international country code as calls that are related to the selected country will be shown. For monitoring calls to all :ref:`Destination Country <countries>`, please, choose "Any" in this field.
    Destination Network
        :ref:`Destination Network <networks>` that will be used for filtering active calls. In case of specification -  only calls that are identified by destination number & network prefix as calls that are related to the selected Network (Carrier) will be shown. For monitoring calls to all :ref:`Destination Networks <countries>`, please, choose "Any" in this field.
    Vendor
        :ref:`Vendor <contractors>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Vendor will be shown. For monitoring calls via all :ref:`Vendors <contractors>`, please, choose "Any" in this field.
    Customer
        :ref:`Customer <contractors>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Customer will be shown. For monitoring calls from all :ref:`Customers <contractors>`, please, choose "Any" in this field.
    Vendor Account
        :ref:`Vendor Account <accounts>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Account will be shown. For monitoring calls related to all :ref:`Accounts <accounts>`, please, choose "Any" in this field.
    Customer Account
        :ref:`Customer Account <accounts>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Account will be shown. For monitoring calls related to all :ref:`Accounts <accounts>`, please, choose "Any" in this field.
    Orig GW
        :ref:`Origination Gateway <gateways>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Gateway will be shown. For monitoring calls related to all :ref:`Gateways <gateways>`, please, choose "Any" in this field.
    Term GW
        :ref:`Termination Gateway <gateways>` that will be used for filtering active calls. In case of specification -  only calls that are related to selected Gateway will be shown. For monitoring calls related to all :ref:`Gateways <gateways>`, please, choose "Any" in this field.
    Duration
        Duration of calls in seconds. This field will be used for filtering active calls by duration. It is possible to use statement for this field (equals, greater than, less than). For monitoring calls independently from this parameter just leave it empty.


