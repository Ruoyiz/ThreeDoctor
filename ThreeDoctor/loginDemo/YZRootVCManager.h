//
//  YZRootVCManager.h
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZRootVCManager : NSObject

@property (nonatomic, strong) AppDelegate *myAppDelegate;
+ (YZRootVCManager *)sharedManager;
- (void)setRootVC;

@end
