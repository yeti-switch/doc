.. :maxdepth: 2

========================================
CLI utility
========================================

:Site: https://yeti-switch.org/

yeti-cli utility gives ability to manage yeti cluster.
It has frendly console interface with tab completions.

You can run yeti-cli directly from shell

.. code-block:: console

    # yeti-cli
    YETI-CLI version 0.1.3-11
    node changed from empty to 8
    anonymous@YETI:8> 

Also you can use yeti-cli as shell and run it on login

.. code-block:: console

    $ ssh console@demo.yeti-switch.org -p 22000
    YETI-CLI version 0.1.3-11
    node changed from empty to 8
    admin@YETI:8>

.. note::

    You public key must be added to your account in yeti web management interface
    and you have to configure sshd. Look in instalation section.

.. toctree::
   :maxdepth: 2

   yeti-cli-commands