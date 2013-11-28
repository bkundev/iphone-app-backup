
#import "BackupManager.h"

@implementation BackupManager

+(void) BackupContentsFrom:(AFCApplicationDirectory*)remoteDir
                      Path:(NSString*)rPath
                        To:(NSString*)localDir {
  
  NSFileManager *fileMan = [NSFileManager new];
  BOOL isDir;
  
  // Ensure local directory is created and a directory
  if (![fileMan fileExistsAtPath:localDir isDirectory:&isDir]) {
    
    [NSException raise:@"Invalid Local Directory" format:@"No Directory Exists at %@", localDir];
  } else if (!isDir) {
    
    [NSException raise:@"Invalid Local Directory" format:@"Directory specified is a file!"];
  }
  
  // Remove contents from local directory if present
  NSDirectoryEnumerator *dirEnum = [fileMan enumeratorAtPath:localDir];
  
  // Iterate across all files removing any non-hidden files
  for (NSString* file = [dirEnum nextObject]; file != nil; file = [dirEnum nextObject]) {
    
    NSString *localPath = [NSString stringWithFormat:@"%@%@", localDir, file];
    NSLog(@"Checking local file %@ for removal", localPath);
    
    if ([fileMan fileExistsAtPath:localPath]) {
      
      if (!([file hasPrefix:@"."]))
        [fileMan removeItemAtPath:localPath error:nil];
    }
  }
  
  // Recurse remote directory contents
  NSArray *remoteFiles = [remoteDir recursiveDirectoryContents:rPath];
  
  for (NSString *remotePath in remoteFiles) {
    
    NSString *localPath = [NSString stringWithFormat:@"%@%@", localDir, remotePath];
    
    if ([localPath hasSuffix:@"/"]) {
      
      //NSLog(@"Creating directory at %@", localPath);
      [fileMan createDirectoryAtPath:localPath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
      
      //NSLog(@"Copying file from (%@) to (%@)", remotePath, localPath);
      [remoteDir copyRemoteFile:remotePath toLocalFile:localPath];
    }
  }
}

@end
