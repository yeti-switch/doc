Contents:

.. toctree::
    :maxdepth: 3

==================
Веб-интерфейс YETI
==================

:Сайт: https://yeti-switch.org/

В связи с тем, что веб-интерфейс в данный момент не переведен на русский язык, названия параметров приведены на английском языке, а определения на русском.


.. warning::
    Элементы конфигурации, обозначенные символом * обязательны для заполнения.

.. note::

    Данные авторизации по-умолчанию для входа в веб-интерфейс после установки приложения:

    - *логин*: **admin**,
    - *пароль*: **111111**

Объекты конфигурации
====================

Панель мониторинга
------------------
Отображает различные индикаторы состояния системы, такие как:

- график активных звонков
- прибыльность и продолжительность звонков
- статус биллинга
- состояние репликации базы данных

Billing
-------
В этой секции находятся объекты конфигурации связанные с биллингом и взаиморасчетами с контрагентами

----


Contractors
~~~~~~~~~~~

Contractor(Контрагент) - Компания, которая взаимодействует с системой

Контрагент может выступать в роли **Customer (Покупатель)** - Использует предоставляемый сервис по терминации звнков и в роли **Supplier (Поставщик)** - Предоставляет сервис по терминации звонков. Один контрагент может являться и Покупателем и Поставщиком одновременно.

Контрагент имеет следующие атрибуты:

    Name
        Уникальный идентификатор имени.
    Enabled
        Если флаг снят (контрагент отключен), этот контрагент не будет использоваться при роутинге и биллинге.
    Vendor
        Если активировано, то данный Контрагент выступает в роли Поставщика и система может терминировать звонки через него.
    Customer
        Если активировано, то Контрагент выступает в роли Покупателя и оригинирует звонки в систему.
    Description
        Дополнительное описание Контрагента.
    Address
        Произвольный адрес Контрагента.
    Phones
        Список номеров для связи с Контрагентом.
    Smtp Connection
        Соединение с сервером электронной почты, используемое для отправки писем, счетов и уведомлений.
        (SMTP соединение предварительно должно быть настроено в *System->SMTP connections*)

.. note::

    Поля **Description**, **Address**, **Phones** информационные и не используются на этапе роутинга или биллинга.

----

Contacts
~~~~~~~~

Contact:
    Адресная информация о Контрагенте или операторе системы (контакт может быть отнесен к Контрагенту или оператору системы)
	Все уведомления и отчеты используют только те адреса, которые добавлены в контакты.

**Contact** имеет следующие атрибуты:

    Contractors:
        Список выбора Контрагентов, к которым может быть отнесен контакт.
    Admin user:
        Администратор системы, которому может быть присвоен контакт.
		Названия Контрагентов или имя Администратора системы должно быть введено.
    E-mail:
        Адрес электронной почты для отправки уведомлений, счетов и прочих писем.
    Notes:
        Произвольные заметки

----

Accounts
~~~~~~~~

**Account** атрибуты:

    Name
        Уникальное название Счета
    Contractors
        Контрагенты которомы принадлежит данный Счет.
    Min balance
        Если баланс Счета становится ниже чем данный лимит, то трафик через данный Счет будет заблокирован.
    Max balance
        Если баланс Счета станет выше чем данный лимит, то маршруты относящиеся к данному Счету не будут использованы для терминации звонков.
    Origination capacity
        Ёмкость оригинации - количество одновременных звонков, которое может быть оригинировано для данного Счета.
        Если количество входящих звонков превысит данную ёмкость, то трафик будет заблокирован.
    Termination capacity
        Ёмкость терминации - количество одновременных звонков, которое может быть терминировано для данного Счета.
        Если количество исходящих звонков превысит данную ёмкость, то трафик будет заблокирован.
    Vendor invoice period
        Период автоматической генерации счетов, в случае, если Счет выступает в роли счета Поставщика.
    Customer invoice period
        Период автоматической генерации счетов, в случае, если Счет выступает в роли счета Покупателя.
    Vendor invoice template
        Шаблон для генерации счетов в формате PDF для Поставщика. (Шаблоны предварительно должны быть настроены в *Billing->Invoice templates*)
    Customer invoice template
        Шаблон для генерации счетов в формате PDF для Покупателя. (Шаблоны предварительно должны быть настроены в *Billing->Invoice templates*)
    Sent invoices to
        Список Контактов, для отправки счетов.
    Timezone
        Временная зона, которая будет использована при генерации счетов и статистики для данного Счета.

Исходный баланс для вновь созданного Счета всегда нулевой.
Баланс может быть изменен, как результат обсчета звонков или при зачислении новых платежей.

Для каждого звонка:
баланс Счета будет **уменьшен** на величину стоимости звонка, если он использует Счет для **оригинации** (Покупатель)
и **увеличен** если он использует Сче для **терминации** (Поставщик)

----

Payments
~~~~~~~~

Платежи предназначены для изменения баланса Счета.
Все атрибуты Платежей самоописательные и не требуют детальных разъяснений (Счет для зачисления Платежа, сумма, описание и дата Платежа).

----

Invoices
~~~~~~~~
Счета на оплату обеспечивают возможность ссумировать биллинговую информацию о взаиморасчетах с Покупателями и Поставщиками.
Генерация Счетов на оплату может производиться в ручном или автоматическом режиме, если период авторегенерации для Счета был выбран.
Новые счета на оплату создаются со статусом *В ожидании (Pending)*
После *Одобрения* Cчет на оплату считается подтвержденным и отправленным Контрагенту на электронную почту (настраиваетя в параметрах Счета).
Если Счет имеет Шаблон Счета на оплату, система также сгенерирует PDF документ.

----

Invoice Templates
~~~~~~~~~~~~~~~~~
Шаблоны PDF документов могут быть использованы для генерации Счетов на оплату.
Шаблон представляет собой файл в формате .odt, который содержит специальные макросы для вставки значений.
Макросы заменяются на актуальные значение на этапе генерации PDF документа.
Система может хранить различные Шаблоны, и пользователь может выбирать необходимый для каждого Счета независимо.

----

Equipment
---------

Gateways
~~~~~~~~

**Gateway** атрибуты:
    Enabled
        Отключенный Гейтвей будет игнороваться
    Gateway group
        Гейтвеи могут быть сгруппированы. Выберите заранее созданную группу в списке, для того чтобы назначить в неё Гейтвей. Управление Группами гейтвеев осуществляется в *Billing->Gateway Groups*
    Priority
        Приоритет Гейтвея в группе. В случае терминации на Группу гейтвеев, Гейтвеи будут выстроены в оередь по данному приоритету.
    Pop
        Точка присутствия Гейтвея
    Contractor
        Контрагент, которому принадлежит данный Гейтвей.
    Allow origination
        Указывает, разрешена ли оригинация для данного Гейтвея
    Allow termination
        Указывает, разрешена ли терминация для данного Гейтвея с YETI
    Sst enabled
        Принудительное использование таймеров сессии SIP, в противном случае таймеры будут контролироваться сигнализацией удаленной стороны.
    Capacity
        Ёмкость терминации для данного Гейтвея. В случае, если Гейтвей используется для оригинации, данный арибут игнорируется.
    Acd limit
        Пороговое значение ACD. Если ACD для трафика Гейтвея будет ниже порога, то Диалпиры, которые используются этим Гейтвеем, будут исключены из роутинга, в случае, если выбран режим **ACD&ASR control** для Плана маршрутизации.
    Asr limit
        Пороговое значение ASR. Если ASR для трафика Гейтвея будет ниже порога, то Диалпиры, которые используются этим Гейтвеем, будут исключены из роутинга, в случае, если выбран режим **ACD&ASR control** для Плана маршрутизации.
    Sensor
        Сенсор для зеркалирования трафика. Зеркалирование отключено, если ничего не установлено.
    Sensor level
        Режим зеркалирования трафика. Возможные значения:
            - Signaling (Сигнализация)
            - RTP
            - Signaling + RTP
    Host
        IP-адрес или DNS-имя удаленного Гейтвея для отправки на него SIP сигнализации.
        (используется только для терминации)
    Port
        Порт удаленного Гейтвея для отправки на него SIP сигнализации. Оставьте его пустым для активации режима определения имени по записям DNS SRV в **Host**
    Resolve ruri
        Активирует определение RURI. Определяет необходимость в изменении доменной части RURI на определенный IP-адрес. например: `domain.com` имеет IP 1.1.1.1 и вы устанавливаете значение **Host** в `domain.com`:
            - resolve ruri активирована => RURI будет `user@1.1.1.1`
            - resolve ruri выключена => RURI будет `user@domain.com`
    Diversion policy
	    Политика обработки заголовка Diversion в SIP-сигнализации
    Diversion rewrite rule
	    Шаблон регулярного выражения для поиска соответствия в поле Diversion
    Diversion rewrite result
	    Регулярное выражение замены для поля Diversion
    Src name rewrite rule
	    Шаблон регулярного выражения для поиска в части display-name поля From
    Src name rewrite result
	    Регулярное выражение замены в части display-name поля From
    Src rewrite rule
	    Шаблон регулярного выражения для поиска в части user поля From
    Src rewrite result
	    Регулярное выражение замены в части user поля From
    Dst rewrite rule
	    Шаблон регулярного выражения для поиска в части user поля To и RURI
    Dst rewrite result
	    Регулярное выражение замены в части user поля To и RURI
    Auth enabled
	    Активация авторизации для исходящих звонков
    Auth user
	    Пользователь авторизации
    Auth password
	    Пароль для авторизации
    Auth from user
	    Часть user поля From для проведения авторизации
    Auth from domain
	    Часть domain поля From для проведения авторизации
    Term use outbound proxy
	    Использовать исходящий прокси для терминации
    Term force outbound proxy
	    Принудительное использование исходящего прокси для терминации
    Term outbound proxy
	    Адрес исходящего прокси
    Term next hop for replies
        ..
    Term next hop
        ..
    Term disconnect policy
        ..
    Term append headers req
	    Список полей, которые будут добавлены в **НАЧАЛЬНЫЙ** INVITE
    Sdp alines filter type
	    Тип фильтра для обработки А-линий в SDP. Возможные значения: Transparent, Blacklist, Whitelist
    Sdp alines filter list
        Список А-линий в SDP, разделенных запятыми.

    .. _gateway_ringing_timeout:

    Ringing timeout
        Таймаут между ответами `18x` и `200 OK`.

        В случае таймаута: попытка роутинга будет отменена
        и дальнейшая обработка (пытаться перероутиться или больше не пытаться) зависит от политики отбоя (disconnect policy).
    Relay options
        Прозрачно пересылать внутридиалоговые (In-dialog) пакеты OPTIONS между легами звонка.
    Relay reinvite
        Прозрачно пересылать внудридиалоговые (In-dialog) сообщения re-INVITE между легами звонка.
    Relay hold
        Прозрачно пересылать внутридиалоговые (In-dialog) сообщения re-INVITE с запросами на удержанием/снятие удержания между легами звонка.
    Relay prack
        Прозрачно пересылать внудридиалоговые (In-dialog) сообщения PRACK между легами звонка.
    Relay UPDATE
        Прозрачно пересылать сообщения UPDATE между легами звонка.
    Suppress early media
        Подавление раннего медиа. Отсылать 180 Ringing сообщения без SDP на LegA при получении 180/183 с SDP от LegB гейтвея.
    Fake 180 timer
        Позволяет установить таймер получения SIP-сообщений 183 c SDP. Если такое сообщение не будет получено в указанный интервал, YETI отправит фиктивное сообщение 180 в лег А, для эмуляции сигнала КПВ на устройстве.
    Transit headers from origination
        Фильтр заголовков SIP запросов, который будет применяться при фильтрации заголовков, отправленных оригинатором звонка. Подробнее в приложении :ref:`headers filtering <headers_fitering>`
    Transit headers from termination
        Фильтр заголовков SIP запросов, который будет применяться при фильтрации заголовков, отправленных терминационной стороной. Подробнее в приложении :ref:`headers filtering <headers_fitering>`
    Sip interface name
        Название сетевого интерфейса на котором слушает SEMS. Интерфейсы должны быть настроены в конфигурации SEMS. Может быть использовано для роутинга трафика с разных IP-адресов.
    Allow 1xx without to tag
        Позволяет пропускать ответы с кодом 1хх без To-tag (однако данное поведение нарушает RFC).
    Sip timer B
        Перезаписывает значение SIP timer B (таймаут транзакции). Звонок может быть повторно перероучен, если это позволяется политикой отбоя конфигурации.
    Dns srv failover timer
        Перезаписывает значение SIP timer M (повторная отправка INVITE). Значение должно быть меньше значения **SIP timer B**. Звонок может быть повторно перероучен, если это позволяется политикой отбоя конфигурации.
    Sdp c location
        Положение connection-line в теле SDP, которое генерируется YETI.
        Возможные значения:

            - На уровне медиа (On media level)
            - На уровне сессии (On session level)
            - На уровне медиа и сессии (On session and media level)
    Codec group
        Группа кодеков, которая будет использована при взаимодействии с данным гейтвеем.
    Anonymize sdp
        Анонимизировать данные клиентской SDP сессии (session name, uri, origin user)
    Proxy media
        Определять режим обработки RTP. Должно быть активировано для возможностей транскодирования.
    Single codec in 200ok
        Если активировано, YETI оставит только один кодек в ответах с SDP (исключая telephone-event который все равно будет добавлен, если получен в предложении SDP и присутствует в кодек-группе  для этого гейтвея).
    Transparent seqno
	Прозрачная пересылка номера RTP SEQ при передаче RTP.
    Transparent ssrc
        Прозрачная пересылка номера RTP SSRC при передаче RTP.
    Force symmetric rtp
	Игнорировать удаленный адрес указанный в SDP. Вместо этого использовать адрес, с которого получен первый RTP/RTCP пакет.
    Symmetric rtp nonstop
        По-умолчанию, YETI позволяет изменять адрес для симметричного RTP только один раз. Эта опция позволяет снять данное ограничение. Если она активна, YETI будет изменять адрес назначение каждый раз, когда получае RTP/RTCP пакет с другого источника.
    Symmetric rtp ignore rtcp
        Отключает симметричный RTP для RTCP пакетов.
    Force dtmf relay
        Не обрабатывать telephone-event (RFC2833) пакеты и пересылать их "как есть".
    Dtmf send mode
        Режим отправки DTMF на удаленный гейтвей. Возможные значения:
            - Отключить отправку (Disable sending)
            - RFC 2833 (telephone-event)
            - SIP INFO application/dtmf-relay
            - SIP INFO application/dtmf
    Dtmf receive mode
        Разрешенные методы получения DTMF-сигналов с удаленного гейтвея. В случае, если это запрещено, они будут игнорироваться. Возможные значения:

            - RFC 2833 (telephone-event)
            - SIP INFO application/dtmf-relay OR application/dtmf
            - RFC 2833 OR SIP INFO
    Rtp ping
		Полезная опция для следующего случая: когда гейтвеи со включенным симметричным RTP ожидают первого пакета, прежде чем начинать передачу,
		но гейтвей на удаленно стороне делает тоже самое,
		Если опция активирована, YETI отправляет фиктивный RTP пакет на удаленный гейтвей сразу же после инициализации потока.
    Rtp timeout
	    Если активирована, звонок будет сброшен с соответствующим кодом в CDR, если никакой RTP не поступил в течение указанного интервала.
    Filter noaudio streams
	    Исключать все потоки кроме 'audio' из SDP в INVITE для терминационного гейтвея.
		Данные не-аудио потоки будут автоматически вставлены как отключенные (порт установлен в ноль)
		в ответы гейтвею, который отправил предложение для соответствия RFC.
		Полезно для гейтвеев, которые обрабатывают множественные потоки в SDP некорректно и/или отклюняют INVITEs с не-аудио потоками.
    Rtp relay timestamp aligning
		Нормализация временных меток для RTP-пакетов при передаче RTP.
		Полезно в случаях, когда при передаче RTP удаленная сторона изменяет RTP-потоки
		без соответствующей сигнализации (отметка RTP и/или re-INVITE) и оборудование
		не готово обрабатывать такое поведение корректно.
    Rtp force relay CN
		Если активирована, YETI будет пересылать CN-пакеты, даже если они не были согласованы в SDP.

----

Gateway groups
~~~~~~~~~~~~~~
Группы гейтвеев позволяют использовать множество гейтвеев терминации трафика для одного Поставщика,
если данные гейтвеи имеют общую конфигурацию биллинга.

**Gateway group** атрибуты:

    Name
		Уникальное название группы
    Vendor
	    Поставщик, к которому относится данная группа
    Prefer same pop
		Если активирована, первоначально использовать терминационные гейтвеи с той же самой POP, что и входящий трафик.

----

Disconnect policies
~~~~~~~~~~~~~~~~~~~
Политика отбоя позволяет настраивать правила для каждого SIP-кода разъединения для гейтвея (рероутинг, перезапись кодов/причин).

Registrations
~~~~~~~~~~~~~
YETI предоставляет возможность регистрировать на внешних SIP-серверах.

**Registration** атрибуты:

    Enabled
	    Активирует регистрацию. Отключенные регистрации игнорируются.
    Name*
		Название регистрации.
    Pop
		Точка присутствия (PoP) для запросов на регистрацию. Из данной точки будут отправляться запросы REGISTER.
    Node
		Нода, которая обслуживает регистрацию.
    Domain*
		Доменная часть поля From в RURI.
    Username*
	    Пользовательская часть поля From в RURI.
    Display username
		Отображаемое имя в поле From.
    Auth user
		Имя пользователя для авторизации.
    Auth password
		Пароль для авторизации.
    Proxy
		SIP-прокси используемый для регистрации.
    Contact
		Заголовок Contact в запросе. Должен быть задан в формате SIP-URI.
    Expire
		Время истечения регистрации.
    Force expire
		Принудительная перерегистрация после истечения интервавала **Expire**, даже если сервер установил иное значение в ответе.
    Retry delay*
		Задержка отправки повторного сообщения REGISTER, в случае получения ответа от сервера с кодом ошибки или таймауте регистрации (секунды).
    Max attempts
		Максимальное количество попыток регистрации, по достижении которого YETI перестанет делать попытки зарегистрироваться. Для повторной активации, необходимо выключить, а затем повторно активировать регистрацию.

----

Codec groups
~~~~~~~~~~~~
Группы кодеков позволяют создавать произвольные наборы медиа-кодеков и применять их к гейтвеям. Группы могут различаться по составу кодеков,
их приоритету и кодам нагрузки, что позволяет обрабаывать различные сценарии при обработке звонков.

**Codec group** атрибуты:

    Name
		Название Группы кодеков
    List of codecs
		Каждый кодек имеет следующие атрибуты:

            Codec
				Название кодека. Все доступные кодеки представлены в выпадающем списке
            Priority
				Приоритет кодека в SDP. Меньшее значение означает более высокий приоритет.
				Должен быть уникален в пределах группы.
            Dynamic payload type
			    Перезапись типа нагрузки (разрешены значения из динамического диапазона)
            Format parameters
				Нестандартное значение для параметра **fmt** в атрибуте SDP.

----

LNP database
~~~~~~~~~~~~
Смотри https://en.wikipedia.org/wiki/Local_number_portability

YETI поддерживает взаимодействие с базами данных LNP по протоколам SIP и HTTP REST.
Команда YETI приветствует запросы на реализацию дополнительных протоколов или баз данных иных форматов!

Name
	Название базы данных (Уникальное поле)
Driver
	Драйвер, который будет использоваться.
	Возможные варианты:

        - UDP SIP 301/302 redirect
        - thinQ RESR LRN driver
        - In-memory hash
Host
	Адрес базы данных (будет проигнорирован при использовании драйвера In-memory hash).
Port
	Порт базы данных.
Timeout
	Максимальное время ожидания ответа от базы даннных.
	Запрос будет признан неуспешным с соответствующим кодом и причиной.
Thinq username
	Имя пользователя для авторизации в thinQ API.
Thinq token
	Токен авторизации в thinQ API.
Csv file
	Путь к файлу с предзагруженными данными (при использовании драйвера In-memory hash)

----

RADIUS Auth Profiles
~~~~~~~~~~~~~~~~~~~~
YETI поддерживает дополнительную авторизацию входящего звонка на внешнем RADIUS сервере. RADIUS Auth Profile описывает взаимодействие с таким сервером.

**RADIUS Auth Profiles** атрибуты:

Name
    Название профайла. Используется только как информационное поле и не влияет на работу системы. Название профайла должно быть уникально.
Server
    IP адрес или Hostname внешнего RADIUS сервера
Port
    Номер UDP порта, на котором RADIUS сервер ожидает запросы
Secret
    Пароль для авторизации RADIUS сервера.
Reject on error
    Если флаг установлен в true то при ошибке взаимодействия с радиус сервером(таймаут, неверный формат ответа), звонок будет считаться авторизованым и YETI будет выполнять дальнейшую его маршрутизацию. Если флаг установлен в false - при ошибке звонок будет разъединяться с соответствующим кодом разъединения
Timeout
    Таймаут, по истечении заданного кол-ва миллисекунд будет выполняться повтор радиус запроса
Attempts
    Максимальное количество повторов запросов для каждого звонка

----

RADIUS Accounting Profiles
~~~~~~~~~~~~~~~~~~~~~~~~~~

YETI поддерживает аккаунтинг входящих и исходящих звонков на внешнем RADIUS сервере. RADIUS Accounting Profile описывает взаимодействие с таким сервером.

**RADIUS Accounting Profile** атрибуты:

Name
    Название профайла. Используется только как информационное поле и не влияет на работу системы. Название профайла должно быть уникально.
Server
    IP адрес или Hostname внешнего RADIUS сервера.
Port
    Номер UDP порта, на котором RADIUS сервер ожидает запросы.
Secret
    Пароль для авторизации RADIUS сервера.
Timeout
    Таймаут, по истечении заданного кол-ва миллисекунд будет выполняться повтор радиус запроса.
Attempts
    Максимальное количество повторов запросов для каждого звонка
Enable start accounting
	Если активна, то YETI будет отправлять Start-accounting пакеты на удаленный сервер.
Enable interim accounting
	Если активна, YETI будет отправлять Interim-accounting пакеты на удаленный сервер.
Interim accounting interval
	Значение шага отправки Interim-пакетов на удаленный сервер (секунды).
Enable stop accounting
	Если активна, YETI будет отправлять Stop-accounting пакеты на удаленный сервер.

Routing
-------

Customer Auth
~~~~~~~~~~~~~

This entity authenticates calls from customers or gateways, applies them to
routing table and has some useful filters and options.

Customer Auth form is splitted to 3 tabs and each one is described below.

*General* tab
`````````````

Name
    Unique name of Accounting profile.
    Uses for informational purposes and doesn't affect system behaviour.
Enabled
    IP address or hostname of external RADIUS server.
Customer
    Customer, who this Customer Auth belongs to
Account
    Accout of Customer, which this Customer Auth belongs to
Gateway
    Gateway which related to this Customer Auth. That gateway(its parameters),
    will be used for media handling on the A-leg of a call.
Rateplan
    Rateplan, which this Customer Auth belongs to
Routing Plan
    Routing Plan, which this Customer Auth belongs to
Dst Numberlist
    You may apply Dst Numberlist (Destination) and check B-numbers, by prefix or
    full-match, then reject it or allow.
Src Numberlist
    You may apply Src Numberlist (Source) and check B-numbers, by prefix or
    full-match, then reject it or allow.
Dump Level
    It is possible to capture calls to PCAP files, using this option.
    You may choose what kind of information should be captured.

    Possible values are:
        - Capture nothing
        - Capture all traffic
        - Capture RTP traffic
        - Capture signalling traffic
Enable Audio Recording
    If checked, the media for calls passing through this Customer Auth will be stored
    in WAV files.
Capacity
    The capacity of the Customer Auth, i.e. how many calls it accepts at the moment.
Allow Receive Rate Limit
    A Customer may send special SIP-header in which he send the price for this call he wants to pay.
    And YETI will rely on this price on the routing stage if we allow such a behaviour.
Send Billing Information
    If enabled, YETI adds the special SIP-header into 200 SIP-message, which contains
    current price for calls, in order to a Customer should be informed.

Match condition options
```````````````````````
This part is crucial for authentication process of incoming calls. You should note that a one
customer may have many of Customer Auth with almost the same parameters, so pay
attention to parameters besides Ip address.

Transport Protocol
    **TODO**
Ip
    **TODO**
Pop
    **TODO**
Src Prefix
    **TODO**
Dst Prefix
    **TODO**
Uri Domain
    **TODO**
From Domain
    **TODO**
To Domain
    **TODO**
X Yeti Auth
    **TODO**

*Number translation* tab
````````````````````````

Diversion policy
    Defines what to do with Diversion header within SIP-signalization.
    Default value is "Clear header", so this header will be deleted.
Diversion rewrite rule
    This option should contain a regular expression for changing a Diversion header
Diversion rewrite result
    The result of changing a Diversion header, using the Rewrite Rule above
Src name rewrite rule
    This field should contain a regular expression for changing the Name field in the
    Source-number within SIP-signalization
Src name rewrite result
    The result of changing the Name field in the Source-number, using the
    Src name rewrite rule above
Src rewrite rule
    This field should contain a regular expression for changing the Source-number
    within SIP-signalization
Src rewrite result
    The result of changing the Name field in the Source-number, using the Src rewrite rule above
Dst rewrite rule
    This field should contain a regular expression for changing the Destination-number
    within SIP-signalization
Dst rewrite result
    The result of changing the Name field in the Source-number, using the Dst rewrite rule above

*Radius* tab
````````````

Radius auth profile
    Must be specified if the additional radius authentication is required
Src number radius rewrite rule
    Should contain regular expression for changing Source-number which will be sent
    to Radius-server if it's required
Src number radius rewrite result
    The result of applying the Src number radius rewrite rule to Source-number
Dst number radius rewrite rule
    Should contain regular expression for changing Destination-number which will be sent
    to Radius-server if it's required
Dst number radius rewrite result
    The result of applying the Dst number radius rewrite rule to Destination-number
Radius accounting profile
    Must be specified if the radius accounting is required

Rateplans
~~~~~~~~~
    **TODO**

**Rateplan** attributes:

Name
    Unique name for the Rateplan.
Profit control mode
    **TODO**
Send quality alarms to
    **TODO**

Destinations
~~~~~~~~~~~~
    **TODO**

**Destination** attributes:

    Prefix
        **TODO**
    Country
        **TODO**
    Network
        **TODO**
    Reject Calls
        **TODO**
    Quality Alarm
        **TODO**
    Rateplan
        **TODO**
    Routing Tag
        **TODO**
    Valid From
        **TODO**
    Valid Till
        **TODO**
    Rate Policy
        **TODO**
    Initial Interval
        **TODO**
    Next Interval
        **TODO**
    Use Dp Intervals
        **TODO**
    External Id
        **TODO**
    Initial Rate
        **TODO**
    Next Rate
        **TODO**
    Connect Fee
        **TODO**
    Profit Control Mode
        **TODO**
    Dp Margin Fixed
        **TODO**
    Dp Margin Percent
        **TODO**
    Asr Limit
        **TODO**
    Acd Limit
        **TODO**
    Short Calls Limit
        **TODO**

Routing groups
~~~~~~~~~~~~~~
    **TODO**

**Routing group** attributes:

    Name
        **TODO**

Dialpeers
~~~~~~~~~
    **TODO**

**Dialpeer** attributes:

    Prefix
        **TODO**
    Country
        **TODO**
    Network
        **TODO**
    Enabled
        **TODO**
    Locked
        **TODO**
    Routing Group
        **TODO**
    Routing Tag
        **TODO**
    Vendor
        **TODO**
    Account
        **TODO**
    Priority
        **TODO**
    Force Hit Rate
        **TODO**
    Exclusive Route
        **TODO**
    Initial Interval
        **TODO**
    Initial Rate
        **TODO**
    Next Interval
        **TODO**
    Next Rate
        **TODO**
    Lcr Rate Multiplier
        **TODO**
    Connect Fee
        **TODO**
    Gateway
        **TODO**
    Gateway Group
        **TODO**
    Valid From
        **TODO**
    Valid Till
        **TODO**
    Capacity
        **TODO**
    Src Name Rewrite Rule
        **TODO**
    Src Name Rewrite Result
        **TODO**
    Src Rewrite Rule
        **TODO**
    Src Rewrite Result
        **TODO**
    Dst Rewrite Rule
        **TODO**
    Dst Rewrite Result
        **TODO**
    Acd Limit
        **TODO**
    Asr Limit
        **TODO**
    Short Calls Limit
        **TODO**
    Created At
        **TODO**
    External
        **TODO**
    Current Rate
        **TODO**

Routing plans
~~~~~~~~~~~~~
    **TODO**

**Routing plan** atributes:

    Name
        **TODO**
    Sorting
        **TODO**
    Use Lnp
        **TODO**
    Rate Delta Max
        **TODO**
    Routing Groups
        **TODO**

Routing plan static routes
~~~~~~~~~~~~~~~~~~~~~~~~~~
    **TODO**

**Static route** attributes:

    Routing Plan
        **TODO**
    Prefix
        **TODO**
    Country
        **TODO**
    Network
        **TODO**
    Priority
        **TODO**
    Vendor
        **TODO**

Routing plan LNP rules
~~~~~~~~~~~~~~~~~~~~~~
    **TODO**

**LNP routing plan rule** attributes:

Routing plan
    **TODO**
Dst prefix
    **TODO**
Req dst rewrite rule
    **TODO**
Req dst rewrite result
    **TODO**
Database
    **TODO**
Lrn rewrite rule
    **TODO**
Lrn rewrite result
    **TODO**

LNP cache
~~~~~~~~~
    **TODO**

Numberlists
~~~~~~~~~~~
    **TODO**

**Numberlist** attributes:

    Name
        **TODO**
    Mode
        **TODO**
    Default Action
        **TODO**
    Default Src Rewrite Rule
        **TODO**
    Default Src Rewrite Result
        **TODO**
    Default Dst Rewrite Rule
        **TODO**
    Default Dst Rewrite Result
        **TODO**
    Created At
        **TODO**
    Updated At
        **TODO**

Numberlist Items
~~~~~~~~~~~~~~~~
    **TODO**

**Numberlist item** attributes:

    Numberlist
        **TODO**
    Key
        **TODO**
    Action
        **TODO**
    Src Rewrite Rule
        **TODO**
    Src Rewrite Result
        **TODO**
    Dst Rewrite Rule
        **TODO**
    Dst Rewrite Result
        **TODO**
    Createa At
        **TODO**
    Updated At
        **TODO**

Routing tags
~~~~~~~~~~~~
    **TODO**

**Routing tag** attributes:

Name
    **TODO**

Areas
~~~~~
    **TODO**

**Area** attributes:

    Name
        **TODO**

Area prefixes
~~~~~~~~~~~~~
    **TODO**

**Area prefix** attributes:

    Prefix
        **TODO**
    Area
        **TODO**

Routing tags detection
~~~~~~~~~~~~~~~~~~~~~~
    **TODO**

**Routing tag detection rule** attributes:

    Src Area
        **TODO**
    Dst Area
        **TODO**
    Routing Tag
        **TODO**

Routing tags detection
~~~~~~~~~~~~~~~~~~~~~~
    **TODO**

**Routing simulation form** attributes:

    Transport protocol
        **TODO**
    Remote ip*
        **TODO**
    Remote port*
        **TODO**
    Pop
        **TODO**
    Src number*
        **TODO**
    Dst number*
        **TODO**
    Uri domain
        **TODO**
    From domain
        **TODO**
    To domain
        **TODO**
    X yeti auth
        **TODO**
        
Routing simulation
~~~~~~~~~~~~~~~~~~
    **TODO**

**Call simulation** attributes:

    Transport protocol
        **TODO**
    Remote ip*
        **TODO**
    Remote port*
        **TODO**
    Pop
        **TODO**
    Src number*
        **TODO**
    Dst number*
        **TODO**
    Uri domain
        **TODO**
    From domain
        **TODO**
    To domain
        **TODO**
    X yeti auth
        **TODO**
    Release mode
        **TODO**

Cdr
---

Tables
~~~~~~
**TODO**

**Cdr Table Details** attributes:

    ID
        **TODO**
    NAME
        **TODO**
    READABLE
        **TODO**
    WRITABLE
        **TODO**
    DATE START
        **TODO**
    DATE STOP
        **TODO**
    ACTIVE
        **TODO**

CDR History
~~~~~~~~~~~
    **TODO**

*General Information* tab
`````````````````````````
    ID
        **TODO**
    TIME START
        **TODO**
    TIME CONNECT
        **TODO**
    TIME END
        **TODO**
    DURATION
        **TODO**
    STATUS	FAILURE
        **TODO**
    DISCONNECT INITIATOR
        **TODO**
    LEGA DISCONNECT CODE
        **TODO**
    LEGA DISCONNECT REASON
        **TODO**
    INTERNAL DISCONNECT CODE
        **TODO**
    INTERNAL DISCONNECT REASON
        **TODO**
    LEGB DISCONNECT CODE
        **TODO**
    LEGB DISCONNECT REASON
        **TODO**
    ROUTING ATTEMPT
        **TODO**
    IS LAST CDR
        **TODO**
    SRC NAME IN
        **TODO**
    SRC PREFIX IN
        **TODO**
    FROM DOMAIN
        **TODO**
    DST PREFIX IN
        **TODO**
    TO DOMAIN
        **TODO**
    RURI DOMAIN
        **TODO**
    SRC PREFIX ROUTING
        **TODO**
    SRC AREA
        **TODO**
    DST PREFIX ROUTING
        **TODO**
    DST AREA
        **TODO**
    LRN
        **TODO**
    LNP DATABASE
        **TODO**
    SRC NAME OUT
        **TODO**
    SRC PREFIX OUT
        **TODO**
    DST PREFIX OUT
        **TODO**
    DIVERSION IN
        **TODO**
    DIVERSION OUT
        **TODO**
    DST COUNTRY
        **TODO**
    DST NETWORK
        **TODO**
    NODE
        **TODO**
    POP
        **TODO**
    CUSTOMER
        **TODO**
    VENDOR
        **TODO**
    CUSTOMER ACC
        **TODO**
    VENDOR ACC
        **TODO**
    CUSTOMER AUTH
        **TODO**
    ORIG GW
        **TODO**
    TERM GW
        **TODO**

*Protocol Details* tab
``````````````````````
    **TODO**

    ORIG CALL
        **TODO**
    TERM CALL
        **TODO**
    SIGN ORIG TRANSPORT PROTOCOL
        **TODO**
    SIGN ORIG IP
        **TODO**
    SIGN ORIG LOCAL IP
        **TODO**
    AUTH ORIG TRANSPORT PROTOCOL
        **TODO**
    AUTH ORIG IP
        **TODO**
    SIGN TERM TRANSPORT PROTOCOL
        **TODO**
    SIGN TERM IP
        **TODO**
    SIGN TERM LOCAL IP
        **TODO**
    LOCAL TAG
        **TODO**
    ROUTING DELAY
        **TODO**
    PDD
        **TODO**
    RTT
        **TODO**
    EARLY MEDIA PRESENT
        **TODO**
    LEGA RX PAYLOADS
        **TODO**
    LEGA TX PAYLOADS
        **TODO**
    LEGB RX PAYLOADS
        **TODO**
    LEGB TX PAYLOADS
        **TODO**
    LEGA RX BYTES
        **TODO**
    LEGA TX BYTES
        **TODO**
    LEGA RX DECODE ERRS
        **TODO**
    LEGA RX NO BUF ERRS
        **TODO**
    LEGA RX PARSE ERRS
        **TODO**
    LEGB RX BYTES
        **TODO**
    LEGB TX BYTES
        **TODO**
    LEGB RX DECODE ERRS
        **TODO**
    LEGB RX NO BUF ERRS
        **TODO**
    LEGB RX PARSE ERRS
        **TODO**
    CORE VERSION
        **TODO**
    YETI VERSION
        **TODO**
    LEGA USER AGENT
        **TODO**
    LEGB USER AGENT
        **TODO**

*Routing&Billing information* tab
`````````````````````````````````
    **TODO**

    CUSTOMER PRICE
        **TODO**
    VENDOR PRICE
        **TODO**
    PROFIT
        **TODO**
    RATEPLAN
        **TODO**
    DESTINATION
        **TODO**
    DESTINATION RATE POLICY
        **TODO**
    DESTINATION FEE
        **TODO**
    DESTINATION INITIAL INTERVAL
        **TODO**
    DESTINATION INITIAL RATE
        **TODO**
    DESTINATION NEXT INTERVAL
        **TODO**
    DESTINATION NEXT RATE
        **TODO**
    ROUTING PLAN
        **TODO**
    ROUTING GROUP
        **TODO**
    ROUTING TAG
        **TODO**
    DIALPEER
        **TODO**
    DIALPEER FEE
        **TODO**
    DIALPEER INITIAL INTERVAL
        **TODO**
    DIALPEER INITIAL RATE
        **TODO**
    DIALPEER NEXT INTERVAL
        **TODO**
    DIALPEER NEXT RATE
        **TODO**
    TIME LIMIT
        **TODO**
    CUSTOMER INVOICE
        **TODO**
    VENDOR INVOICE
        **TODO**

CDR Archive
~~~~~~~~~~~

Reports
-------
    **TODO**

Custom Cdrs report
~~~~~~~~~~~~~~~~~~
    **TODO**

**Custom Cdrs** атрибуты:

    Date start
        **TODO**
    Date end
        **TODO**
    Customer
        **TODO**
    Filter
        **TODO**
    Group by*
        **TODO**
    Send to
        **TODO**

**Custom Cdr Scheduler** атрибуты:

    Period*
        **TODO**
    Customer
        **TODO**
    Filter
        **TODO**
    Group by*
        **TODO**
    Send to
        **TODO**

Customer Traffic
~~~~~~~~~~~~~~~~
    **TODO**

**Customer Traffic** атрибуты:

    Date start*
        **TODO**
    Date end*
        **TODO**
    Customer
        **TODO**
    Send to
        **TODO**

**Customer Traffic Scheduler** атрибуты:

    Period*
        **TODO**
    Customer*
        **TODO**
    Send to
        **TODO**

Vendor Traffic
~~~~~~~~~~~~~~
    **TODO**

**Vendor Traffic** атрибуты:

    Date start*
        **TODO**
    Date end*
        **TODO**
    Vendor
        **TODO**
    Send to
        **TODO**

**Vendor Traffic Scheduler** атрибуты:

    Period*
        **TODO**
    Vendor*
        **TODO**
    Send to
        **TODO**

Interval Cdr report
~~~~~~~~~~~~~~~~~~~
    **TODO**

**Report Interval Cdr** атрибуты:

    Date start*
        **TODO**
    Date end*
        **TODO**
    Interval length*
        **TODO**
    Aggregation function*
        **TODO**
    Aggregate by*
        **TODO**
    Filter
        **TODO**
    Group by fields
        **TODO**
    Send to
        **TODO**

**Interval Cdr Scheduler** атрибуты:

Period*
    **TODO**
Interval length*
    **TODO**
Aggregation function*
    **TODO**
Aggregate by*
    **TODO**
Filter
    **TODO**
Group by
    **TODO**
Send to
    **TODO**

Termination Distributions
~~~~~~~~~~~~~~~~~~~~~~~~~
    **TODO**

**Report Realtime Termination Distributions** таблица:

Vendor
    **TODO**
Originated Calls Count
    **TODO**
Rerouted Calls Count
    **TODO**
Rerouted Calls Percent
    **TODO**
Termination Attempts Count
    **TODO**
Calls Duration
    **TODO**
Acd
    **TODO**
Origination Asr
    **TODO**
Termination Asr
    **TODO**
Profit
    **TODO**
Customer Price
    **TODO**
Vendor Price
    **TODO**

Origination Performances
~~~~~~~~~~~~~~~~~~~~~~~~
    **TODO**

**Report Realtime Origination Performances** таблица:

    Customer Auth
        **TODO**
    Cps
        **TODO**
    Offered load(Erlang)
        **TODO**
    Routing Delay
        **TODO**
    Calls Duration
        **TODO**
    Calls Count
        **TODO**
    Termination Attempts Count
        **TODO**
    Acd
        **TODO**
    Asr
        **TODO**

Bad Routings
~~~~~~~~~~~~
    **TODO**

**Report Realtime Bad Routings** таблица:

    Customer
        **TODO**
    Customer Auth
        **TODO**
    Rateplan
        **TODO**
    Routing Plan
        **TODO**
    Internal Disconnect Code
        **TODO**
    Internal Disconnect Reason
        **TODO**
    Calls Count
        **TODO**

Not Authenticateds attempts
~~~~~~~~~~~~~~~~~~~~~~~~~~~
    **TODO**

**Report Realtime Not Authenticateds** таблица:

Auth Orig Ip
    **TODO**
Auth Orig Port
    **TODO**
Attempts Count
    **TODO**
Internal Disconnect Code
    **TODO**
Internal Disconnect Reason
    **TODO**

Realtime Data
-------------

Active Calls
~~~~~~~~~~~~
    **TODO**

**Active Calls** таблица:

Actions
    **TODO**
Customer
    **TODO**
Vendor
    **TODO**
Duration
    **TODO**
Dst Number
    **TODO**
Dst Network
    **TODO**
Origination Rate
    **TODO**
Termination Rate
    **TODO**

Nodes
~~~~~
    **TODO**

**Realtime Data Active Nodes** таблица:

    Id
        **TODO**
    Name
        **TODO**
    Active Calls Count
        **TODO**
    Version
        **TODO**
    Shutdown Req Time
        **TODO**
    Sessions Num
        **TODO**
    Uptime
        **TODO**

Outgoing Registrations
~~~~~~~~~~~~~~~~~~~~~~
    **TODO**

**Outgoing Registrations** таблица:

    Id
        **TODO**
    User
        **TODO**
    Domain
        **TODO**
    State
        **TODO**
    Auth User
        **TODO**
    Display Name
        **TODO**
    Contact	Proxy
        **TODO**
    Expires
        **TODO**
    Expires Left
        **TODO**
    Node
        **TODO**
    Last Error Code
        **TODO**
    Last Error Initiator
        **TODO**
    Last Error Reason
        **TODO**
    Last Request Time
        **TODO**
    Last Succ Reg Time
        **TODO**
    Attempt
        **TODO**
    Max Attempts
        **TODO**
    Retry
        **TODO**
    Delay
        **TODO**

Logs
----

Api Logs
~~~~~~~~
    **TODO**

**Api Log Details**

    ID
            **TODO**
    CREATED AT
            **TODO**
    STATUS
            **TODO**
    METHOD
            **TODO**
    PATH
            **TODO**
    CONTROLLER
            **TODO**
    ACTION
            **TODO**
    PAGE DURATION
            **TODO**
    DB DURATION
            **TODO**
    PARAMS
            **TODO**
    REQUEST HEADERS
            **TODO**
    REQUEST BODY
            **TODO**
    RESPONSE HEADERS
            **TODO**
    RESPONSE BODY
            **TODO**

Audit Log
~~~~~~~~~
    **TODO**

**Audit Log Item Details**

    ID
        **TODO**
    ITEM TYPE
        **TODO**
    ITEM
        **TODO**
    EVENT
        **TODO**
    WHODUNNIT
        **TODO**
    DATE
        **TODO**
    TXID
        **TODO**
    IP
        **TODO**

Logic Logs
~~~~~~~~~~
    **TODO**

**Logic Log Details**


ID
    **TODO**
TIMESTAMP
    **TODO**
TXID
    **TODO**
LEVEL
    **TODO**
SOURCE
    **TODO**
MSG
    **TODO**

Email Logs
~~~~~~~~~~
    **TODO**

**Log Email Log Details**

ID
    **TODO**
CREATED AT
    **TODO**
SENT AT	EMPTY
    **TODO**
CONTACT
    **TODO**
SMTP CONNECTION
    **TODO**
MAIL FROM
    **TODO**
MAIL TO
    **TODO**
SUBJECT
    **TODO**
MSG
    **TODO**

Events
~~~~~~
    **TODO**

System
------

Global configuration
~~~~~~~~~~~~~~~~~~~~
На данной странице настраиваются глобальные параметры YETI.

Атрибуты **Global configuration**:

Rows Per Page
    Данная опция позволяет изменить состав выпадающего списка *Per page*, представленного на каждой странице содержащей списки данных,
    который отвечает за количество записей, которые будут отображены на такой странице. Пользователь может изменить значения по-умолчанию
    *30,50,100*, если требуется выводить иное количество записей.
CDR Unload Dir
    Директория в которую YETI сохраняет таблицы базы данных CDR на странице *CDR -> Tables*.
CDR Unload URI
    URL для внешней программы просмотра CDR. YETI перенаправляет на данную программу со страницы *CDR -> Tables* при нажатии кнопки **Unloaded files**.
CDR Archive Delay
    Перемещать CDR в архив после **N** месяцев.
CDR Remove Delay
    Удалять архивы таблица после **N** месяцев.
Max Records
    Максимальное количество записей, которые YETI может сохранить в CSV-файл (при нажатии кнопи *Download: CSV* внизу каждой страницы содержащей списки даных).
Import Max Threads
    Число потоков для процедуры импорта CSV-файлов.
Import Helpers Dir
    Вспомогательная директория, в которую YETI сохраняет временные файлы во время процедуры импорта CSV-файлов.
Active Calls Require Filter
    Требовать наличие активного фильтра на странице *RT data -> Active Calls*.
Registrations Require Filter
    Требовать наличие активного фильтра на странице *RT data -> Outgoing Registrations*.
Active Calls Show Chart
    Если **true** - YETI будет отображать график активных звонков на странице *RT data -> Active Calls*.
Active Calls Autorefresh Enable
    Если **true** - YETI будет автоматически обновлять страницу *RT data -> Active Calls* каждые 20 секунд.
Max Call Duration
    Глобальный параметр, определяющий максимальную продолжительность звонков (секунды).
Random Disconnect Enable
    Если **true** - YETI будет в случайном порядке завершать звонки, чья длительность более чем **Random Disconnect Length**, отправляя BYE сторонам.
Random Disconnect Length
    Продолжительность звонков в секундах, после достижения которой YETI будет завершать их, если опция **Random Disconnect Enable** активна.
Drop Call If LNP Fail
    Если **true** - YETI будет отбрасывать звонки, если запросы к базе данных LNP неуспешны.
LNP Cache TTL
    Время жизни кэша LNP (секунды).
LNP E2E Timeout
    Таймаут для запросов к базе данных LNP (секунды). YETI отбросит звонки, если опция **Drop Call If LNP Fail** активна, истек данный таймаут или возвращен
    ответ с ошибкой от базы данных.
Short Call Length
    Пользователь может определить, какие звонки будут считаться "короткими" (short calls) (секунды). Этот параметр влияет на кнопку фильтра **Short Calls**
    на странице *CDR -> CDR History*.
Termination Stats Window
    Интервал в часах, используемый при генерации статистики Гейтвея или Диалпира (панель *Short Window Stats* на странице каждого Гейтвея или Диалпира).
Quality Control Min Calls
    Минимальное количество звонков, необходимое для построения статистики контроля звонков **Quality Control**.
Quality Control Min Duration
    Общая продолжительность звонков, необходимая для построения статистики контроля звонков **Quality Control**.

Routing
-------
    В этом пункте меню находятся объекты конфигурации непосредственно влияющие на поиск маршрута при коммутации вызова.

Destinations
~~~~~~~~~~~~
Направления (Destinations) в YETI предназначены для определения префиксов, которые могут быть обработаны системой и порядка вычесления стоимости звонков для оригинатора.

Атрибуты:

Prefix
    Числовой префикс, с которым будет проводится сопоставление номера.
Enabled
    Если данный флаг активирован, то Направление будет участвовать в процедуре роутинга.
Reject calls
    Если данный флаг активирован, то при получении соответствия вызываемого номера с данным Направлением при проведении процедуры роутинга, звонок будет отклонен.
Rateplan
    Выпадающий список, в котором **необходимо** выбрать План цен.
Valid from
    Время и дата, определяющие момент времени, **с** которого данное Направление участвует(будет участвовать) в процедуре роутинга.
Valid till
    Время и дата, определяющие момент времени, **до** которого данное Направление будет участвовать в процедуре роутинга.
Rate policy
	Политика определения цены звонка по данному Направлению.
	Возможны следующие варианты:

		- Fixed. Если выбран данный вариант, вычисление стоимости звонка будет проводиться по параметрам **Initial rate**, **Next rate**, **Connect fee** данного Направления.
		- Based on used dialpeer. Данный вариант подразумевает вычисление стоимости звонка по параметрам **Initial rate**, **Next rate**, **Connect fee** Диалпира, через который пройдет звонок. При этом имется возможность изменения стоимости, путем определения **Dp margin fixed** и/или **Dp margin percent**.
		- MIN(Fixed, Based on used dialpeer). Выбирается **минимальная** цена для звонка, при сравнии цены режима **Fixed** и режима **Based on used dialpeer**.
		- MAX(Fixed, Based on used dialpeer). Выбирается **максимальная** цена для звонка, при сравнии цены режима **Fixed** и режима **Based on used dialpeer**.
Initial interval
	Начальный интервал с момента начала звонка в секундах (по-умолчанию **1**). Позволяет установить для начала звонка иную тарификацию (пример: ***Первые 5 секунд бесплатно***).
Next interval
    Последующий интервал тарификации в секундах. С помощью данного интервала определяется шаг тарификации (пример ***Поминутная (60 секунд)***, ***Посекундная (1 секунда)***).
Use dp intervals
	Если активно - для расчета будут использоваться интервалы, указанные для Диалпира, через который пройдет звонок.

Initial rate
	Стоимость звонка для начального интервала **Initial rate**.
Next rate
	Стоимость звонка для последующего интервала **Next rate**.
Connect fee
	Плата за соединение. Позволяет назначить постоянную плату для каждого звонка по данному Направлению.
Profit control mode
	При выборе в данном выпадающем списке **no control** не будет проводиться вычисление прибыльности при сопоставлении цены системы и цены Поставщика для данного Направления и Диалпира. 	При выборе **per call** для каждого звонка будет проводиться вычисление прибыльности при сопоставлении цены системы и цены Поставщика для данного Направления и Диалпира. При этом, если стоимость звонка через Диалпир превышает стоимость звонка, установленную для данного Направления, то такие Диалпиры будут исключены на стадии роутинга.

Dp margin fixed
	В случае, если используется политика определения цены звонка **Based on used dialpeer**, имеется возможность установить постоянное значение цены, которая будет добавлена к стоимость звонка по цене Диалпира, через который пройдет звонок (пример: ***Добавляем 10 копеек к стоимости звонка, расчитанной по цене Диалпира***).
Dp margin percent
	В случае, если используется политика определения цены звонка **Based on used dialpeer**, возможно установить процентное соотношение к цене звонка Диалпира, через который пройдет звонок, которая будет добавлена к общей стоимости звонка (пример: ***Добавляем 10% к стоимости звонка, расчитанной по цене Диалпира***).
Asr limit
	Определяет пороговое значение ASR для данного Направления, при достижении которого администратору будет отправлено уведомление по электронной почте (значение от 0 до 1).
Acd limit
	Определяет пороговое значение ACD для данного Направления, при достижении которого администратору будет отправлено уведомление по электронной почте (в секундах).
Short calls limit
	Определяет пороговое количество Коротких звонков для данного Направления, при достижении которого администратору будет отправлено уведомление по электронной почте (значение от 0 до 1).

----

Dialpeers
~~~~~~~~~

Exclustive route
    Если в процессе маршрутизации оказалось, что в наборе пригодных маршрутов есть записи с установленным флагом **Exclustive route** - все маршруты без такого флага будут отброшены.
    Такое поведение позволяет отключить ремаршрутизацию вызова для какого-либо направления, в случае если для него существует эксклюзивный маршрут.

----


System
------

Nodes
~~~~~
Список нод YETI, подключенных к данному кластеру.
Каждая нода представляет собой независимую инсталляцию YETI-SEMS, которая взаимодействует с интерфейсом управления посредством RPC команд.

Атрибуты ноды:

Name
	Название ноды.
Pop
	Точка присутствия ноды (Point of presence). Может быть использовано для логической группировки нод (например, но дата-центрам).
Signalling ip
	IP-адрес ноды.
Signaling port
	Сетевой порт, с которого отправляются SIP-пакеты (по-умолчанию 5060).
Rpc endpoint
	IP-адрес и порт, на которых YETI-SEMS принимает команды управления RPC.

В режиме просмотра ноды (View) пользователю доступны следующие вкладки:

Details
	Общая информация о параметрах ноды
Active Calls Chart
	Отображает следующие графики:
	- Активные звонки за 24 часа
	- Количество звонков за месяц
Comments
	Комментарии, которые могут добавлять пользователи для данной ноды.


Networks
~~~~~~~~
Справочник сетей операторов. Содержит текстовое наименование оператора. Используется в справочнике телефонных префиксов, для указания оператора, к которому относится тот или иной префикс.

Network Prefixes
~~~~~~~~~~~~~~~~
Справочник телефонных префиксов, в котором содержится следующая информация:

    - префикс
    - наименование сети оператора
    - страна, к которой относится данный префикс

В базу данных YETI загружен справочник префиксов. При необходимости префиксы могут быть отредактированы, либо могуть быть созданы дополнительные префиксы.

Sensors
~~~~~~~
Система поддерживает зеркалирование данных сигнализации и медиа.
Этот функционал может быть использован для законного перехвата.
В настоящее время система поддерживает два метода инкапсуляции:

    - IP-IP tunnel
		Оригинальный пакет будет инкапсулирован в дополнительный заголовок туннелирования IP-IP.
		Этот режим позволяет маршрутизировать зеркалируемый трафик, что особенно полезно, когда
		оборудование в точке назначения не находится в том же широковещательном домене.
    - IP over Ethernet
		В данном режиме оригинальные пакеты будут инкапсулированы напряму в Ethernet фрейм с помощью raw-сокета.
		Используется в случаях, когда оборудование в точке назначение находится в том же самом L2 домене.

Сенсор и уровень его лога может быть выбран в настройках Гейтвея. Настройки Сенсора индивидуальны для легов A и B,
поэтому для зеркалирования обоих легов, Сенсоры должны быть настроены для Гейтвея терминации и оригинации.

System. SMTP connections
~~~~~~~~~~~~~~~~~~~~~~~~

Необходимо иметь хотя бы одно SMTP-соединение, для того чтобы YETI имел возможность отправлять счета и уведомления посредством электронной почты. Далее, можно выбрать созданное сединение в настройках Контрагента.

Атрибуты **SMTP connections**:

Name
    Уникальное название SMTP-соединения. Данная информация используется только в информационных целях и не влияет на работу системы.
Host
    IP-адрес или доменное имя SMTP-сервера.
Port
    TCP-порт, на котором SMTP-сервер принимает входящие соединения (*по-умолчанию: 25*).
From address
    Адрес электронной почты отправителя.
Auth user
	Имя пользователя для проведения процедуры авторизации на внешнем SMTP-сервере.
Auth password
    Пароль пользователя для проведения процедуры авторизации на внешнем SMTP-сервере.
Global
	Позволяет назначить данное соединение основным для всех Контрагентов.
