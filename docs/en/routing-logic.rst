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

    SELECT ca.*
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
    IP address of call originator
INVITE_SRC_NUMBER
    Source phone number. Yeti use user part of From header as source phone number
POP_ID
    POP where call is received
INVITE_X_YETI_AUTH
    Value of X-Yeti-Auth header from incoming INVITE request.
INVITE_RURI_DOMAIN
    R-URI domain part from incoming INVITE request
INVITE_TO_DOMAIN
    To URI domain part from incoming INVITE request
INVITE_FROM_DOMAIN
    From URI domain part
TRANSPORT_PROTOCOL_ID
    Transport protocol of incoming INVITE request
INVITE_DST_NUMBER
    Destination number.  Yeti use user part of R-URI as destination phone number
    
    
    
Originator balance checking
~~~~~~~~~~~~~~~~~~~~~~~~~~~
When Customer Auth record for call found YETI perform customer's account balance cheking. If balance value less then min_balance treshold call will be rejected with error "403 Not enough customer balance"

Number rewrites
~~~~~~~~~~~~~~~
If Customer Auth record contains number translation rules, YETI will apply them.

Numberlist processing
~~~~~~~~~~~~~~~~~~~~~
If Customer Auth record configured to apply SRC or DST numberlists to call, YETI will try found numberlist item and apply actions defined at item.
If no item found then default Numberlist actions applied.

Routing tag detection
~~~~~~~~~~~~~~~~~~~~~
Yeti allows find routes(Dialpeers) and rates(Destinations) by destination number and Routing tag. Routing tag allows for example bill customer based on call origination area - for example origin based billing at EU.

For every call YETI detects source and destination Areas. Source area detected by lookup Routing Area Prefixes using longest match for prefix that cover SRC Number. Same algorithm used to finding Destination Area. On next step YETI detects rotuing tag by lookup Routing Tag Detection Rules. 

At Routing Tag Detection Rules empty area cover any area.

LNP database Lookup
~~~~~~~~~~~~~~~~~~~

Destination Lookup
~~~~~~~~~~~~~~~~~~
Destination in YETI terms is rate used for customer(originator) billing. For every call YETI will try to find Destination from Rateplan defined at Customer Auth record. Only one destination applied for call. 
If no destination was found YETI will reject call with reason "404 Cant find destination prefix"

Destination lookup SQL:
.. code-block:: sql

        SELECT d.*
        from class4.destinations d
        WHERE
          prefix_range(prefix)@>prefix_range(ROUTING_KEY)
          AND length(ROUTING_KEY) between d.dst_number_min_length and d.dst_number_max_length
          AND rateplan_id=RATEPLAN_ID
          AND enabled
          AND valid_from <= now()
          AND valid_till >= now()
          AND (routing_tag_id IS null or ROUTING_TAG_ID is null or routing_tag_id = ROUTING_TAG_ID)
        ORDER BY length(prefix_range(prefix)) DESC, routing_tag_id is null limit 1;
            
ROUTING_KEY
    Call destination number used for routing.
RATEPLAN_ID
    Rateplan defined at Customer Auth record.
ROUTING_TAG_ID
    Call routing tag, detected on previous step. If Call routing tag is null then only destinations where routing tag is null will be used.
    Destinations with null routing tag allowed for calls with any routing tag.
        

Dialpeer Lookup
~~~~~~~~~~~~~~~


Passing routing results to switch node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        
        




