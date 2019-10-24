#import <Cocoa/Cocoa.h>

@interface DynamicCode : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@property (readonly, copy) NSString *date;
@property (readonly, copy) NSString *originalURL;
@property (readonly, copy) NSString *manageURL;
@property (readonly, copy) NSString *shortenedURL;

- (NSDictionary *)dictionaryRepresentation;

@end


