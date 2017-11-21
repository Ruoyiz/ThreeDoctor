//
//  YZRootVCManager.m
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "YZRootVCManager.h"
#import "YZNavigationViewController.h"
#import "YZHLLoginViewController.h"
#import "FirstPageViewController.h"
#import "LeftSortsViewController.h"

@implementation YZRootVCManager

static YZRootVCManager *rootVCManager = nil;
+ (YZRootVCManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootVCManager = [[YZRootVCManager alloc] init];
        rootVCManager.myAppDelegate = APP_DELEGATE;
    });
    return rootVCManager;
}

- (void)setRootVC {
    if ([[[NSUserDefaults standardUserDefaults] deviceToken] isEqualToString:@""]) {
        [self setLoginVC];
    }else {
        [self setFitstPageVC];
    }
//    [self setCustomBar];
//    [self performSelector:@selector(setRoot) withObject:nil afterDelay:0.0];
}
- (void)setFitstPageVC {
    
    FirstPageViewController *firstVC = [[FirstPageViewController alloc] init];
    self.myAppDelegate.mainNavigationController = [[YZNavigationViewController alloc] initWithRootViewController:firstVC];
    LeftSortsViewController *leftSortVC = [[LeftSortsViewController alloc] init];
    self.myAppDelegate.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftSortVC andMainView:self.myAppDelegate.mainNavigationController];
    [self.myAppDelegate.window setRootViewController:self.myAppDelegate.LeftSlideVC];
}

- (void)setLoginVC {
    YZNavigationViewController *nav = [[YZNavigationViewController alloc] initWithRootViewController:[[YZHLLoginViewController alloc] init]];
//    self.myAppDelegate.mainNavigationController = [[YZNavigationViewController alloc] initWithRootViewController:[[YZHLLoginViewController alloc] init]];
    [self.myAppDelegate.window setRootViewController:nav];
}

//- (void)setCustomBar
//{
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     @{NSFontAttributeName: [UIFont systemFontOfSize:9.0],
//       NSForegroundColorAttributeName: [UIColor darkGrayColor]}
//                                             forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x27c3b0)}
//                                             forState:UIControlStateSelected];
//    
//    YZNavigationViewController *c1 = [[YZNavigationViewController alloc] initWithRootViewController:
//                                  [[YZHLLoginViewController alloc] init]];
//    
//    
//    c1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"看看"
//                                                  image:[[UIImage imageNamed:@"first_normal"]
//                                                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                          selectedImage:[[UIImage imageNamed:@"first_selected"]
//                                                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    c1.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -4.0);
//    
//    NSMutableArray *VCArray = [NSMutableArray array];
//    [VCArray addObject:c1];
//    
//    YZNavigationViewController *c2 =
//    [[YZNavigationViewController alloc] initWithRootViewController:[[YZHLLoginViewController alloc]init]];
//    c2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"工具"
//                                                  image:[[UIImage imageNamed:@"second_normal"]
//                                                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                          selectedImage:[[UIImage imageNamed:@"second_selected"]
//                                                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    c2.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -4.0);
//    
//    [VCArray addObject:c2];
//    
//     AppDelegate *myApp = APP_DELEGATE;
//    myApp.customTabBar = [[UITabBarController alloc]init];
//    myApp.customTabBar.viewControllers = VCArray;
//    
////    [self setCustomTabBarGestureRecognizer];//添加点击手势，待开发
//}


@end

