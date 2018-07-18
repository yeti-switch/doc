===================
General Information
===================

.. _general_information:


 YETI Web interface allows you to manage all possible entities in the system including CDRs, reporting, billing, routing, sytem configuration and others. It was developed using the most poweful and flexible web frameworks such as `Ruby on Rails <http://rubyonrails.org/>`_ and `Active Admin <http://www.activeadmin.info/>`_.

 General structure of the YETI Web interface includes tree main sections:

    -   Header & Menu line;
    -   Working Area;
    -   Footer line.

 General view of YETI Web interface is represented on the picture below:

 .. figure:: images/general.png
        :scale: 300 %
        :align: center
        :alt: YETI Web interface


Header & Menu line
==================

 Header line includes Yeti's logo, string of menu and current date&time. String of menu consists from following 11 sections (buttons).

 .. figure:: images/header.png
        :scale: 300 %
        :align: center
        :alt: YETI Web interface - header



.. toctree::
   :maxdepth: 1

   yeti-ui-dashboard
   yeti-ui-billing
   yeti-ui-equipment
   yeti-ui-routing
   yeti-ui-cdr
   yeti-ui-reports
   yeti-ui-rtd
   yeti-ui-logs
   yeti-ui-system
   yeti-ui-userprofile
   yeti-ui-logout


Working Area
============

    Working Area it is main component of the YETI Web interface that is used for configuration and controlling of the Yeti's state. Content of this area depends on chosen section (command of menu), but usually it contains two blocks:

 -   *General management line*. This line (is on the top of Working Area) that contains information (at the left side of the line) about object (or set of objects) that was chosen by user and (sometimes) the buttons (at the right side of the line) for managing of objects (creating, importing etc.);


 .. figure:: images/managementline.png
        :scale: 300 %
        :align: center
        :alt: YETI Web interface - general management line



 -   *Working Space*. Structure of this block depends on concrete menu item, but usually it could consists from following sections:

        -   :ref:`Filters <type_of_controls-filters>`;
        -   :ref:`List of Objects <type_of_controls-listofobjects>`;
        -   :ref:`Collection Actions <type_of_controls-collectionactions>`;
        -   :ref:`Form for entering information <type_of_controls-formforentering>`;
        -   :ref:`Graph <type_of_controls-graph>`;
        -   :ref:`Links <type_of_controls-history>`;
        -   :ref:`History <type_of_controls-informationaltabs>`;
        -   :ref:`Informational Tabs <type_of_controls-informationaltabs>`.

 .. figure:: images/workingspace.png
        :scale: 300 %
        :align: center
        :alt: YETI Web interface - working space


Footer line
===========

Footer line contains information about current versions of the main components of Yeti software, including version of YETI Web interface and routing procedures.


Type of controls
================

.. _type_of_controls-filters:


Filters
-------

 .. figure:: images/toc_filters.png
        :scale: 100 %
        :align: center
        :alt: YETI Web interface - Filters



.. _type_of_controls-listofobjects:


List of Objects
---------------

 .. figure:: images/toc_list_of_objects.png
        :scale: 100 %
        :align: center
        :alt: YETI Web interface - List of Objects



.. _type_of_controls-collectionactions:


Collection Actions
------------------

 .. figure:: images/toc_collection_actions.png
        :scale: 100 %
        :align: center
        :alt: YETI Web interface - Collection Actions



.. _type_of_controls-formforentering:


Form for entering information
-----------------------------


.. _type_of_controls-graph:


Graph
-----

.. _type_of_controls-links:


Links
-----


.. _type_of_controls-history:


History
-------


.. _type_of_controls-informationaltabs:


Informational Tabs
------------------

