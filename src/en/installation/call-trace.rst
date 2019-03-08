.. :maxdepth: 2


================================
Call trace storage configuration
================================


SEMS and Web are running on same server
---------------------------------------

Edit **/etc/nginx/sites-enabled/yeti-web** and replace **location ~ ^/dump/(.*)$** with following content::
    
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

Create directory **/var/www/dump** to store PCAP files.

Edit **/etc/nginx/sites-enabled/yeti-web** and add such server block::

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
            create_full_put_path  on;
            client_max_body_size 10000M;
        }
    }
    

Edit **/etc/nginx/sites-enabled/yeti-web** and replace **location ~ ^/dump/(.*)$** with following content::
    
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

Add directive **pcap_upload_queue=pcap** to **/etc/sems/sems.conf**

Create configuration file **/etc/sems/etc/http_client.conf** with following content::

    resend_interval=5000
    resend_queue_max=10000

    destinations=pcap

    pcap_mode=put
    pcap_url=http://<WEB INTERFACE IP>:8081/upload
    pcap_succ_action=remove
    pcap_fail_action=requeue
    
    

Restart SEMS:
    
.. code-block:: console

    # systemctl restart sems
    




