//
//  NSString_UAAdditions_Tests.m
//  InShortsApp
//
//  Created by Udit Agarwal on 19/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+UAAdditions.h"

@interface NSString_UAAdditions_Tests : XCTestCase

@end

@implementation NSString_UAAdditions_Tests

- (void)testItCorrectlyReplacesLastSpaceWithNewLine {
  NSString *text = @"first second third fourth";
  
  XCTAssertEqualObjects(@"first second third\nfourth",
                        [text ua_stringByPuttingNewLineAtIndexOfSpaceFromLastAtPosition:1]);
}

- (void)testItCorrectlyReplacesFirstSpaceWithNewLine {
  NSString *text = @"first second third fourth";
  
  XCTAssertEqualObjects(@"first\nsecond third fourth",
                        [text ua_stringByPuttingNewLineAtIndexOfSpaceFromLastAtPosition:3]);
}

- (void)testItCorrectlyReplacesSecondLastSpaceWithNewLine {
  NSString *text = @"first second third fourth";
  
  XCTAssertEqualObjects(@"first second\nthird fourth",
                        [text ua_stringByPuttingNewLineAtIndexOfSpaceFromLastAtPosition:2]);
}

- (void)testItDoesNotChangeStringIfTheSpaceToReplaceIsNoFound {
  NSString *text = @"first second third fourth";
  
  XCTAssertEqualObjects(@"first second third fourth",
                        [text ua_stringByPuttingNewLineAtIndexOfSpaceFromLastAtPosition:4]);
}

@end
