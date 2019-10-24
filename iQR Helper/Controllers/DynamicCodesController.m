#import "DynamicCodesController.h"
#import "DynamicCode.h"
#import "DynamicCode+NSPasteboardWriting.h"

@implementation DynamicCodesController

- (void)loadCodesWithPath:(NSString *)path
{
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:&error];
    NSArray *array = [NSPropertyListSerialization propertyListWithData:data options:0 format:nil error:&error];
    NSAssert(array != nil, @"array is nil");
    NSMutableArray *mutCodes = [NSMutableArray array];
    for (NSDictionary<NSString*,id>*codeDict in array) {
        DynamicCode *code = [[DynamicCode alloc] initWithDictionary:codeDict];
        if (code) {
            [mutCodes addObject:code];
        }
    }
    [self setContent:mutCodes];
}

- (void)saveCodesToPath:(NSString *)path
{
    NSMutableArray *mutCodes = [NSMutableArray new];
    for (DynamicCode *code in [self content]) {
        [mutCodes addObject:[code dictionaryRepresentation]];
    }
    NSError *error;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:mutCodes
                                                              format:NSPropertyListXMLFormat_v1_0
                                                             options:0
                                                               error:&error];
    [data writeToFile:path atomically:YES];
}

- (NSString *)stringContent
{
    NSMutableArray *mutArray = [NSMutableArray array];
    for (DynamicCode *code in [self arrangedObjects]) {
        [mutArray addObject:[code pasteboardPropertyListForType:NSPasteboardTypeString]];
    }
    NSString *content = [mutArray componentsJoinedByString:@"\r\n"];
    return content;
}

@end
