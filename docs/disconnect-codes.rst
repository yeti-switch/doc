
.. :maxdepth: 2

========================================
YETI Internal disconnect codes
========================================

Звонки могут быть отключены по многим причинам. Некоторые отключаются до маршрутизации, в случае если они не прошли авторизацию или подходящий маршрут не был найден.
В таком случае YETI считает что звонок отключен Траффик Менеджером. В случае проблем с сигнализацией или других низкоуровневых проблем с протоколами - Траффик свитч может инициировать завершение звонка.
Конечно звонки могут завершаться в нормальном режиме и по запросам оригинатора или терминатора.

Инициатор завершения звонка записываться в CDR в поле **Disconnect Initiator**.
Ниже приведены типичные дисконнек коды для звонков которые были разъединены YETI.


Traffic Manager disconnect codes
--------------------------------

No response from LNP DB
    LNP database no responds in-time. Call dropped with such reason if **DROP CALL IF LNP FAIL=TRUE** in **Global configuration**
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
Ringing timeout
    
SDP inv streams types
    
SDP invalid streams count
    
SDP empty answer
    
SDP parsing failed
    
SDP processing exception
    
Codecs not matched
    
Codecs group $cg not found
    
SIP transaction timeout
    
Internal Error
    
Session Timeout
    
NoPrack
    
NoAck
    
Rtp timeout
    
db base exception
    
db conversion exception
    
db broken connection
    
failed to get active connection
    
profile evaluation failed
    
read from tuple failed
    
empty response from database
    
no such prepared query
    
cant parse Contact in req
    
cant parse To in req
    
cant parse From in req
    
    
