
.. _rtp_statistics:

.. |br| raw:: html

   <br />

RTP Statistics
~~~~~~~~~~~~~~

Yeti calculates statistics for RTP streams processed by system. Such statistics usually based on two sources - internal RTP counters and remote statistics received by RTCP protocol. In case of lack of RTCP support on remote gateway, RTCP related measurement will be unavailable(empty). Other possible case - wrong RTCP implementation on remote side will cause invalid data in RTCP related counters. Attributes marked as **Local data** is not depend on remote RTCP implementation.


**RTP Statistics**'s attributes:
````````````````````````````````
    Id
        Records unique identifier
    Local Tag
        RTP stream owner session local_tag. Local tag Correlates with local_tag and  legb_local_tag fields of CDR
    Time Start
        RTP stream instance create time
    Time End
        RTP stream instance end time (actually the time when statistics requested from stream)
    Pop
        Pop
    Node
        SEMS node name that collected this statistics
    Gateway
        Remote gateway name
    Gateway External
        External ID of remote gateway
    RTCP RTT Min
        Minimal round trip time reported by remote gateway using RTCP protocol. RTT calculated as delay since last SR (DLSR): 32 bits. See `RFC <https://tools.ietf.org/html/rfc3550#section-6.4.1>`_ |br|
        Unit - **μs**
    RTCP RTT Max
        Maximal round trip time reported by remote gateway using RTCP protocol |br|
        Unit - **μs**    
    RTCP RTT Mean
        `Mean <https://en.wikipedia.org/wiki/Mean>`_ round trip time reported by remote gateway using RTCP protocol |br|
        Unit - **μs**
    RTCP RTT Std
        `Standard deviation <https://en.wikipedia.org/wiki/Standard_deviation>`_ of round trip time reported by remote gateway using RTCP protocol |br|
        Unit - **μs**
    Rx RTCP RR Count
        Count of `RTCP Receiver Reports <https://tools.ietf.org/html/rfc3550#section-6.4.2>`_ received from remote gateway. **Local data**.
    Rx RTCP Sr Count
        Count of `RTCP Sender Reports <https://tools.ietf.org/html/rfc3550#section-6.4.1>`_ received from remote gateway.  **Local data**.
    Tx RTCP RR Count
        Count of `RTCP Receiver Reports <https://tools.ietf.org/html/rfc3550#section-6.4.2>`_ sent to remote gateway by yeti.  **Local data**.
    Tx RTCP SR Count
        Count of `RTCP Sender Reports <https://tools.ietf.org/html/rfc3550#section-6.4.1>`_ sent to remote gateway by yeti.  **Local data**.
    Rx Ssrc
        `SSRC <https://tools.ietf.org/html/rfc3550#section-5.1>`_ of incoming stream.  **Local data**.
    Local Host/Local Port
        Address of local UDP socket used to RTP receiving and transmission.  **Local data**.
    Remote Host/Remote Port
        Address of remote UDP socket.  **Local data**.
    Rx Packets
        Count of received RTP packets.  **Local data**.
    Rx Bytes
        Unit: **byte** |br|
        Data amount of received RTP packets. **Local data**.
    Rx Total Lost
        Count of lost incoming RTP packets.  **Local data**.
    Rx Payloads Transcoded
        RTP payloads that was transcoded after receiving. Field is empty is transcoding was not used for RTP processing.  **Local data**.
    Rx Payloads Relayed
        RTP payloads that was relayed to other call leg without transcoding.  **Local data**.
    Rx Decode Errors
        Count of received RTP packets that was not decoded??  **Local data**.
    Rx Out Of Buffer Errors
        Count of RTP packets read from socket that can't be saved due lack of free slots in stream ring-buffer??  **Local data**.
    Rx Rtp Parse Errors
        Count of received RTP packets that was not parsed??  **Local data**.
    Rx Packet Delta Min
        Minimal inter-packet interval on RX stream.  **Local data**. |br|
        Unit - **μs**
    Rx Packet Delta Max
        Maximal inter-packet interval on RX stream.  **Local data**. |br|
        Unit - **μs**
    Rx Packet Delta Mean
        Mean inter-packet interval for on RX stream.  **Local data**. |br|
        Unit - **μs**
    Rx Packet Delta Std
        `Standard deviation <https://en.wikipedia.org/wiki/Standard_deviation>`_ of inter-packet interval on RX stream.  **Local data**. |br|
        Unit - **μs**
    Rx Packet Jitter Min
        Minimal RTP jitter calculated from inter-packet interval on RX stream. **Local data**. |br|
        Unit - **μs**
    Rx Packet Jitter Max
        Maximal RTP jitter calculated from inter-packet interval on RX stream. **Local data**. |br|
        Unit - **μs**
    Rx Packet Jitter Mean
        Mean RTP jitter calculated from inter-packet interval on RX stream. **Local data**. |br|
        Unit - **μs**
    Rx Packet Jitter Std
        `Standard deviation <https://en.wikipedia.org/wiki/Standard_deviation>`_ of RS stream jitter. **Local data**. |br|
        Unit - **μs**
    Rx RTCP Jitter Min
        Minimal RTP jitter calculated from RTCP reports (in case if remote side sent such reports) on RX stream |br|
        Unit - **μs**
    Rx RTCP Jitter Max
        Maximal RTP jitter calculated from RTCP reports (in case if remote side sent such reports) on RX stream |br|
        Unit - **μs**
    Rx RTCP Jitter Mean
        Mean RTP jitter calculated from RTCP reports (in case if remote side sent such reports) on RX stream |br|
        Unit - **μs**
    Rx RTCP Jitter Std
        `Standard deviation <https://en.wikipedia.org/wiki/Standard_deviation>`_ of RTP jitter calculated from RTCP reports (in case if remote side sent such reports) on RX stream |br|
        Unit - **μs**
    Tx Ssrc
        `SSRC <https://tools.ietf.org/html/rfc3550#section-5.1>`_ of transmitted stream. **Local data**.
    Tx Packets
        Count of packets trasmitted by yeti to remote gateway. **Local data**.
    Tx Bytes
        Unit: **byte** |br|
        Data amount trasmitted by yeti to remote gateway.  **Local data**.
    Tx Total Lost
        Count of packets trasmitted by yeti to remote gateway and lost during delivering to remote gateway. Value calculated as difference between count of transmitted packets and count of received packets on remote side(reported by RTCP)
    Tx Payloads Transcoded
        RTP payloads that was transcoded before transmitting. Field is empty is transcoding was not used for RTP processing. **Local data**.
    Tx Payloads Relayed
        RTP payloads that was relayed from other call leg without transcoding. **Local data**.
    Tx RTCP Jitter Min
        Unit: **ms** |br|
        Minimal RTP jitter calculated from RTCP reports (in case if remote side sent such reports) on transmitted stream
    Tx RTCP Jitter Max
        Unit: **ms** |br|
        Maximal RTP jitter calculated from RTCP reports (in case if remote side sent such reports) on transmitted stream
    Tx RTCP Jitter Mean
        Unit: **ms** |br|
        Mean RTP jitter calculated from RTCP reports (in case if remote side sent such reports) on transmitted stream
    Tx RTCP Jitter Std
        Unit: **ms** |br|
        `Standard deviation <https://en.wikipedia.org/wiki/Standard_deviation>`_ of RTP jitter calculated from RTCP reports (in case if remote side sent such reports) on trasmitted stream
