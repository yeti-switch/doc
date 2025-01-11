.. :maxdepth: 2


===================
LDAP Authentication
===================
Yeti's web-interface may use LDAP in order to authenticate users.

Copy configuration from example file

.. code-block:: console

    # cp /opt/yeti-web/config/ldap.yml.dist /opt/yeti-web/config/ldap.yml

and edit it::

  production:
    host: ldap-host.com
    port: 389 
    ssl: false
    attribute: uid
    base: ou=employees,dc=yeti,dc=com
    group_base: ou=groups,dc=yeti,dc=com
    required_groups:
      - ["member", "cn=yeti,ou=groups,dc=yeti,dc=com"]
    
* **host** - address of LDAP server
* **port** - port of LDAP server
* **ssl** - enable/disable SSL
* **attribute** - name of attribute which contains user login
* **base** - base DN where YETI will try find users
* **group_base** - base DN where YETI will try find groups
* **required_groups** - array of groups where user must present
* **member** - attribute where group stored
* **cn=yeti,ou=groups,dc=yeti,dc=com** - group


After editing file, restart YETI web interface

.. code-block:: console

    # systemctl restart yeti-web

