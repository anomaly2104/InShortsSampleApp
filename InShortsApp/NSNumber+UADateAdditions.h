//
//  NSNumber+UADateAdditions.h
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (UADateAdditions)

- (NSDate *)ua_dateFromMillisecondsSinceUnixEpoch;

@end
