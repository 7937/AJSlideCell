//
//  AppDelegate.m
//  testCell
//
//  Created by 7937 on 2017/3/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[TableViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
