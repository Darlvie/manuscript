//
//  AppDelegate.m
//  稿件审核系统
//
//  Created by zyq on 15/11/2.
//  Copyright (c) 2015年 BGXT. All rights reserved.
//

#import "AppDelegate.h"
#import "LTTabBarController.h"
#import "LTAccount.h"
#import "LTAccountTool.h"
#import "LTLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    NSData *colorData = [USERDEFAULT objectForKey:TINTCOLOR];
    if (colorData) {
        UIColor *myColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        self.tintColor = myColor;
    } else {        
        self.tintColor = RGB(112, 140, 26);
    }
  
    LTAccount *account = [LTAccountTool account];

    if (account.isAutoLogin) {
        self.window.rootViewController = [[LTTabBarController alloc]init];
    } else {
        self.window.rootViewController = [[LTLoginViewController alloc] initWithNibName:@"LTLoginViewController" bundle:nil];
    }
    [self.window makeKeyAndVisible];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(tintColorDidChange:) name:TINTCOLOR_DID_CHANGED object:nil];
    
    return YES;
}

- (void)tintColorDidChange:(NSNotification *)noti {
    UIColor *tintColor = noti.userInfo[@"tintColor"];
   
    self.tintColor = tintColor;
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
