===================
General Information
===================

.. _general_information:


 YETI Web interface allows you to manage all possible entities in the system including CDRs, reporting, billing, routing, sytem configuration and others. It was developed using the most powerful and flexible web frameworks such as `Ruby on Rails <https://rubyonrails.org/>`_ and `Active Admin <https://activeadmin.info/>`_.

 General structure of the YETI Web interface includes tree main sections:

    -   Header & Menu line;
    -   Working Area;
    -   Footer line.

 General view of YETI Web interface is represented on the picture below:

 .. figure:: images/general.png
        :alt: YETI Web interface


Header & Menu line
==================

 Header line includes Yeti's logo, string of menu and current date&time. String of menu consists of following 11 sections (buttons).

 .. figure:: images/header.png
        :alt: YETI Web interface - header
        
**Logout** button is used for exit from Yeti Web Interface.

Working Area
============

    Working Area it is main component of the YETI Web interface that is used for configuration and controlling of the Yeti's state. Content of this area depends on chosen section (command of menu), but usually it contains two blocks:

 -   *General management line*. This line (is on the top of Working Area) that contains information (at the left side of the line) about object (or set of objects) that was chosen by user and (sometimes) the buttons (at the right side of the line) for managing of objects (creating, importing etc.);


 .. figure:: images/managementline.png
        :alt: YETI Web interface - general management line



 -   *Working Space*. Structure of this block depends on concrete menu item, but usually it could consists of following sections:

        -   :ref:`Filters <type_of_controls-filters>`;
        -   :ref:`List of Objects <type_of_controls-listofobjects>`;
        -   :ref:`Collection Actions <type_of_controls-collectionactions>`;
        -   :ref:`Form for entering information <type_of_controls-formforentering>`;
        -   :ref:`Graph <type_of_controls-graph>`;
        -   :ref:`Links <type_of_controls-history>`;
        -   :ref:`History <type_of_controls-informationaltabs>`;
        -   :ref:`Informational Tabs <type_of_controls-informationaltabs>`.

 .. figure:: images/workingspace.png
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
        :alt: YETI Web interface - Filters



 Filters are used for selecting necessary objects from the whole list of objects, by using specific parameters. Usually filters contain three types of controls:

      -       **Drop-down selection list**. It can be used for selecting objects where necessary parameter is equal parameter that was selected in this list. If you don't want to use filtering by this parameter you can just leave (or choose) value: **Any** in the list;
      -       **Numeric-based filter**. It can be used for selecting objects where numeric value of necessary parameter  equals, greater or less than value that you entered in;
      -       **String-based filter**. It can be used for selecting objects where string value of necessary parameter contains, equals, starts or ends with necessary value.

.. note::
   You can enable **Persist** checkbox in the top-right part of *Filters* section for using these filters on the permanent basis. In this case next time when you back to the objects list the saved filters will be automatically applied. You can review the Information about stored filters on the :ref:`User's profile page <user_profile>`.



.. _type_of_controls-listofobjects:


List of Objects
---------------

 .. figure:: images/toc_list_of_objects.png
        :alt: YETI Web interface - List of Objects



 List of Objects in Yeti usually consists of three sections:

      -   **Selection & group actions line**. Controls of this line could be used for instant selection of objects, that have a some common property (f.e. all enabled object, all locked etc.), from the list bellow. Sometimes it also contains controls for batch actions (delete selected, disable selected etc.) that can be used for doing the same actions for the group of chosen objects;
      -   **Page scrolling lines**. These lines is located on the top and at the bottom of table with objects. Controls of these lines could be used for the listing of objects in the table  in page by page mode. Also them could be used for changing amount of objects that will be shown in table at same time;
      -   **Table of objects**. The table section consist of header, that can be used for the sorting of objects in the table, and list of objects where each line contains not only some properties of object, but also controls for managing them (like view, edit and delete). Just press on the link with necessary command for applying it.

.. note::
   Selected amount of objects (per page) for all types of objects can be reviewed on the :ref:`User's profile page <user_profile>`. Once chosen this information will be stored in system up to the next changing.


.. note::
   You can also download all data from the table in the comma-separated values format by clicking on **CSV** link that is usually located at the bottom scrolling line together with information about general amount of objects that were displayed.


.. note::
   Sometimes information about some related objects could be displayed as a link in the table of objects. In this case you can press on this link for moving to the viewing properties of this related object.

.. _type_of_controls-collectionactions:


Collection Actions
------------------

 .. figure:: images/toc_collection_actions.png
        :alt: YETI Web interface - Collection Actions


**TODO**



.. _type_of_controls-formforentering:


Form for entering information
-----------------------------


.. figure:: images/toc_form_for_entering.png
       :alt: YETI Web interface - Form for entering information



Forms for entering information are used for creation or editing information about some objects. Controls for entering information sometimes are divided into tabs or/and sections. Following types of controls are used for entering information in Yeti:

        -   **Textual input field** is used for entering some textual information like object name, IP-address, URI etc.;
        -   **Numeric input field** is used for entering some digital information like port-number, priority etc. You also can use special controls on the right side of the input field for increasing or decreasing value by the 1;
        -   **True/False checkbox** is used for enabling or disabling some properties of objects;
        -   **Single-record selection list** is used for choosing some value from the list of possible variants. Sometimes it is possible to choose **None** or **Any**;
        -   **Multiple-records selection list** is used for choose more than one value from the list. At any time you can remove chosen value from the list of selected;
        -   **Date&Time input field** is used for entering information about date & time like *Valid from* and *Valid to* fields.



.. _type_of_controls-graph:


Graph
-----


.. figure:: images/toc_graph.png
       :alt: YETI Web interface - Graph


Graphs (or charts) could be used for displaying of changes some data on the period of time. Typically they used for displaying the real-time data like an active calls.


.. _type_of_controls-links:


Links
-----

.. figure:: images/toc_links.png
       :alt: YETI Web interface - Links


Links are usually used in the object's view mode for quick reference to the other objects that are related to the object that is currently displayed. For example, if you will click on the link **Payments** in the :ref:`Account's <accounts>` view mode the all payments that were made for this *Account* will be displayed.

.. _type_of_controls-history:


History
-------

.. figure:: images/toc_history.png
       :alt: YETI Web interface - History


History is used for reviewing information about changes of some objects in the Yeti's database during from the time of creation. You can view the history of changes for the object, but can't return back to the one of the previous versions.

.. _type_of_controls-informationaltabs:


Informational Tabs
------------------

.. figure:: images/toc_inform_tabs.png
       :alt: YETI Web interface - Informational Tabs


Informational tabs are used for switching between sections of data in the creation or editing mode for the complex objects in Yeti.
