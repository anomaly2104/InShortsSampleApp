//
//  NSString+UAAdditions.m
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "NSString+UAAdditions.h"
#import <TDTChocolate/TDTFoundationAdditions.h>

@implementation NSString (UAAdditions)

+ (NSString *)ua_JSONStringForBoolValue:(BOOL)boolValue {
  return boolValue ? @"true" : @"false";
}

- (CGSize)ua_sizeConstrainedToSize:(CGSize)maxSize
                               font:(UIFont *)font {
  CGRect rect = [self boundingRectWithSize:maxSize
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{ NSFontAttributeName: font}
                                   context:nil];
  return CGRectIntegral(rect).size;
}

- (BOOL)ua_isStringFittingInOneLineWithMaxSize:(CGSize)maxSize
                                          font:(UIFont *)font {
  CGSize stringSize = [self ua_sizeConstrainedToSize:maxSize font:font];
  return stringSize.height <= ceil(font.lineHeight);
}

- (NSRange)ua_rangeOfLastSpace {
  NSRange rangeToSearch = NSMakeRange(0, self.length - 1); // get a range without the space character
  return [self rangeOfString:@" "
                     options:NSBackwardsSearch
                       range:rangeToSearch];
}

- (NSString *)ua_stringByConvertingSecondLastSpaceToNewLine {
  NSUInteger spacePositionFromLast = 2;
  
  NSRange spaceRange = NSMakeRange(NSNotFound, 0);
  NSString *str = self;
  for (NSUInteger i = 1; i <= spacePositionFromLast; i++) {
    spaceRange = [str ua_rangeOfLastSpace];
    if (spaceRange.location == NSNotFound) {
      return self;
    }
    str = [str substringToIndex:spaceRange.location];
  }
  
  if (spaceRange.location == NSNotFound) {
    return self;
  }
  return [self stringByReplacingCharactersInRange:spaceRange withString:@"\n"];
}

@end
