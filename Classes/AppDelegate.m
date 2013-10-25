//
//  AppDelegate.m
//
//  Created by Jean-André Santoni on 17/07/13.
//  Copyright (c) 2013 Jean-André Santoni. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
NSArray* chapters;
NSArray* colors;
int current;

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_rootViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    chapters = [NSArray arrayWithObjects:
                @"Bijoux & accessoires DIY",
                @"Introduction",
                @"Conseils techniques",
                @"Après-midi à la plage",
                @"Un sac de plage",
                @"Un bracelet de strass",
                @"Réunion de travail",
                @"Un col amovible",
                @"Une broche de col",
                @"Soirée paillettes",
                @"Un bibi à voilette",
                @"Un nœud papillon",
                @"Pique-nique",
                @"Un jonc fleuri",
                @"Une visière foulard",
                @"Dîner à deux",
                @"Une pochette chic",
                @"Bijoux de chaussures",
                @"Soirée déguisée",
                @"Un loup",
                @"Une couronne",
                @"Mariage romantique",
                @"Des boucles fleurs",
                @"Un headband",
                @"Balade été indien",
                @"Un collier plastron",
                @"Des boucles plumes",
                @"Soirée concert",
                @"Une manchette",
                @"Lunettes cosmiques",
                @"Week-end gamers",
                @"Une broche pixel",
                @"Un miroir de poche",
                @"Et maintenant?",
                nil];
    
    current = 0;
    
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

@end
