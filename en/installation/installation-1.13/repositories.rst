.. :maxdepth: 2


==========================
Repositories configuration
==========================

Most of servers may use same repositories set::

    deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
    deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
    deb http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware
    deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

    deb https://deb.yeti-switch.org/debian/1.13 bookworm main
    deb https://apt.postgresql.org/pub/repos/apt/ bookworm-pgdg main
    
System repositories can be changed in **/etc/apt/sources.list**. Since we use our own package repository you have add our key to trusted. 

.. code-block:: console

    # wget https://deb.yeti-switch.org/yeti.gpg -O /etc/apt/trusted.gpg.d/yeti-key.asc

PGDG repository key also should be added to trusted list

.. code-block:: console

    # wget https://www.postgresql.org/media/keys/ACCC4CF8.asc -O /etc/apt/trusted.gpg.d/pgdg-key.asc

