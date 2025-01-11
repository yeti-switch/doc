
.. _admin_users:

Admin Users
~~~~~~~~~~~

Users that have access to this YETI WEB interface. This section allow to control credentials for Yeti Admin interface and :ref:`Yeti Admin API <admin_api>`

Attributes:
```````````

    Id
       Unique User's id.
    Email
       Email of this *Admin User*.
    Username
       Unique User's name.
    Roles
        Access role, defines access level. Access roles and roles permissions can be defined in configuration file **/opt/yeti-web/config/policy_roles.yml**
    Visible columns
        Internal RO data describes tables columns visible for admin user.
    Per page
        Internal RO data - personal pagination configuration.
    Saved filters
        Internal RO data - personal filters presets

.. note::
   You can also disable user by pressing **Disable** button in the top-right corner of the Working Area or enable it back by pressing **Enable** button. This feature is enabled only for system admin.


