#import <AppKit/AppKit.h>

@interface DynamicCodesController : NSArrayController

- (void)loadCodesWithPath:(NSString *)path;
- (void)saveCodesToPath:(NSString *)path;
- (NSString *)stringContent;

@end
