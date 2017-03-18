//
//  NSNumber+UADateAdditions.m
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "NSNumber+UADateAdditions.h"

@implementation NSNumber (UADateAdditions)

- (NSDate *)ua_dateFromMillisecondsSinceUnixEpoch {
  NSTimeInterval secondsSinceEpoch = self.doubleValue * 1e-3;
  return [NSDate dateWithTimeIntervalSince1970:secondsSinceEpoch];
}

@end
