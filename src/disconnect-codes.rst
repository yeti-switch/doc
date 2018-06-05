
.. :maxdepth: 2

==============================
Internal disconnect codes
==============================

Calls can be disconnected due to many reasons.
Some calls can be disconnected even before any attempt of routing.

Internal disconnect codes divided into 2 classes by their sources:

    #. Traffic Manager
        Initiator of disconnection is traffic management layer.
        It can be failed authorization, no appropriate route, etc.
    #. Traffic Switch
        Initiator of disconnection is traffic switch.
        It can be various low-level exceptions,  codecs negotiation errors,
        protocols errors, timeouts, etc.

Initiator of disconnection is written in CDR to the field **Disconnect Initiator**.

Possible values for **Disconnect Initiator**:

    * Traffic Manager (database)
    * Traffic Switch (node)
    * Termination (call terminated by callee)
    * Origination (call terminated by caller)

Next sections contains typical internal disconnect codes

Traffic Manager disconnect codes
--------------------------------

No response from LNP DB
    LNP database no responded in-time.

    Call dropped with such reason if **DROP CALL IF LNP FAIL=TRUE** in **Global configuration**
Source number blacklisted
    Source blacklist enabled at **customer auth** record. And source number found in blacklist.
Destination number blacklisted
    Destination blacklist enabled at **customer auth** record. And destination number found in blacklist.
Not enough customer balance
    Customer account has not enough money
No routes
    System can't route a call because no appropriate routes found
Rejected by destination
    Destination used by call has flag **Reject Calls**
Cant find destination prefix
    System can't find  appropriate destination in rateplan
Cant find customer or customer locked
    Call not authenticated. You need add Customer Auth record.

Traffic Switch disconnect codes
-------------------------------

Internal Error $code
    Node generated internal error and there is no appropriate entry in database.
    In other words: internal error were not resolved.
    It's a bug or versions mismatch between node and database.
Ringing timeout
    Timeout of the timer which was set with appropriate :ref:`gateway attribute <gateway_ringing_timeout>`
SDP inv streams types
    Stream type in answer differ from appropriate stream type in offer
SDP invalid streams count
    Streams number in answer differ from offered streams number
SDP empty answer
    Got SDP without streams.
SDP parsing failed
    Malformed SDP body. Check SIP traces and node debug logs for details.
SDP processing exception
    Something happened during parsed SDP processing.
    Check SIP traces and node debug logs for details.
Codecs not matched
    No intersection between codecs in codec group and codecs in SDP offer.
Codecs group $cg not found
    Codec group with id $cg is not configured on node.
    Usually it means that codec groups on the node are not not synchronized with database.
    You have to reload codecs group from cli or restart node. Also check reload events propagation.
SIP transaction timeout
    SIP timer B fired
Session Timeout
    Sip Session Timer timeout
NoPrack
    Timeout of PRACK for `100 Trying` on enabled rel100
NoAck
    Timeout of ACK for any response
Rtp timeout
    No RTP detected for call on configured interval. see gateways.
db base exception
    Node got exception from database on routing request.
    Check node and database logs.
db conversion exception
    Node got conversion exception from database backend. Check node logs.
db broken connection
    Node can't connect to database. Check node alarms and database state
failed to get active connection
    Node failed to get database connection from connections pool within configured time interval.
    Check the connection to the database and load on the system.
profile evaluation failed
    Evaluation of one of call profiles received from database failed.
    This error can be generated on `resources` or outbound interface evaluation.
read from tuple failed
    Mandatory field missed in tuple from database. Check node debug logs.
empty response from database
    Database returned 0 rows. Bug in management layer.
no such prepared query
    It's definitely a bug. Prepared queries differs from tried to invoke.
    Please, collect logs and contact with developers.
cant parse Contact in req
    Failed to parse `Contact` header in initial INVITE request. Check traces and node logs for details.
cant parse To in req
    Failed to parse `To` header in initial INVITE request. Check traces and node logs for details.
cant parse From in req
    Failed to parse `From` header in initial INVITE request. Check traces and node logs for details.
Radius response timeout
    No response received from RADIUS server
Radius request error
    YETI can't send request(socket error, etc)
Invalid radius profile
    Invalid radius profile configured
Invalid radius response
    RADIUS responce has unexpected format
Radius reject
    RADIUS servers send Access-Reject
    
