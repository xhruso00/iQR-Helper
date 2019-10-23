#import "AppDelegate.h"
#import "MainWC.h"
#import "NonSandboxIQRPlistProvider.h"

@interface AppDelegate ()

@property (nonatomic) MainWC *mainWC;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[self mainWC] showWindow:self];
    NSString *filePath = [NonSandboxIQRPlistProvider shorteningHistoryPath];
    [self application:[NSApplication sharedApplication] openFile:filePath];
}

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename
{
    [[self mainWC] setWorkingPath:filename];
    return YES;
}

- (MainWC *)mainWC
{
    if (_mainWC == nil) {
        _mainWC = [[MainWC alloc] init];
    }
    return _mainWC;
}

@end
