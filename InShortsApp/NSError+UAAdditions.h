#import <Foundation/Foundation.h>

extern const NSInteger UAErrorCodeGeneric;
extern const NSInteger UAErrorCodeJSONParsing;

@interface NSError (UAAdditions)

+ (NSError *)ua_genericErrorWithMessage:(NSString *)message;
+ (NSError *)ua_fieldErrorForJSONElement:(NSDictionary *)element
                                   field:(NSString *)field;
@end
