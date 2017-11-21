//
//  NSUserDefaults+SaveSettings.m
//  CommunityDoctory
//
//  Created by 若义张 on 16/1/28.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "NSUserDefaults+SaveSettings.h"

@implementation NSUserDefaults (SaveSettings)

- (void)setDeviceToken:(NSString *)deviceToken {
    [self setObject:deviceToken forKey:deviceTokenKey];
    [self synchronize];
}
- (NSString *)deviceToken {
    if (![self objectForKey:deviceTokenKey]) {
        return @"";
    }
    return  [self objectForKey:deviceTokenKey];
}

- (void)setFirstLaunch:(BOOL)firstLaunch {
    [self setBool:firstLaunch forKey:firstLaunchKey];
    [self synchronize];
}
- (BOOL)firstLaunch {
    return [self objectForKey:firstLaunchKey];
}

- (void)setUserName:(NSString *)userName {
    [self setObject:userName forKey:userNameKey];
    [self synchronize];
 }
- (NSString *)userName {
    return [self objectForKey:userNameKey];
}

- (void)setPassWord:(NSString *)passWord {
    [self setObject:passWord forKey:passWordKey];
    [self synchronize];
}
- (NSString *)passWord {
    return [self objectForKey:passWordKey];
}

- (void)setUserinfoData:(YZUserinfoModel *)userinfoData {
    [self setObject:userinfoData forKey:userinfoKey];
    [self synchronize];
}
- (YZUserinfoModel *)userinfoData {
    return [self objectForKey:userinfoKey];
}


@end
