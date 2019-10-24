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
