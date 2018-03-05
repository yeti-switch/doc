.. :maxdepth: 2

========================================
Консольная утилита
========================================

:Site: https://yeti-switch.org/

yeti-cli позволяет администрировать кластер Yeti, она имеет дружелюбный интерфейс
с автоматической автоподстановкой команд по Tab


Yeti-cli может быть запущена напрямую из командной оболочки (shell)

.. code-block:: console

    # yeti-cli
    YETI-CLI version 0.1.3-11
    node changed from empty to 8
    anonymous@YETI:8> 

Также возможно использование yeti-cli как командной оболочки при входе в систему

.. code-block:: console

    $ ssh console@demo.yeti-switch.org -p 22000
    YETI-CLI version 0.1.3-11
    node changed from empty to 8
    admin@YETI:8>


.. note::

    Ваш публичный ключ должен быть добавлен в ваш аккаунт в веб-интерфейсе YETI
    и sshd должен быть настроен должным образом!.

.. toctree::
   :maxdepth: 2

   yeti-cli-commands