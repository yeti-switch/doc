.. :maxdepth: 2

========================================
YETI LDAP Authentification configuration
========================================

:Site: https://yeti-switch.org/

.. image:: https://yeti-switch.org/img/logo.png

Information
===========

Yeti support LDAP Authentification for web interface.


Configuration
=============

Copy configuration from example file::

    cp /home/yeti-web/config/ldap.yml.dist /home/yeti-web/config/ldap.yml

and edit it::

    production:
      host: yeti-host.com
      port: 389 
      ssl: false
      attribute: uid
      base: ou=employees,dc=yeti,dc=com
      group_base: ou=groups,dc=didww,dc=com
      required_groups:
        - ["member", "cn=yeti,ou=groups,dc=yeti,dc=com"]
    
* **host** - address of LDAP server
* **port** - port of LDAP server
* **ssl** - enable/disable SSL
* **attribute** - name of attribute wich contains user login
* **base** - base DN where YETI will try find users
* **group_base** - base DN where YETI will try find groups
* **required_groups** - array of groups where user must present
* **member** - attribute where group stored
* **cn=yeti,ou=groups,dc=yeti,dc=com** - group


After editing file, restart YETI web interface::

    /etc/init.d/yeti-web restart
