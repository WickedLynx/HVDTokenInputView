//
//  HVDTokenInputViewAcceptanceTests.m
//  HVDTokenInputViewAcceptanceTests
//
//  Created by Harshad on 19/11/13.
//  Copyright (c) 2013 LBS. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <KIF/KIF.h>

@interface HVDTokenInputViewAcceptanceTests : KIFTestCase

@end

@implementation HVDTokenInputViewAcceptanceTests

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

- (void)testAddToken
{

    [tester waitForViewWithAccessibilityLabel:@"Token Input View"];

    [tester waitForViewWithAccessibilityLabel:@"Token Input View Text Field"];

    NSString *token = @"Testing";

    [tester enterText:[NSString stringWithFormat:@" %@", token] intoViewWithAccessibilityLabel:@"Token Input View Text Field"];

    [tester enterText:@" " intoViewWithAccessibilityLabel:@"Token Input View Text Field"];

    [tester waitForTimeInterval:0.1];

    [tester waitForViewWithAccessibilityLabel:[NSString stringWithFormat:@"Token Input View Label %@", token]];

}

@end
