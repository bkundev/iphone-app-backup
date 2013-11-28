
#import <Foundation/Foundation.h>

#import "MobileDeviceAccess.h"

@interface DeviceManager : NSObject<MobileDeviceAccessListener> {
  
  NSString *_appName;

  NSString *_remotePath;
  NSString *_localPath;

  NSString *_commitMessage;
}

-(id) initWithName:(NSString*)appName
            Remote:(NSString*)rPath
             Local:(NSString*)lPath;

-(id) initWithName:(NSString*)appName
            Remote:(NSString*)rPath
             Local:(NSString*)lPath
     CommitMessage:(NSString*)msg;

-(void) deviceConnected:(AMDevice *)device;

-(void) deviceDisconnected:(AMDevice *)device;

@end
