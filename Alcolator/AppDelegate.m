//
//  AppDelegate.m
//  Alcolator
//
//  Created by Tim on 2015-03-16.
//  Copyright (c) 2015 Tim Pryor. All rights reserved.
//

#import "AppDelegate.h"
#import "BLCViewController.h"
#import "BLCMainMenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  
  // create the Window
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  // mainMenuViewController is an instance of BLCMainMenuViewController, a subclass of UIViewController
  BLCMainMenuViewController *mainMenuViewController = [[BLCMainMenuViewController alloc] init];
  // initialize a UINavigationController with mainMenuViewController
  // when you initialize an instance of UINavigationController, you give it one UIViewController
  // This is the navigation controller's root view controller-bottom of the stack
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainMenuViewController];
  // set the window's root VC to navigationController
  self.window.rootViewController = navigationController;
  
  
  NSLog(@"%@", navigationController.viewControllers);
  
  
  // assign it to the window's rootViewController
  // self.window.rootViewController = viewController;
  // set the window as the application's key window
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
