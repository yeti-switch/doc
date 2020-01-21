.. :maxdepth: 2


==========================
Repositories configuration
==========================

Most of servers may use same repositories set::

    deb http://ftp.us.debian.org/debian/ stretch main contrib non-free
    deb http://ftp.us.debian.org/debian/ stretch-updates main
    deb http://security.debian.org/ stretch/updates main
    deb http://pkg.yeti-switch.org/debian/stretch 1.10 main
    deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main

or for Debian 10::

    deb http://ftp.us.debian.org/debian/ buster main contrib non-free
    deb http://ftp.us.debian.org/debian/ buster-updates main
    deb http://security.debian.org/ buster/updates main
    deb http://pkg.yeti-switch.org/debian/buster 1.10 main
    deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main

    
System repositories can be changed by editing of file: /etc/apt/sources.list. Since we use our own package repository you have add our key to trusted. 
There is two ways to do it:

.. code-block:: console

	# apt-key adv --keyserver keys.gnupg.net --recv-key 9CEBFFC569A832B6

or

.. code-block:: console

	# wget http://pkg.yeti-switch.org/key.gpg -O - | apt-key add -
	

.. warning:: Since  yeti-web version 1.6.0 it is important to install Postgresql from  `PGDG <https://wiki.postgresql.org/wiki/Apt>`_ repository.

PGDG repository key also should be added to trusted list

.. code-block:: console

        # wget https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
