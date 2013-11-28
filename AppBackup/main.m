
#import <Foundation/Foundation.h>

#import "MobileDeviceAccess.h"
#import "DeviceManager.h"

int main(int argc, const char * argv[])
{

  @autoreleasepool {
    
    // Gain access to our MobileDevice library
    MobileDeviceAccess *access = [MobileDeviceAccess singleton];
    DeviceManager *deviceMan = nil;
    
    // Attempt to gain a connection to device 0, assume this is correct.
    if (argc < 4)
      [NSException raise:@"Invalid argument count" format:@"Not enough arguments"];
    else if (argc == 4) {
      deviceMan = [[DeviceManager alloc] initWithName:[NSString stringWithUTF8String:argv[1]]
                                                            Remote:[NSString stringWithUTF8String:argv[2]]
                                                             Local:[NSString stringWithUTF8String:argv[3]]];
    } else {
      deviceMan = [[DeviceManager alloc] initWithName:[NSString stringWithUTF8String:argv[1]]
                                                              Remote:[NSString stringWithUTF8String:argv[2]]
                                                               Local:[NSString stringWithUTF8String:argv[3]]
                                                       CommitMessage:[NSString stringWithUTF8String:argv[4]]];
    }
    
    [access setListener:deviceMan];
    [access waitForConnection];
    
    // Commit directory if we have a commit message
    if (argc > 4) {
      NSTask *task;
      task = [NSTask new];
      
      // Adding the new files
      [task setLaunchPath:@"/usr/bin/git"];
      [task setCurrentDirectoryPath:[NSString stringWithUTF8String:argv[3]]];
      
      [task setArguments:@[@"add", @"."]];
      [task launch];
      [task waitUntilExit];
      
      // The commit task
      task = [NSTask new];
      [task setLaunchPath:@"/usr/bin/git"];
      [task setCurrentDirectoryPath:[NSString stringWithUTF8String:argv[3]]];
      
      NSString *message = [NSString stringWithFormat:@"-m \"%@\"", [NSString stringWithUTF8String:argv[4]]];
      [task setArguments:@[@"commit", @"-a", message]];
      
      [task launch];
    }
    
    NSLog(@"Closing down.");
  }
    return 0;
}

