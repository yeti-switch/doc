
================================
Guideline on Quick start of Yeti
================================

This Guideline contains step-by-step description of Yeti's configuration that will help to start it quickly just after finishing of the :ref:`installation process <install>`.
For configuration purposes :ref:`Yeti Web interface <web>` could be used.

**TODO**
    Contractor <- SMTP connection
    Contact <- Contractor <- admin_user
    Account <- Contractor (*) <- Contact <- template
    Payment <- Account (*)
    Invoice <- Contractor (*) <- Account (*)
    template
    Gateway Group <- Contactor (*)
    Gateway <- Contactor (*) <- Gateway Group <- PoP <- RadiusAuthProfile <- Codec Group (*)
    Disconnect Policies
    Disconnect Policy Codes <- Disconnect Policies (*) <- Code (*)
    Registrations <- PoP (Any, >0) <- Node (Any, >0)
    Codec Group <- Codec (*)
    LNP Database <- Driver (* static?)
    RadiusAuthProfile
    RadiusAccountingProfile
    CustomerAuth <- Customer (*) <- Account (*) <- Gateway (*) <- Rateplan (*) <- Routing Plan (*) <- Numberlists <- PoP <- RadiusAuthProfile <- RadiusAccountingProfile <- Tags
    Rateplan <- Contact
    Destination <- Rateplan (*) <- Tag
    Routing Groups
    DialPeer <- Routing Groups (*) <- Tag <- Contractor (Vendor only) (*) <- Account (*) <- Gateway <- Gateway Group
    Routing Plan <- Roting groups
    Static Routes <- Routing plan (*) <- Contractor (Vendor only) (*)
    Routing Plan Lnp Rule <- Routing plan (*) <- Database (*)
    Numberlist <- Tag
    Numberlist items <- Numberlist (*) <- Tag
    Routing Tag
    Area
    Area Prefix <- Area (*?)
    Routing Tag Detection Rule <- Tag <- Area
    Routing Simulation <- PoP
**TODO** - wbc