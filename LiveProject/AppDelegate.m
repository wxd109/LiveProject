//
//  AppDelegate.m
//  LiveProject
//
//  Created by dd on 16/7/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarControllerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[BaseTabBarControllerViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    [self monitorNetworkState];
    //sss
    return YES;
}

- (void)monitorNetworkState
{
    __block NSString *msg;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网):
                msg = @"没有连接到网络,请检查您的网络状态";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                msg = @"当前为手机运营商网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                msg = nil;
                break;
        }
        if (msg.length) {
            UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"播放器" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertControl addAction:action];
            [self.window.rootViewController presentViewController:alertControl animated:true completion:nil];
        }
    }];
    
    [manager startMonitoring];
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
