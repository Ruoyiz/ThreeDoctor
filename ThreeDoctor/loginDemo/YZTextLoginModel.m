//
//  YZTextLoginModel.m
//  ThreeDoctor
//
//  Created by 若义张 on 16/2/23.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "YZTextLoginModel.h"

@implementation YZTextLoginModel


+ (YZTextLoginModel *)testUserinfoModelWithDict:(NSDictionary *)dict {
    YZTextLoginModel *model = [[YZTextLoginModel alloc] init];
    model.userName = dict[@"userName"];
    model.userId = [dict[@"userId"] integerValue];
    model.realName = dict[@"realmName"];
    model.mobile = [dict[@"mobile"] integerValue];
    model.mail = dict[@"mail"];
    return model;
}

+ (NSString *)primaryKey {
    return @"userId";
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"userName":@"",@"userId":@0,@"realName":@"",@"mobile":@0,@"mail":@""};
}

@end
