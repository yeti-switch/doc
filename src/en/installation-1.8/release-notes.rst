.. :maxdepth: 2

=============
Release notes
=============


Routing logic changes in 1.8 version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    * Ability to limit Account capacity in both direction - see **total capacity** attribute of Account
    * Ability to define maximum destination rate allowed for account. This feature useful to prevent traffic termination to fraudulent destinations
    * Now it is possible to define VAT for account and calculate call price for call originator with VAT
    * Per Account maximum call duration limitation.
    * **Routeset Discriminators** allows to have few routeset from same vendor. Yeti will try to use few routes from same vendor if such routes have different Routeset Discriminator. Previously it was not possible to have two different routeset of same vendor in same Routing Plan.
    * Ability to define maximum rerouting attempts per routing plan. Previously  maximum rerouting attempts was hardcoded to 10
    * New balancing modes for Gateway Group
    * Numberlist processing at termination gateway(after routing). Now it is possible configure massive number rewrite before call termination to specific gateway.

SEMS changes in 1.8 version
~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    * Completely new SEMS configuration format and configuration validation
    * TLS transport protocol
    * IPv6 support and flexible protocol priority configuration
    * **sips** SIP schema support
    * SRTP with DTLS and SDES mechanisms
    * RTCP processing
    * RTCP/RTP statistics saving to database. It is possible to analyze calls quality using statistics data.
        
Admin UI changes
~~~~~~~~~~~~~~~~
    * Rails was upgraded to 5.2
    * ActiveAdmin was upgraded
    * Role Based Access Control. It is possible to limit access level of system operator
    
