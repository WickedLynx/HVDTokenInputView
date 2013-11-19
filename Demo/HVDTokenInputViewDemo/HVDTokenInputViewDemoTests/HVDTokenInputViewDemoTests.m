//
//  HVDTokenInputViewDemoTests.m
//  HVDTokenInputViewDemoTests
//
//  Created by Harshad on 19/11/13.
//  Copyright (c) 2013 LBS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HVDTokenInputView.h"

@interface HVDTokenInputViewDemoTests : XCTestCase

@end

@implementation HVDTokenInputViewDemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialisationWithTokens
{
    NSArray *tokens = @[@"Taco", @"cat", @"is", @"a", @"palindrome"];

    HVDTokenInputView *anInputView = [[HVDTokenInputView alloc] initWithFrame:[UIScreen mainScreen].bounds tokens:tokens editable:YES];

    XCTAssertEqual(tokens.count, anInputView.tokens.count, @"Did not add all tokens");

    for (int tokenIndex = 0; tokenIndex != tokens.count; ++tokenIndex) {

        NSString *token = [anInputView.tokens objectAtIndex:tokenIndex];

        XCTAssert([token isEqualToString:tokens[tokenIndex]], @"Did not add token: %@", token);

    }

}

@end
