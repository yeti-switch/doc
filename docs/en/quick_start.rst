
================================
Guideline on Quick start of Yeti
================================

This Guideline contains step-by-step description of Yeti's configuration that will help to start it quickly just after finishing of the :ref:`installation process <install>`.
For configuration purposes :ref:`Yeti Web interface <web>` could be used.

**TODO**
    Preparation?
    Admin_user
    SMTP connection
    Template
    Codec Group
    PoP

    ----
    1.  Contractor A
    2.  Contractor B
    3.  Contact A
    4.  Contact B
    5.  Account A
    6.  Account B
    7.  Gateway Group A
    8.  Gateway Group B
    9.  Gateway
    10. Routing plan
    11. Rateplan
    12. Customer Auth

    Routing....
    13. Numberlist
    14. Routing Groups

+    Contractor <- SMTP connection
+    Contact <- Contractor <- admin_user
+    Account <- Contractor (*) <- Contact <- template
    Payment <- Account (*)
    Invoice <- Contractor (*) <- Account (*)
+    template
+    Gateway Group <- Contactor (Vendor) (*)
+    Gateway <- Contactor (*) <- Gateway Group <- PoP <- RadiusAuthProfile <- Codec Group (*)
    Disconnect Policies
    Disconnect Policy Codes <- Disconnect Policies (*)
    Registrations <- PoP (Any, >0) <- Node (Any, >0)
+   Codec Group
    LNP Database <- Driver (* static?)
    RadiusAuthProfile
    RadiusAccountingProfile
+    CustomerAuth <- Customer (*) <- Account (*) <- Gateway (*) <- Rateplan (*) <- Routing Plan (*) <- Numberlists <- PoP <- RadiusAuthProfile <- RadiusAccountingProfile <- Tags
+    Rateplan <- Contact
    Destination <- Rateplan (*) <- Tag
    Routing Groups
    DialPeer <- Routing Groups (*) <- Tag <- Contractor (Vendor only) (*) <- Account (*) <- Gateway <- Gateway Group
+    Routing Plan <- Roting groups
    Static Routes <- Routing plan (*) <- Contractor (Vendor only) (*)
    Routing Plan Lnp Rule <- Routing plan (*) <- Database (*)
    Numberlist <- Tag
    Numberlist items <- Numberlist (*) <- Tag
    Routing Tag
    Area
    Area Prefix <- Area (*?)
    Routing Tag Detection Rule <- Tag <- Area
    Routing Simulation <- PoP
    CDR Export <- Contractor (Customer)
    CDR Report <-  Contractor <- Contact
    Customer traffic <-  Contractor (Customer) (*) <- Contact
    Vendor traffic <-  Contractor (Vendor) (*) <- Contact
    Interval CDR report <- Contact
    Admin Users
    New API Access <- Contractor (Customer) (*) <- Accounts (?)
    PoP
    Node <- PoP (*)
    System Network Prefix <- Country <- Network (*)
    SMTP Connection

**TODO** - wbc