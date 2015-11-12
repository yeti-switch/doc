Contents:

.. toctree::
    :maxdepth: 3

==================
YETI WEB interface
==================

:Site: https://yeti-switch.org/

.. note::

    Default credentials to login on web-interface after software installation:

    - *login*: **admin**, 
    - *password*: **111111**

Configuration Objects
=====================

Dashboard
---------
Displays different various indicators of the system state:

- active calls graph
- profitability and duration of the calls
- billing status
- state of the system replication

Billing. Contractors
--------------------
Contractor:
    company wich will interact with the system.
Contractor may act as:

    Customer
        use provided call termination service
    Supplier
        provide call termination service

One contractor can be either customer and supplier.

**Contractor** has the following attributes:

    Name
        unique contractor name. mandatory field.
        creation of different contractors with the same name is not allowed
    Enabled
        self-descriptive.
        if flag is off (contractor disabled) this contractor will not be used for routing and billing
    Vendor
        if enabled contractor can act as supplier and system may terminate calls to it
    Customer
        if enabled contractor can act as customer and originate calls to the system
    Description
        optional description of the contractor
    Adress
        optional contractor address
    Phones
        list of phone numbers to contact with contractor
    Smtp Connection
        connection to the mail server which will be used to send mails, invoices and notifications
        (SMTP connection must be configured previously in *System->SMTP connections*)

.. note:: Fields **Description**, **Adress**, **Phones** are informational and not used in routing or billing logic

Billing. Contacts
-----------------
Contact:
    address information about contractor or system operator (contact belongs to the contractor or to the system operator).
All email notification and reports use only addressed which were added to the contacts

**Contact** has the following attributes:

    Contractors:
        choose Contractors if this contact belongs to them
    Admin user:
        administrative user which may own contact
        must be entered Contractors name or Admin user name
    E-mail:
        address for notifications, invoices and other emails
    Notes:
        optional notes

Billing. Accounts
-----------------

Атрибуты аккаунта:

Name
    Уникальное имя аккаунта. Нельзя создавать несколько аккаунтов с одинаковым именем.
Contractors
    Contractors, которому принадлежит данный аккаунт.
Минимальный баланс
    Если текущий баланс становится ниже минимального, трафик, регинированный аккаунтом будет блокирован.
Максимальный баланс
    Если баланс аккаунта превышает максимальный баланс, маршруты, поставляемые этим аккаунтом не будут использоваться при терминации.
Origination capacity
    максимальная оригинационная емкость, которая может быть принята от данного аккаунта. Если количество входящих звонков от аккаунта превышает Regination copasity, трафик будет блокирован.
Termination capacity
    максимальная емкость звонков, которая может быть терминирована на маршруты, принадлежащие этому аккаунту. Если текущая емкость терминации превышает Termination copasity, маршруты этого аккаунта не будут использоваться для новых звонков.
Vendor invoice period
    Период генерации автоматических инвойсов в случае, если аккаунт выступает в качестве поставщика трафика.
Customer invoice period
    Период автоматической генерации инвойсов для данного аккаунта в случае, если аккаунт выступает кастомером.
Vendor invoice template
    Темплейт, который будет использоваться при создании PDF файла-инвойса для инвойса Vendor.
Customer invoice template
    Темплейт, который будет использоваться для создания PDF файла-инвойса в качестве инвойса Customer.
    Темплейты для создания инвойсов можно устроить отдельно в пункте меню Billing.
Sent invoices to 
    список контактов, на которые будут отсылаться сгенерированные инвойсы.
Timezone
    Таймзона, которая будет использоваться при генерации инвойсов и статистики для этого аккаунта.
    
При создании аккаунта его баланс всегда создается нулевым. Изменение баланса аккаунта возможно вследствии выполнения процесса биллинга звонков, а так же путем создания платежа.
При биллинге звонков если аккаунт выступает оригинатором, его баланс уменьшается на стоимость каждого звонка, в случае если же аккаунт является поставщиком услуг - баланс возрастает.
Таким образом каждый звонок приводит к уменьшению баланса оригинационного аккаунта и увеличению баланса терминационного.

    
Billing. Payments
-----------------

Платежи предназначены для изменения баланса аккаунта. При создании платежа сохраняется описание, его точная дата и количество средств.

Account
    Аккаунт на который был осуществлен платеж
Amount
    сумма платежа
Notes
    примечания
Created at
    время создания платежа
    

Equipment. Gateways
-------------------

Enabled
    Флаг определяющий активность гейтвея
Gateway group 
    Гейтвеи могут быть объединены в группы. В случае если гейтвей входит в группу, нужно выбрать ее из списка
Priority
    Приоритет гейтвея в группе. При терминации трафика на группу гейтвеев, трафик будет распределяться на гейтвеи внутри группы согласно приоритета.
Pop
    Точка присутствия, в которой находится гейтвей
Contractor
    Владелец гейтвея
Allow origination
    Флаг определяющий возможность гейтвея оригинировать звонки. 
Allow termination
    Флаг определяющий возможность гейтвея принимать звонки от YETI
Sst enabled
    Флаг включающий использование SIP Session timers. Если флаг выключен то механизм  SIP Session timers будет использован только в случае если его затребует удаленный гейтвей, иначе -  YETI будет требовать использование этого механизма.
Capacity
    емкость, которая может быть маршрутизирована на этот гейтвей если он является терминационным. В случае оригинации, параметр не используется.
Acd limit
    Пороговое значение ACD. Если значение ACD для трафика проходящего через гейтвей опустится ниже порога, то диалпиры использующие гейтвей будут исключены из маршрутизации в случае если используется роутплан с контролем качества.
Asr limit
    Пороговое значение ASR. Если значение ASR для трафика проходящего через гейтвей опустится ниже порога, то диалпиры использующие гейтвей будут исключены из маршрутизации в случае если используется роутплан с контролем качества.
Sensor
    Сенсор, на который реплицировать трафик терминируемый или оригинируемый гейтвеем. Если сенсор не выбран, то репликация не выполняется
Sensor level
    Режим репликации трафика. Возможные значения:
    - Signaling+ RTP
    - RTP
    - Singnaling
Host
    IP адрес или DNS имя удаленного гейтвея, на который YETI будет отсылать сигнальные сообщения SIP. Используется только в случае терминации.
Port
    Порт удаленного гейтвея, на который YETI будет отсылать сигнальные сообщения SIP. Если порт не задан, то сначала выполняется попытка резолва SRV записи для DNS имени хоста, если попытка не успешна, то используется стандартный порт 5060. Таким образом для включения DNS SRV необходимо оставить поле порт пустым.
Resolve ruri
    Если флаг включен и в поле Host задано DNS имя, то RURI Invite запроса к удаленному гейтвею будет вида user@1.1.1.1, где 1.1.1.1 — ip соответствующий DNS имени. Иначе — в качестве доменной части URI будет использоваться непосредственно DNS имя
Diversion policy
    Политика обработки поля Diversion
Diversion rewrite rule
    
Diversion rewrite result
    
Src name rewrite rule
    
Src name rewrite result
    
Src rewrite rule
    
Src rewrite result
    
Dst rewrite rule
    
Dst rewrite result
    
Auth enabled
    
Auth user
    
Auth password
    
Auth from user
    
Auth from domain
    
Term use outbound proxy
    
Term force outbound proxy
    
Term outbound proxy

Term next hop for replies
    
Term next hop
    
Term disconnect policy
    
Term append headers req
    
Sdp alines filter type
    
Sdp alines filter list
    
Ringing timeout
    Таймаут между получением сообщений 18x и 200OK. В случае если сообщение 200OK не получено в течении этого таймаута, попытка маршрутизации прекращается, и генерируется CDR с соответствующим дисконнект кодом. В зависимости от конфигурации дисконнект полиси, может продолжаться рероутинг либо нет.
Relay options
    Прозрачная передача In-dialog OPTIONS запросов между ногами звонка
Relay reinvite
    Прозрачная передача In-dialog re-INVITE запросов между ногами звонка
Relay hold
    Прозрачная передача In-dialog  re-INVITE hold запросов между ногами звонка
Relay prack
    Прозрачная передача In-dialog PRACK запросов между ногами звонка
Allow 1xx without to tag
    включает нарушающее стандарты поведение, когда YETI успешно обрабатывает полученные от удаленного гейтвея сообщения 1xx не содержащие to-tag.
Sip timer b
    значение SIP B timer определяет время в течении которого будет осуществляться ретрансмит SIP INVITE сообщений в случае если на них нет ответа. По истечению этого таймера попытка маршрутизции прекращается, генерируется CDR с соответствующим дисконнект кодом.В зависимости от конфигурации дисконнект полиси, может продолжаться рероутинг либо нет.
Dns srv failover timer
    таймер определяющий через какое время переключаться на следующий DNS SRV адрес в случае если  нет ответа на SIP INVITE сообщение. Значение этого таймера должно быть меньше  значения Sip timer b иначе переключения на следующий адрес не произойдет.
Sdp c location
    Положение C-line в SDP в сообщениях генерируемых YETI. Возможные значения:
    - On media level
    - On session level
    - On session and media level
Codec group
    группа кодеков которая будет использована при работе с данным гейтвеем
Anonymize sdp
    анонимизация SDP позволяет не передавать на другой лег звонка данные о владельце сесии в SDP
Proxy media
    Флаг определяющий режим обработки RTP. Если включено — YETI будет проксировать RTP трафик, в таком режиме возможен транскодинг. Иначе — RTP не будет обрабатываться YETI и будет проходить напрямую от оригинационного гейтвея к терминационному.
Single codec in 200ok
    Если включен данный флаг, то для этого гейтвея YETI будет отсылать в сообщениях 200OK только один кодек(не считая telephone-event), для гарантированного согласования верного кодека.
Transparent seqno
    прозрачная передача RTP SEQ number
Transparent ssr
    прозрачная передача RTP SSRC
Force symmetric rtp
    принудительное включени режима  symmetric rtp. В этом режиме YETI изучит адрес, на который слать RTP не путем согласования  SDP а из первого RTP/RTCP пакета пришедшего от гейтвея. Если флаг отключен, то режим  symmetric rtp будет включен только при явном наличии NAT.
Symmetric rtp nonstop
    Позволить не выключать  symmetric rtp после получения первого пакета, а переключаться на новый адрес всякий раз когде YETI получит RTP от нового адреса.
Symmetric rtp ignore rtcp
    Флаг позволяющий отключить влияние RTCP пакетов на изучение адреса.
Force dtmf relay
    Включение режима прямой пересылки DTMF, без обработки DTMF средствами YETI
Dtmf send mode
    Режим в котором YETI будет слать DTMF сообщения к гейтвею. Возможные варианты:
     -   Disable sending 
     -   RFC 2833
     -   SIP INFO application/dtmf-relay
     -   SIP INFO application/dtmf
Dtmf receive mode
    Типы DTFM сообщений которые будут приниматься от гейтвея. Если приходит сообщение иного типа, оно не обрабатывается и не будет передано на другую ногу звонка. Возможные варианты:
        - RFC 2833
        - SIP INFO application/dtmf-relay OR application/dtmf
        - RFC 2833 OR SIP INFO
Rtp ping
    Если флаг включен, то сразу после согласования параметров RTP потока в SDP, YETI будет отсылать пустой RTP пакет к гейтвею, чтобы удаленный гейтвей мог успешно изучить адрес через механизм symmetric rtp. Так же такое поведение помогает преодолеть NAT.
Rtp timeout
    Если YETI не получает RTP пакетов в течении заданного интервала, то звонок разрывается и генерируется  CDR с соответствующим дисконнект кодом.
Filter noaudio streams
    Не отправлять к гейтвею SIP SDP содержащие несколько потоков. Потоки не являющиеся audio будут вырезаны из SDP. Такое поведение нарушает стандарты, однако позволяет работать оборудованием которое некорректно обрабатывает несколько потоков в SDP.
Rtp relay timestamp aligning
    Режим нормализации RTP пакетов, когда в полученных пакетах выравнивается timestamp.
Rtp force relay cn
    При включенном флаге YETI будет передавать и принимать пакеты Comfort noise, даже в том случае если они не согласованы с гейтвеем в SDP

Equipment. Gateway groups
------------------------
Гейтвей группа позволяет использовать несколько гейтвеев для терминации трафика к одному и тому же вендору, если эти гейтвеи производят биллинг одним способом. 

Name
    имя группы гейтвеев
Vendor
    владелец группы гейтвеев
Prefer same pop
    если флаг установлен, то при маршрутизации звонка приоритет будет отдаваться тем гейтвеям в группе,  которые находятся в той же точке присутствия которая и обрабатывает пришедший трафик
    
    
Equipment. Disconnect policies
------------------------------
    
Дисконнект полиси позволяет настроить модификации Disconnect reason SIP для каждого гейтвея в отдельности.

Equipment. Registrations
------------------------

YETI позволяет отсылать  SIP регистрации на удаленное оборудование клиента или поставщика.

Enabled
    флаг определяющий активность записи
Pop
    Точка присутствия,  ноды которой будут отсылать SIP REGISTER
Node
    нода которая будет отсылать SIP REGISTER
Domain
    uri domain в SIP REGISTER сообщении
Username
    uri user в SIP REGISTER сообщении
Display username
    uri display name в SIP REGISTER сообщении
Auth user
    Имя пользователя для авторизации
Auth password
    пароль авторизации
Proxy
    прокси через который выполнять отсылку регистрации
Contact
    
Expire
    
Force expire
    
Equipment. Codec groups
-----------------------

Name
    Имя кодек группы
    При создании кодек группы необходимо добавить в неё кодеки, при добавлении необходимо указать следующие параметры:
Codec
    Название кодека. Все поддерживаемые системой кодеки представлены в выпадающем списке
Priority
    приоритет кодека в SDP. Чем выше значение приоритета, тем выше будет положение кодека в SDP. Все кодеки в одной кодек группе должны иметь различные значения priority
Dynamic payload type
    Если необходимо использовать не стандартный payload type то значение можно указать в этом поле.
Format parameters
    Если необходимо использовать нестандартное значение fmt param, то значение можно задать в этом поле

    
System. Sensors
---------------
Система поддерживает логгирование сигнального и медиа трафика в режиме реального времени. Эта функциональность может использоваться для реализации СОРМ/Lawful intercetion.
Для включения функциональности добавьте конфигурацию сенсора(или нескольких) в таблицу.
На данный момент поддерживается два режима инкапсуляции для  сенсоров:
    -   IP-IP туннель. В этом режиме оригинальные IP пакеты  инкапсулируются в дополнительный заголовок туннеля IP-IP. Этот режим позволяет маршрутизировать логгируемый трафик, что особенно удобно когда сенсор не доступен в одном броадкаст домене.
    -   IP over Ethernet. В этом режиме оригинальный IP пакет инкаспулируется в Ethernet фрейм. MAC адрес назначения задается в конфигурации сенсора. Этот режим следует использовать если сенсор находится в одном L2 домене с сервером коммутации трафика.
    -   HEPv3(в разработке). http://sipcapture.org/ Протокол совместивый с  Homer capture server

После этого в настройках гейтвея можно выбрать сенсор и уровень логгирования. Трафик ног А и Б логгируется отдельно, потому для логгирования обоих ног, необходимо настройка сенсора как на оригинационном гейвее, так и на терминационном.


    
