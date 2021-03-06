//
//  AppDelegate.m
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "AboutNavController.h"

#import "NavigationViewController.h"

#import "SecondNavigationViewController.h"

#import "articleParser.h"

#import "headlineParser.h"

@implementation AppDelegate
@synthesize articlelistArray;
@synthesize headlineslistArray;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    articleParser *thearticleparser = [[articleParser alloc] initarticleParser];
    
    
    headlineParser *theheadlineparser = [[headlineParser alloc] initheadlineParser];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIImage *navBarImage = [UIImage imageNamed:@"nav-bar.png"];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage
                                       forBarMetrics:UIBarMetricsDefault];
    
    // Override point for customization after application launch
    
    //UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];

    UIViewController *viewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    //UIViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    
    //Create NavigationViewController object
    NavigationViewController *navController = [[NavigationViewController alloc] initWithNibName:@"NavigationViewController" bundle:nil];
    SecondNavigationViewController *secondnavController = [[SecondNavigationViewController alloc] initWithNibName:@"SecondNavigationViewController" bundle:nil];
    AboutNavController *aboutnavController = [[AboutNavController alloc] initWithNibName:@"AboutNavController" bundle:nil];
    
    
    //Create UINavigation Controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:navController];
    UINavigationController *secondnav = [[UINavigationController alloc] initWithRootViewController:secondnavController];
    UINavigationController *aboutnav = [[UINavigationController alloc] initWithRootViewController:aboutnavController];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav, secondnav, viewController, aboutnav];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
