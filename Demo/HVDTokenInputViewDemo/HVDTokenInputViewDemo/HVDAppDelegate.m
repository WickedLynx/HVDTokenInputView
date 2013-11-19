//
//  HVDAppDelegate.m
//  HVDTokenInputViewDemo
//
//  Created by Harshad on 19/11/13.
//  Copyright (c) 2013 LBS. All rights reserved.
//

#import "HVDAppDelegate.h"
#import "HVDRootViewController.h"

@implementation HVDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    HVDRootViewController *rootViewController = [[HVDRootViewController alloc] init];
    [self.window setRootViewController:rootViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
