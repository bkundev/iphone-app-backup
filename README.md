iphone-app-backup
=================

A quick hack to backup a certain directory (and subdirectories) from an iPhone application. 

Note: As this tool is highly individualised to my requirements, it's highly tailored - i'd advise against using 
      this as is!

Takes the following arguments:

* App-Bundle-Identifier: The bundle identifier of the app (or app name!)
* Remote Path:           The root directory from the application base on the phone to backup
* Local Path:            The local directory to backup to
* Message:               The git commit message to use when commiting the backup directory.

=================

Warning: As mentioned above, this is purely an individual quick utility hack to aid my workflow - not something advised
         to be used out of the box!
         
=================

Thanks goes to Tristero and other folks over at BitBucket for the MobileDeviceAccess objective-c library.
