//
//  NSString+UAAdditions.h
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (UAAdditions)

+ (NSString *)ua_JSONStringForBoolValue:(BOOL)boolValue;

- (BOOL)ua_isStringFittingInOneLineWithMaxSize:(CGSize)maxSize
                                          font:(UIFont *)font;

- (NSString *)ua_stringByPuttingNewLineAtIndexOfSpaceFromLastAtPosition:(NSUInteger)spacePositionFromLast;
@end
