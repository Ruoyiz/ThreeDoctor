//
//  AppDelegate.m
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "AppDelegate.h"
#import "YZRootVCManager.h"
#import "LXMThirdLoginManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[YZRootVCManager sharedManager] setRootVC];//设置跟视图
//    [[LXMThirdLoginManager sharedManager]setupWithSinaWeiboAppKey:FSinaWeiboAppKey SinaWeiboRedirectURI:FSinaWeiboRedirectURI WeChatAppKey:FWeChatAppKey WeChatAppSecret:FWeChatAppSecret QQAppKey:@""];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
