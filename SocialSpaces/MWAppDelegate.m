//
//  MWAppDelegate.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/20/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWAppDelegate.h"
#import "MWMainViewController.h"

@implementation MWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  MWMainViewController *mainViewController = [[MWMainViewController alloc] init];
  mainViewController.title = @"Trending Topics";

  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
  self.window.rootViewController = navigationController;
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

@end
