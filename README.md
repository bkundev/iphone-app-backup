iPhone App Backup
=================

![alt tag](http://ronanturner.net/statuses/works-yes.png)
![alt tag](http://ronanturner.net/statuses/status-inactive.png)

1. Overview
--------

Note: Whilst marked as working because, as far as I'm aware, nothing has changed with iDevice backing up, this is a highly tailored script to my requirements. Be careful when attempting to use as it will likely need playing with to support your needs.

A quick hack to backup a certain directory (and subdirectories) from an iPhone application. 

Takes the following arguments:

* App-Bundle-Identifier: The bundle identifier of the app (or app name!)
* Remote Path:           The root directory from the application base on the phone to backup
* Local Path:            The local directory to backup to
* Message:               The git commit message to use when commiting the backup directory.
         
Thanks goes to Tristero and other folks over at BitBucket for the MobileDeviceAccess objective-c library.
