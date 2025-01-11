.. :maxdepth: 2

=============
Configuration
=============

Customer portal has one configuration file located at **/opt/yeti-client/dist/config.js**. This file will be overwritten during **yeti-client** package upgrade by default values so be ready to restore configuration after upgrade.

Config file example:

.. code-block:: js

	// eslint-disable-next-line
	CONFIG = {
	  yeti: {
	    apiBaseUrl: 'https://demo.yeti-switch.org',
	    blockedPages: new Set([]),
	  },
	};

	// Possible values for yeti.blockedpages set are 'rates', 'accounts', 'cdrs'


apiBaseUrl
	URL of customer API. It is strongly recommended use HTTPS for your API.

blockedPages
	This option allows you to hide some menu items in customer portal. For example **blockedPages: new Set(['rates','accounts'])** will hide rates and account information pages.


