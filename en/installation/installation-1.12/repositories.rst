.. :maxdepth: 2


==========================
Repositories configuration
==========================

Most of servers may use same repositories set::
    
    deb http://ftp.debian.org/debian/ bullseye main contrib non-free
    deb http://ftp.debian.org/debian/ bullseye-updates main
    deb http://security.debian.org/debian-security bullseye-security main

    deb http://pkg.yeti-switch.org/debian/bullseye 1.12 main
    deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main
    
System repositories can be changed by editing of file: /etc/apt/sources.list. Since we use our own package repository you have add our key to trusted. 

.. code-block:: console

	# wget http://pkg.yeti-switch.org/key.gpg -O - | apt-key add -
	

PGDG repository key also should be added to trusted list

.. code-block:: console

        # wget https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
