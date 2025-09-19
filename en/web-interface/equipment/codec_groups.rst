.. _codec_groups:

============
Codec Groups
============

Codec groups allow you to create arbitrary sets of media codecs and apply them to Gateways.
They may differ in codec composition, priority, and traffic parameters.
This flexibility enables handling of various call-processing scenarios.

Codec Group Attributes
======================

Id
    A unique identifier of the codec group.

Name
    The name of the codec group.

Ptime
    Packetization time in milliseconds.

    - If left empty, the system will use the default value (**20 ms**) in SDP offers.
    - In SDP answers, the system accepts the value announced by the other leg.

    Different packetization times between call legs trigger the transcoding mechanism.

Codecs
    Each codec entry has the following attributes:

    Codec
        The codec name. All available codecs are listed in the drop-down menu.

    Priority
        The codec priority determines its order in SDP offers and answers.

        - A higher value means a higher position.
        - Must be unique within the group.

    Dynamic Payload Type
        Optional override of the codec’s payload type
        (only values from the dynamic range are allowed).

    Format Parameters
        Custom value for the **fmtp** SDP attribute.

