
#import <Foundation/Foundation.h>

#import "MobileDeviceAccess.h"

@interface BackupManager : NSObject

+(void) BackupContentsFrom:(AFCApplicationDirectory*)remoteDir
                      Path:(NSString*)path
                        To:(NSString*)localDir;

@end
