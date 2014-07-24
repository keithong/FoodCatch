//
//  AppDelegate.m
//  FoodCatch
//
//  Created by Keith Samson on 7/17/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "AppDelegate.h"
#import "MainMenuViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (!self.window.rootViewController)
    {
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
        
        MainMenuViewController *mainMenuVC = [[[MainMenuViewController alloc]init] autorelease];
        UINavigationController *navController = [[[UINavigationController alloc]initWithRootViewController:mainMenuVC] autorelease];
        [navController setNavigationBarHidden:YES];
        self.window.rootViewController = navController;
        self.window.backgroundColor = [UIColor whiteColor];
        
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
