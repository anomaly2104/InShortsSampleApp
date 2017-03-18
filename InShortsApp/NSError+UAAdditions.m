#import "NSError+UAAdditions.h"

static  NSString *const UAErrorDomainGeneric = @"UAErrorCodeGeneric";
static  NSString *const UAErrorDomainJSONParsing = @"UAErrorDomainJSONParsing";

const NSInteger UAErrorCodeGeneric = 0;
const NSInteger UAErrorCodeJSONParsing = 1;

@implementation NSError (TDTAdditions)

+ (NSError *)ua_errorWithCode:(NSInteger)code
                       domain:(NSString *)domain
                      message:(NSString *)message {
  NSDictionary *userInfo = @{NSLocalizedDescriptionKey: message};
  return [NSError errorWithDomain:domain
                             code:code
                         userInfo:userInfo];
}

+ (NSError *)ua_genericErrorWithMessage:(NSString *)message {
  return [self ua_errorWithCode:UAErrorCodeGeneric
                         domain:UAErrorDomainGeneric
                        message:message];
}

+ (NSError *)ua_JSONParsingErrorWithMessage:(NSString *)message {
  return [self ua_errorWithCode:UAErrorCodeJSONParsing
                         domain:UAErrorDomainJSONParsing
                        message:message];
}

+ (NSError *)ua_fieldErrorForJSONElement:(NSDictionary *)element
                                   field:(NSString *)field {
  NSString *message = [NSString stringWithFormat:@"Error for field '%@' in JSON [%@]",
                       field, element];
  return [self ua_JSONParsingErrorWithMessage:message];
}

@end
