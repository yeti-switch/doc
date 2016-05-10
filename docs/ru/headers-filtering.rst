
.. :maxdepth: 2

=========================
Фильтрация SIP заголовков
=========================

.. _headers_fitering:

Фильтрация заголовков позволяет настроить передачу SIP заголовков с одного лега звонка на другой. После вычисления маршрутизации YETI выполняет фильтрацию два раза - для оригинационного гейтвея и для терминационного.
Параметр гейтвея **Transit headers from origination** описывает передачу залоговков от LegA к LegB, параметр **Transit headers from termination** - от LegB к LegA.

Например входящий звонок приходит на гейтвей **orig_gw** и терминируется в гейтвей **term_gw** c с соответствующими настройками

orig_gw:
    * Transit headers from origination= X-TEST-HEADER, X-YETI*
    * Transit headers from termination= X-YETI*
    
term_gw:
    * Transit headers from origination= X-TEST-HEADER
    * Transit headers from termination= X-YETI-AUTH*
    


Тогда при получении INVITE от orig_gw с такими заголовками:
::

    X-TEST-HEADER: 123
    X-YETI-HEADER1: 321
    X-YETI-AUTH-HEADER: 333

Он будет отфильтрован последовательно два раза(фильтром  X-TEST-HEADER, X-YETI* и X-TEST-HEADER) и после фильтрации будет сформирован INVITE к term_gw с такими хидерами:
::

    X-TEST-HEADER: 123


При этом если от term_gw будет получено 200OK сообщение с хидерами:
::

    X-YETI-AUTH-324: 333
    X-YETI-TEST: 333

Заголовки будут фильтроваться два раза(фильтром X-YETI-AUTH*, в а затем фильтром  X-YETI*) и после фильтрации будет сформировано 200OK сообщение к orig_gw с такими заголовками:
::

    X-YETI-AUTH-324: 333







