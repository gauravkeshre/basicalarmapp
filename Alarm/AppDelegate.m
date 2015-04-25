//
//  AppDelegate.m
//  Alarm
//
//  Created by Gaurav Keshre on 4/14/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "GKAppearanceManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self prepareNotificationForApplication:application];
     [GKAppearanceManager applyAppearance];
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

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{

    if ([identifier isEqualToString:@"stop"]) {
        NSLog(@"%@", @"User tapped on: STOP");
    }else if ([identifier isEqualToString:@"snooze"]) {
        NSLog(@"%@", @"User tapped on: SNOOZE");
    }else if ([identifier isEqualToString:@"openApp"]) {
                NSLog(@"%@", @"User tapped on: OPEN APP");
    }

}
#pragma mark - conv Methods

-(void)prepareNotificationForApplication:(UIApplication *)app{
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIMutableUserNotificationAction *stopAction = [[UIMutableUserNotificationAction alloc] init];
    stopAction.identifier = @"stop";
    stopAction.title = @"Stop";
    stopAction.activationMode = UIUserNotificationActivationModeBackground;
    stopAction.destructive = YES;
    stopAction.authenticationRequired = NO;
    
    UIMutableUserNotificationAction *snoozeAction = [[UIMutableUserNotificationAction alloc] init];
    snoozeAction.identifier = @"snooze";
    snoozeAction.title = @"Snooze";
    snoozeAction.activationMode = UIUserNotificationActivationModeBackground;
    snoozeAction.destructive = NO;
    snoozeAction.authenticationRequired = NO;

    UIMutableUserNotificationAction *openAppAction = [[UIMutableUserNotificationAction alloc] init];
    openAppAction.identifier = @"Open App";
    openAppAction.title = @"openapp";
    openAppAction.activationMode = UIUserNotificationActivationModeForeground;
    openAppAction.destructive = NO;
    openAppAction.authenticationRequired = NO;

    NSArray *actionsArray = @[stopAction, snoozeAction, openAppAction];
    
    
    openAppAction = nil;
    snoozeAction = nil;
    stopAction = nil;
    // Specify the category related to the above actions.
    UIMutableUserNotificationCategory *notificationCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    notificationCategory.identifier = kNOTIF_CAT_ALARM;
    [notificationCategory setActions:actionsArray forContext:UIUserNotificationActionContextDefault];
    
    NSSet *categoriesForSettings = [[NSSet alloc]initWithObjects:notificationCategory, nil];
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categoriesForSettings];
    [app registerUserNotificationSettings:mySettings];
}

@end
