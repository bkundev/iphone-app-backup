
#import "DeviceManager.h"
#import "BackupManager.h"

@implementation DeviceManager

-(id) init {
  
  [NSException raise:@"Default constructor in DeviceManager" format:@""];
  return self;
}

-(id) initWithName:(NSString*)appName
            Remote:(NSString*)rPath
             Local:(NSString*)lPath {
  
  return [self initWithName:appName Remote:rPath Local:lPath CommitMessage:@""];
}

-(id) initWithName:(NSString*)appName
            Remote:(NSString*)rPath
             Local:(NSString*)lPath
     CommitMessage:(NSString*)msg {
  
  if ((self = [super init])) {
    
    _appName = appName;
    _remotePath = rPath;
    _localPath = lPath;
    _commitMessage = msg;
  }
  
  return self;
}

-(void) deviceConnected:(AMDevice *)device {
  
  // Attempt to determine if the bundle identifier / app name exists
  AFCApplicationDirectory *appDir = [device newAFCApplicationDirectory:_appName];
  
  // Check to see if we have an app name instead
  if (appDir == nil) {
    
    for (AMApplication *app in [device installedApplications]) {
      
      // Retrieve the application directory if our bundle id has been found
      if ([[app appname] isEqualToString:_appName])
        appDir = [device newAFCApplicationDirectory:[app bundleid]];
    }
    
    if (appDir == nil)
      [NSException raise:@"Invalid Bundle Identifier" format:@"No App found for %@", _appName];
  }
  
  // With a valid app-dir, now try to check if remote path exists
  if (![appDir fileExistsAtPath:_remotePath])
    [NSException raise:@"Invalid Remote Path" format:@"No Remote Path found at %@", _remotePath];
  
  // Use backup manager to transfer contents
  [BackupManager BackupContentsFrom:appDir Path:_remotePath To:_localPath];
  
  [appDir close];
}

-(void) deviceDisconnected:(AMDevice *)device {
  
  [NSException raise:@"Disconnection: " format:@"Device disconnected before finishing."];
}

@end
