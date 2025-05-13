.. :maxdepth: 2

.. call_trace:

================================
Call trace storage configuration
================================


SEMS and Web are running on same server
---------------------------------------

Edit ``/etc/nginx/sites-enabled/yeti-web`` and replace ``location ~ ^/dump/(.*)$`` with following content:
    
.. code-block:: nginx

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

Configure nginx on WEB interface server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create directory ``/var/www/dump`` with owner ``www-data`` to store PCAP files.

Edit ``/etc/nginx/sites-enabled/yeti-web`` and add such server block:

.. code-block:: nginx

    server {
        listen <WEB INTERFACE IP>:8081;
        server_name _;
        access_log /var/log/nginx/pcap-upload.access.log;
        error_log /var/log/nginx/pcap-upload.error.log;

        root /var/www/dump;

        location /upload {
            allow <SEMS IP>/32;
            deny all;
                        
            alias /var/www/dump;
            dav_methods PUT;
            dav_access group:rw all:r;
            create_full_put_path on;
            client_max_body_size 10000M;
        }
    }
    

Edit ``/etc/nginx/sites-enabled/yeti-web`` and replace ``location ~ ^/dump/(.*)$`` with following content:

.. code-block:: nginx
    
    location ~ ^/dump/(.*)$ {
        internal;
        set $filename $1;
        proxy_hide_header Content-Disposition;
        add_header Content-Disposition 'attachment; filename="$filename"';
        root /var/www;
    }

Restart nginx service:
    
.. code-block:: console

    # systemctl restart nginx
    
Configure SEMS to upload traces to WEB interface server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add ``http_client`` module configuration to ``modules`` section of ``/etc/sems/sems.conf``::

    modules {
        path = /usr/lib/sems/plug-in
        config_path = /etc/sems/etc/
    ...
        module "http_client" {
            resend_interval = 5000
            resend_queue_max = 10000
        
            destination "pcap" {
                mode = put
                urls = { http://<WEB INTERFACE IP>:8081/upload }
                on_success { 
                    action = remove
                }
                on_failure { 
                    action = requeue 
                }
            }
        }
    ...
    }
    
Add ``pcap_upload_queue = pcap`` directive to section ``general`` of ``/etc/sems/sems.conf``::

    general {
        ...
        pcap_upload_queue = pcap
        ...
    }


Restart SEMS:
    
.. code-block:: console

    # systemctl restart sems
    




