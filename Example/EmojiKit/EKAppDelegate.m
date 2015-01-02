//
//  EKAppDelegate.m
//  EmojiKit
//
//  Created by CocoaPods on 01/01/2015.
//  Copyright (c) 2014 Rudd Fawcett. All rights reserved.
//

#import "EKAppDelegate.h"

#import "EKViewController.h"

@interface EKAppDelegate ()

@end

@implementation EKAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[EKViewController new]];
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
