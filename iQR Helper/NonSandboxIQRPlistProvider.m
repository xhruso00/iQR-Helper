#import "NonSandboxIQRPlistProvider.h"

static NSString *const kBundleIdentifier = @"com.hrubasko.iQR";

@interface NonSandboxIQRPlistProvider()
@property NSBundle *bundle;
@end

@implementation NonSandboxIQRPlistProvider

+ (void)initialize
{
    NSAssert([[self class] isRunningInSandbox] == NO, @"We are running in sandbox");
}

+ (BOOL)isRunningInSandbox
{
    NSDictionary *environment = [NSProcessInfo processInfo].environment;
    NSString *sanboxID = environment[@"APP_SANDBOX_CONTAINER_ID"];
    return [sanboxID length] > 0;
}

+ (NSString *)shorteningHistoryPath
{
    NSURL *library = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    return [NSString stringWithFormat:@"%@/Containers/%@/Data/shorteningHistory.dat", [library path], kBundleIdentifier];
}

@end
