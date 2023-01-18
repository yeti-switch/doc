.. :maxdepth: 2


======================
Invoice PDF generation
======================

If you need to generate invoices in PDF format, you have to install additional LibreOffice packages. 

.. code-block:: console

    # apt install unoconv libreoffice-core

Service **yeti-libreoffice-headless** is disabled by default, you have to enable it.

.. code-block:: console

    # systemctl enable yeti-libreoffice-headless

Run it

.. code-block:: console

    # systemctl start yeti-libreoffice-headless


