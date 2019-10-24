#import "DynamicCode+NSPasteboardWriting.h"

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
