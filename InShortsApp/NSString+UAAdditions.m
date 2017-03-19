//
//  NSString+UAAdditions.m
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "NSString+UAAdditions.h"

@implementation NSString (UAAdditions)

+ (NSString *)ua_JSONStringForBoolValue:(BOOL)boolValue {
  return boolValue ? @"true" : @"false";
}

@end
