//
//  NSUserDefaults+SaveSettings.h
//  CommunityDoctory
//
//  Created by 若义张 on 16/1/28.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZUserinfoModel.h"

static NSString *firstLaunchKey = @"firstLaunch";
static NSString *deviceTokenKey = @"deviceToken";
static NSString *userNameKey = @"userName";
static NSString *passWordKey = @"passWord";
static NSString *userinfoKey = @"userInfo";

@interface NSUserDefaults (SaveSettings)

@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, assign) BOOL firstLaunch;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *passWord;
@property (nonatomic, strong) YZUserinfoModel *userinfoData;

@end
