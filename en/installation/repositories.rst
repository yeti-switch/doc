.. :maxdepth: 2


==========================
Repositories configuration
==========================

Most of servers you can use same repositories set, for Debian 8::

    deb http://ftp.us.debian.org/debian/ jessie main contrib non-free
    deb http://ftp.us.debian.org/debian/ jessie-updates main
    deb http://security.debian.org/ jessie/updates main
    deb http://pkg.yeti-switch.org/debian/jessie 1.7 main
    
And for Debian 9::

    deb http://ftp.us.debian.org/debian/ stretch main contrib non-free
    deb http://ftp.us.debian.org/debian/ stretch-updates main
    deb http://security.debian.org/ stretch/updates main
    deb http://pkg.yeti-switch.org/debian/stretch 1.7 main

    
System repositories can be changed by editing of file: /etc/apt/sources.list. Since we use our own package repository you have add our key to trusted. 
There is two ways to do it:

.. code-block:: console

	# apt-key adv --keyserver keys.gnupg.net --recv-key 9CEBFFC569A832B6

or

.. code-block:: console

	# wget http://pkg.yeti-switch.org/key.gpg -O - | apt-key add -
	

.. warning:: Since  yeti-web version 1.6.0 it is important to install Postgresql from  `PGDG <https://wiki.postgresql.org/wiki/Apt>`_ repository.

On your datadabase hosts(routing and CDR) you should add additional PGDG repository::

    deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main
    
Or for Debian 9::

    deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main

You can add PGDG repository key to trusted using command:

.. code-block:: console

        # wget https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
