#import <Foundation/Foundation.h>

@interface NonSandboxIQRPlistProvider : NSObject

+ (BOOL)isRunningInSandbox;
+ (NSString *)shorteningHistoryPath;

@end
