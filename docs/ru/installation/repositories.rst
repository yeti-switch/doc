.. :maxdepth: 2


==========================
Repositories configuration
==========================

All servers can use same repositories set::

    deb http://ftp.us.debian.org/debian/ jessie main contrib non-free
    deb http://ftp.us.debian.org/debian/ jessie-updates main
    deb http://security.debian.org/ jessie/updates main
    deb http://pkg.yeti-switch.org/debian/jessie stable main ext
    

System repositories can be changed by editing of file: /etc/apt/sources.list. Since we use our own package repository you have add our key to trusted. 
There is two ways to do it:

.. code-block:: console

	# apt-key adv --keyserver keys.gnupg.net --recv-key 9CEBFFC569A832B6

or

.. code-block:: console

	# wget http://pkg.yeti-switch.org/key.gpg -O - | apt-key add
    
