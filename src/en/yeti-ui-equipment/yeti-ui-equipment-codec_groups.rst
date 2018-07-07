
.. _codec_groups:

Codec groups
~~~~~~~~~~~~

Codec groups allows to create arbitrary sets of media codecs and applies them to the Gateways. Groups can differ in the composition of codecs, their priority and traffic codes, which allows to process different scenarios when processing calls.

**Codec group**'s attributes:
`````````````````````````````
    Id
        Unique Codec group's id.
    Name
        Codec group's name.
    Codecs
        Each codec has the following attributes:

            Codec
                Codec's name. All available codecs are presented in drop-down list.
            Priority
                Codec priority in SDP. Less value means higher priority.
                Must be unique within group.
            Dynamic payload type
                Payload type override (allowed only values from dynamic range).
            Format parameters
                Non-standard value for fmt param SDP attribute.


