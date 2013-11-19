//
//  HVDRootViewController.m
//  HVDTokenInputViewDemo
//
//  Created by Harshad on 19/11/13.
//  Copyright (c) 2013 LBS. All rights reserved.
//

#import "HVDRootViewController.h"
#import "HVDTokenInputView.h"

@interface HVDRootViewController ()

@end

@implementation HVDRootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self.view setBackgroundColor:[UIColor lightGrayColor]];

    HVDTokenInputView *tokenInputView = [[HVDTokenInputView alloc] initWithFrame:CGRectMake(10, 40, self.view.bounds.size.width - 20, 200) tokens:@[@"Soo", @"many", @"tokens"] editable:YES];
    [tokenInputView setMaximumTokens:10];
    [tokenInputView setAccessibilityLabel:@"Token Input View"];

    [self.view addSubview:tokenInputView];
}


@end
