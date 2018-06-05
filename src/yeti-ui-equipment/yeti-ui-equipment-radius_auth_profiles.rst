
RADIUS Auth Profiles
~~~~~~~~~~~~~~~~~~~~

Yeti supports additional authorization of incoming call on external RADIUS (Remote Authentication Dial-In User Service) server. RADIUS Auth Profile describes communication with that server.

.. note:: module **radius_client** should be loaded to use such feature

**RADIUS Auth Profile**'s attributes:
`````````````````````````````````````
    Id
        Unique RADIUS Auth Profile's id.
    Name
        Unique name of Auth profile.
        Uses for informational purposes and doesn't affect system behaviour.
    Server
        IP address or hostname of external RADIUS server.
    Port
        UDP port on which RADIUS server wait for requests.
    Secret
        Password for Authorization procedure on external RADIUS server.
    Reject on error
        If enabled, in case of error in communication with external RADIUS server (timeout, bad format of response, etc) a call will be considered as authorized and YETI will do further routing procedure.
        If disabled, in case of error in communication with external RADIUS server (timeout, bad format of response, etc) a call will be discarded with appropriate code.
    Timeout
        Timeout of request after which a request will be repeated (millisecond).
    Attempts
        Maximum amount of of requests for every call.

.. _auth_profile_attributes:

    Auth profile attributes
        RADIUS Attributes for including specific authentication, authorization, information and configuration details to the requests and replies. General amount of attributes is regulated by total length of the RADIUS packet (see: `RFC 2865:   Remote Authentication Dial In User Service (RADIUS) <https://tools.ietf.org/html/rfc2865>`_).

        -   Type
            The Type of the RADIUS attribute (decimal value between 0 and 255). Regarding to the `RFC 2865:  Remote Authentication Dial In User Service (RADIUS) <https://tools.ietf.org/html/rfc2865>`_ values 192-223 are reserved for experimental use, values 224-240 are reserved for implementation-specific use, and values 241-255 are reserved and should not be used. A RADIUS server and client MAY ignore Attributes with an unknown Type.
        -   Name
            Name of attribute. It uses for information only and doesn't transfer in the RADIUS packet.
        -   Is vsa
            If this checkbox is enabled it indicates that it is Vendor Specific Attribute and doesn't described by `RFC 2865 -  Remote Authentication Dial In User Service (RADIUS) <https://tools.ietf.org/html/rfc2865>`_.
        -   Vsa vendor
            Decimal value (between 0 and (2^32 - 1)) of the Vendor's ID in the attribute. In the `RFC 2865 -  Remote Authentication Dial In User Service (RADIUS) <https://tools.ietf.org/html/rfc2865>`_ - the high-order octet is 0 and the low-order 3 octets are the SMI Network Management Private Enterprise Code of the Vendor in network byte order.
        -   Vsa vendor type
            Decimal value (between 0 and 255) of the specific Vendor type of attribute.
        -   Value
            String that is used as template for filling value of RADIUS Attribute with using pre-defined placeholders (variables) that are described in note bellow. It is possible to combine several placeholders together with pre-defined text to one string. Resulting value will be converted to the data of necessary *Format* (see below). In case of impossibility to convert resulting value to necessary *Format* an error will be occurred.

        .. note:: Example of filling *Value* field: Destination ID: $destination_id$ ; DialPeer ID: $dialpeer_id$

        -   Format
            The resulting format of the *Value* field. It is one of six data types: string (1-253 octets containing binary data (values 0 through 255 decimal, inclusive) - often used for printable text strings), octets (1-253 octets containing binary data (values 0 through 255 decimal, inclusive) - often used for binary data), ipaddr (32 bit value, most significant octet first), integer (32 bit unsigned value, most significant octet first), date (32 bit unsigned value, most significant octet first -- seconds since 00:00:00 UTC, January 1, 1970), ip6addr (128 bit value, most significant octet first).
        -   Remove
            This control element can be used for removing existing Auth profile attribute. Auth profile attribute will be removed after saving changes (by clicking Update Auth profile) in case of enabling this checkbox.


    .. note:: Currently following variables (placeholders) are supported in the Yeti's auth profiles:

       -    $src_number_radius$ - Source (A) number (string) of current call.
       -    $dst_number_radius$ - Destination (B) number (string) of current call.
       -    $orig_gw_name$ - Value of the :ref:`*Name* <gateway_name>` attribute (string) of Gateway that is used as Originator for current call.
       -    $customer_auth_name$ - Value of the :ref:`*Name* <customer_auth_name>` attribute (string) of the Customer Auth.
       -    $customer_name$ - Value of the :ref:`*Name* <contractor_name>` attribute (string) of the Customer Contractor.
       -    $customer_account_name$ - Value of the :ref:`*Name* <account_name>` attribute (string) of Account that is associated with Customer for current call.
       -    $term_gw_name$ - Value of the :ref:`*Name* <gateway_name>` attribute (string) of Gateway that is used as Terminator for current call.
       -    $orig_gw_external_id$ - Value of the :ref:`*External* <gateway_external>` attribute (integer) of Gateway that is used as Originator for current call.
       -    $term_gw_external_id$ - Value of the :ref:`*External* <gateway_external>` attribute (integer) of Gateway that is used as Originator for current call.
       -    $fake_180_timer$ - Value (in ms) of the :ref:`*Fake 180 timer* <gateway_fake_180_timer>` attribute (integer) of Gateway that is used as Terminator for current call.
       -    $customer_id$ - Value of the :ref:`*ID* <contractor_id>` attribute (integer) of the Customer Contractor for current call.
       -    $vendor_id$ - Value of the :ref:`*ID* <contractor_id>` attribute (integer) of the Vendor Contractor for current call.
       -    $customer_acc_id$ - Value of the :ref:`*ID* <account_id>` attribute (integer) of Account that is associated with Customer for current call.
       -    $vendor_acc_id$ - Value of the :ref:`*ID* <account_id>` attribute (integer) of Account  that is associated with Vendor for current call.
       -    $customer_auth_id$ - Value of the :ref:`*ID* <customer_auth_id>` attribute (integer) of the Customer Auth.
       -    $destination_id$ - Value of the :ref:`*ID* <destination_id>` attribute (integer) of the Destination for current call.
       -    $destination_prefix$ - Value of the :ref:`*Prefix* <destination_prefix>` attribute (string) of the Destination for current call.
       -    $dialpeer_id$ - Value of the :ref:`*ID* <dialpeer_id>` attribute (integer) of the Dialpeer for current call.
       -    $dialpeer_prefix$ - Value of the :ref:`*Prefix* <dialpeer_prefix>` attribute (string) of the Dialpeer for current call.
       -    $orig_gw_id$ - Value of the :ref:`*ID* <gateway_id>` attribute (integer) of Gateway that is used as Originator for current call.
       -    $term_gw_id$ - Value of the :ref:`*ID* <gateway_id>` attribute (integer) of Gateway that is used as Terminator for current call.
       -    $routing_group_id$ - Value of the :ref:`*ID* <routing_group_id>` attribute (integer) of Routing Group for current call.
       -    $rateplan_id$ - Value of the :ref:`*ID* <rateplan_id>` attribute (integer) of Rateplan for current call.
       -    $destination_initial_rate$ - Value of the :ref:`*Initial Rate* <destination_initial_rate>` attribute (floating point number) of Destination for current call.
       -    $destination_next_rate$ -  Value of the :ref:`*Next Rate* <destination_next_rate>` attribute (floating point number) of Destination for current call.
       -    $destination_initial_interval$ - Value of the :ref:`*Initial Interval* <destination_initial_interval>` attribute (floating point number) of Destination for current call.
       -    $destination_next_interval$ - Value of the :ref:`*Next Interval* <destination_next_interval>` attribute (floating point number) of Destination for current call.
       -    $destination_rate_policy_id$ - Value of the :ref:`*Rate policy* <rate_policy_id>` attribute (integer) of Destination for current call (1 - Fixed, 2 - Based on used dialpeer, 3 - MIN(Fixed,Based on used dialpeer), 4 - MAX(Fixed,Based on used dialpeer)).
       -    $dialpeer_initial_interval$ - Value of the :ref:`*Initial Interval* <dialpeer_initial_interval>` attribute (floating point number) of Dialpeer for current call.
       -    $dialpeer_next_interval$ - Value of the :ref:`*Next Interval* <dialpeer_next_interval>` attribute (floating point number) of Dialpeer for current call.
       -    $dialpeer_next_rate$ - Value of the :ref:`*Next Rate* <dialpeer_next_rate>` attribute (floating point number) of Dialpeer for current call.
       -    $destination_fee$ - Value of the :ref:`*Connect fee* <destination_connect_fee>` attribute (floating point number) of Destination for current call.
       -    $dialpeer_initial_rate$ - Value of the :ref:`*Initial Rate* <dialpeer_initial_rate>` attribute (floating point number) of Dialpeer for current call.
       -    $dialpeer_fee$ - Value of the :ref:`*Connect fee* <dialpeer_connect_fee>` attribute (floating point number) of Dialpeer for current call.
       -    $dst_prefix_in$ - Destination number (B-number) that is received from Gateway that is used as Originator for current call (string).
       -    $dst_prefix_out$ - Destination number (B-number) that is sent to Gateway that is used as Terminator for current call (string).
       -    $src_prefix_in$ - Source number (A-number) that is received from Gateway that is used as Originator for current call (string).
       -    $src_prefix_out$ - Source number (A-number) that is sent to Gateway that is used as Terminator for current call (string).
       -    $src_name_in$ - Name of caller that is received in the "From" field of SIP header from Gateway that is used as Originator for current call (string).
       -    $src_name_out$ - Name of caller that is sent in the "From" field of SIP header to Gateway that is used as Terminator for current call (string).
       -    $diversion_in$ - Value of SIP Diversion header that is received from Gateway that is used as Originator for current call (string).
       -    $diversion_out$ - Value of SIP Diversion header that is sent to Gateway that is used as Terminator for current call (string).
       -    $auth_orig_protocol_id$ - Protocol (integer) that is used for interconnection with Gateway that is used as Originator for current call (1 - UDP, 2 - TCP).
       -    $auth_orig_ip$ - IP-address of Gateway (that was received during SIP AUTH stage) that is used as Originator for current call (string).
       -    $auth_orig_port$ - TCP or UDP port number that was used for sending of signaling information from Gateway that is used as Originator for current call (integer).
       -    $dst_country_id$ - Value of the :ref:`*ID* <country_id>` attribute (integer) of Country that is associated (via  Network Prefixes table) with the destination number (B-number) for current call.
       -    $dst_network_id$ - Value of the :ref:`*ID* <network_id>` attribute (integer) of Network that is associated (via  Network Prefixes table) with the destination number (B-number) for current call.
       -    $dst_prefix_routing$ - Prefix of the destination number (B-number) that was used for routing  for current call.
       -    $src_prefix_routing$ - Prefix of the source number (A-number) that was used for routing  for current call.
       -    $routing_plan_id$ - Value of the :ref:`*ID* <routing_plan_id>` attribute (integer) of Routing Plan for current call.
       -    $lrn$ - Routing number that was received from LNP database (in case of requesting) for current call.
       -    $lnp_database_id$ - Value of the :ref:`*ID* <lnp_database_id>` attribute (integer) of LNP Database that is used for current call.
       -    $from_domain$ - Domain of caller that is received in the "From" field of SIP header from Gateway that is used as Originator for current call (string).
       -    $to_domain$ - Domain of callee that is received in the "To" field of SIP header from Gateway that is used as Originator for current call (string).
       -    $ruri_domain$ - Domain that is received in the "R-URI" field of SIP header from Gateway that is used as Originator for current call (string).
       -    $src_area_id$ - Value of the :ref:`*ID* <area_id>` attribute (integer) of Area that is associated (via  Area Prefixes table) with the source number (A-number) for current call.
       -    $dst_area_id$ - Value of the :ref:`*ID* <area_id>` attribute (integer) of Area that is associated (via  Area Prefixes table) with the destination number (B-number) for current call.
       -    $routing_tag_id$ - Value of the :ref:`*ID* <routing_tag_id>` attribute (integer) of Routing tag that is associated (via Routing tag detection table) with both source and destination Areas for current call.
       -    $pai_in$ - P-Asserted-Identity (PAI) privacy field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $ppi_in$ - P-Preferred-Identity (PPI) privacy field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $privacy_in$ - SIP Privacy field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $rpid_in$ - Remote Party ID field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $rpid_privacy_in$ - SIP RPID Privacy field of SIP header that was received from Gateway that is used as Originator for current call (string).
       -    $pai_out$ - P-Asserted-Identity (PAI) privacy field of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $ppi_out$ - P-Preferred-Identity (PPI) privacy field of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $privacy_out$ - SIP Privacy field of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $rpid_out$ - Remote Party ID field of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $rpid_privacy_out$ - SIP RPID Privacy of SIP header that was sent to Gateway that is used as Terminator for current call (string).
       -    $customer_acc_check_balance$ - State of :ref:`*Check account balance* <customer_check_account_balance>` flag (0 - disabled, 1 - enabled) of Customers Auth for current call.
       -    $destination_reverse_billing$ - State of :ref:`*Reverse billing* <destination_reverse_billing>` flag (0 - disabled, 1 - enabled) of Destination for current call.
       -    $dialpeer_reverse_billing$ - Value of the :ref:`*Reverse billing* <dialpeer_reverse_billing>` attribute (boolean) of Dialpeer for current call.

    To enable additional RADIUS authorization you should set Radius Auth Profile at Customer Auth object.

.. note:: YETI doesn't support interaction with external routing engines via RADIUS protocol.


