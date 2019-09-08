//
//  AppDelegate.m
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    HomeViewController *homeVC = [HomeViewController new];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = navC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
