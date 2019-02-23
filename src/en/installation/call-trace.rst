.. :maxdepth: 2


================================
Call trace storage configuration
================================


SEMS and Web are running on same server
---------------------------------------

Edit /etc/nginx/sites-enabled/yeti-web and replace **location ~ ^/dump/(.*)$** with following content::
    
    location ~ ^/dump/(.*)$ {
                internal;
                set $filename $1;
                proxy_hide_header Content-Disposition;
                add_header Content-Disposition 'attachment; filename="$filename"';
                root /var/spool/sems;
    }

Restart nginx service:
    
.. code-block:: console

    # systemctl restart nginx

SEMS and Web located on different servers
-----------------------------------------


todo

