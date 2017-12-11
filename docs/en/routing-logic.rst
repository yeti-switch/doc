.. :maxdepth: 2

=============
Routing logic
=============

:Site: https://yeti-switch.org/

Customer call authorization
~~~~~~~~~~~~~~~~~~~~~~~~~~~

First step of call processing is authorization. Yeti will find the most suitable auth record for every calls.
Yeti do it in two steps

    * filtering to remove unsuitable records
    * sort records to find best one
 
After filtering find records where:

    * IP address/mask covers call originator IP
    * transport protocol is empty OR transport protocol is equal to call transport protocol
    * DST and SRC prefixes covers caller_id and destination numbers of incoming INVITE(empty prefix covers any number)
    * POP is empty OR POP is equals to POP where call received
    * X-Yeti-Auth is empty OR X-Yeti-Auth equals to X-Yeti-Auth header from incoming INVITE
    * uri_domain/to_domain/from_domain is empty OR equals to corresponding headers from incoming INVITE
    * destination number length between dst_number_min_length and dst_number_max_length
    * Contractor is enabled AND origination enabled for customer
 
  
Customer auth record lookup SQL:

.. code-block:: sql
   :name: test

    SELECT into v_customer_auth ca.*
        from class4.customers_auth ca
          JOIN public.contractors c ON c.id=ca.customer_id
        WHERE ca.enabled AND
              ca.ip>>=INVITE_SOURCE_IP AND
              prefix_range(ca.dst_prefix)@>prefix_range(INVITE_DST_NUMBER) AND
              prefix_range(ca.src_prefix)@>prefix_range(INVITE_SRC_NUMBER) AND
              (ca.pop_id=POP_ID or ca.pop_id is null) and
              COALESCE(ca.x_yeti_auth,'')=INVITE_X_YETI_AUTH AND
              COALESCE(nullif(ca.uri_domain,'')=INVITE_RURI_DOMAIN,true) AND
              COALESCE(nullif(ca.to_domain,'')=INVITE_TO_DOMAIN,true) AND
              COALESCE(nullif(ca.from_domain,'')=INVITE_FROM_DOMAIN,true) AND
              (ca.transport_protocol_id is null or ca.transport_protocol_id=TRANSPORT_PROTOCOL_ID) AND
              length(INVITE_DST_NUMBER) between ca.dst_number_min_length and ca.dst_number_max_length and
              c.enabled and c.customer
        ORDER BY
          masklen(ca.ip) DESC,
          ca.transport_protocol_id is null,
          length(prefix_range(ca.dst_prefix)) DESC,
          length(prefix_range(ca.src_prefix)) DESC,
          ca.pop_id is null,
          ca.uri_domain is null,
          ca.to_domain is null,
          ca.from_domain is null
        LIMIT 1;

INVITE_SOURCE_IP
INVITE_SRC_NUMBER
POP_ID
INVITE_X_YETI_AUTH
INVITE_RURI_DOMAIN
INVITE_TO_DOMAIN
INVITE_FROM_DOMAIN
TRANSPORT_PROTOCOL_ID
INVITE_DST_NUMBER   
    
    
    
Originator balance checking
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Number rewrites
~~~~~~~~~~~~~~~

Numberlist processing
~~~~~~~~~~~~~~~~~~~~~

Routing tag detection
~~~~~~~~~~~~~~~~~~~~~

LNP database Lookup
~~~~~~~~~~~~~~~~~~~

Destination Lookup
~~~~~~~~~~~~~~~~~~

.. code-block:: sql

        SELECT into v_destination d.*/*,switch.tracelog(d.*)*/ from class4.destinations d
        WHERE
          prefix_range(prefix)@>prefix_range(v_routing_key)
          AND length(v_routing_key) between d.dst_number_min_length and d.dst_number_max_length
          AND rateplan_id=v_customer_auth.rateplan_id
          AND enabled
          AND valid_from <= v_now
          AND valid_till >= v_now
          AND (routing_tag_id IS null or v_ret.routing_tag_id is null or routing_tag_id = v_ret.routing_tag_id)
        ORDER BY length(prefix_range(prefix)) DESC, routing_tag_id is null limit 1;
        

Dialpeer Lookup
~~~~~~~~~~~~~~~


Passing routing results to switch node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        
        




