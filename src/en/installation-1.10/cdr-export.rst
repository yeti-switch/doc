.. :maxdepth: 2


=========================
CDR exports configuration
=========================

CDR export feature allow operator unload CDR from database to CSV file. Yeti using `Postgresql COPY <https://www.postgresql.org/docs/current/sql-copy.html>`_ method for CSV generation, so file will be saved on disk by postgresql.

.. figure:: cdr-export-download.png

    CDR export download link
    
Yeti Web interface using Nginx `X-Accel-Redirect <https://www.nginx.com/resources/wiki/start/topics/examples/x-accel/>`_ mechanism to provide files download so CDR export download request to web interface will generate 200Ok with header **X-Accel-Redirect: /x-redirect/cdr_export/4.csv** and main goal of this configuration - configure Nginx to properly handle this redirect.


CDR database and yeti-web on same server
----------------------------------------

Edit **/etc/nginx/sites-enabled/yeti-web** and replace **/x-redirect/cdr_export** with following content:
    
.. code-block:: nginx

    location /x-redirect/cdr_export {
        internal;
        alias /tmp;
    }
    
Where **/tmp** is export directory defined **/opt/yeti-web/config/yeti_web.yml**:

.. code-block:: yaml

    cdr_export:
        dir_path: "/tmp"
       
.. warning:: You can use any directory as **cdr_export dir_path** but this directory should be writable by **postgres** system user(who running postgresql) and readable by **www-data** system user(who running nginx).

Restart nginx service:

.. code-block:: console
    
    # systemctl restart nginx

CDR database and yeti-web located on different servers
------------------------------------------------------

Configure nginx on WEB interface server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit **/etc/nginx/sites-enabled/yeti-web** and replace **/x-redirect/cdr_export** with following content:


.. code-block:: nginx

    location /x-redirect/cdr_export {
        internal;
        proxy_pass http://<CDR SERVER ADDRESS>:8080;
    }
    
Where **<CDR SERVER ADDRESS>** is IP address of remote CDR database server
    
Configure nginx on CDR database server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install **nginx** package and add such server block to /etc/nginx/nginx.conf:

.. code-block:: nginx

        server {
                listen 8080;
                server_name _;
                root /tmp;

                allow <WEB INTERFACE SERVER ADDRESS>/32;
                deny all;
                
                location /x-redirect/cdr_export {
                        alias /tmp;
                }
        }

Where **/tmp** is **cdr_export dir_path** from **/opt/yeti-web/config/yeti_web.yml** config file and **<WEB INTERFACE SERVER ADDRESS>** is IP address of your web interface server.

.. warning:: Make sure you configure **allow/deny** ACL properly. Wrong nginx configuration could cause data leak epecially if CDR server using public IP address(we are recommending to use private IP for CDR db server)

Restart nginx service:
    
.. code-block:: console

    # systemctl restart nginx
    

    




