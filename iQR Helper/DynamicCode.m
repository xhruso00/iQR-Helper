#import "DynamicCode.h"

static NSString *const kDateKey = @"date";
static NSString *const kOriginalURLKey = @"originalURL";
static NSString *const kManageURLKey = @"manageURL";
static NSString *const kShortenedURLKey = @"shortenedURL";

@implementation DynamicCode

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _date = [dict valueForKey:kDateKey];
        _originalURL = [dict valueForKey:kOriginalURLKey];
        _manageURL = [dict valueForKey:kManageURLKey];
        _shortenedURL = [dict valueForKey:kShortenedURLKey];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    return @{
        kDateKey : [self date],
        kOriginalURLKey : [self originalURL],
        kManageURLKey : [self manageURL],
        kShortenedURLKey : [self shortenedURL]
    };
}

@end

@implementation DynamicCode(NSPasteboardWriting)

- (NSString *)textForExport
{
    return [NSString stringWithFormat:@"%@;%@;%@;%@;", self.date, self.originalURL, self.manageURL, self.shortenedURL];
}

#pragma mark NSPasteboardWriting

- (NSPasteboardWritingOptions)writingOptionsForType:(NSPasteboardType)type pasteboard:(NSPasteboard *)pasteboard
{
    NSPasteboardWritingOptions options = 0;
    return options;
}

- (NSArray<NSPasteboardType> *)writableTypesForPasteboard:(NSPasteboard *)pasteboard
{
    return [[self textForExport] writableTypesForPasteboard:pasteboard];
}

- (nullable id)pasteboardPropertyListForType:(NSPasteboardType)type
{
    return [[self textForExport] pasteboardPropertyListForType:type];
}

@end
