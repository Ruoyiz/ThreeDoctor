//
//  YZUserinfoModel.h
//  CommunityDoctory
//
//  Created by 若义张 on 16/2/2.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSInteger, Department) {
//    DepartmentDefault = 200,
//    DepartmentInside,
//    DepartmentOutside
//};


@interface YZUserinfoModel : NSObject

@property (nonatomic, assign) NSDictionary *department;
@property (nonatomic, strong) NSString *mail;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;

+ (YZUserinfoModel *)getUserInfoModelWithDict:(NSDictionary *)userinfoDict;

@end
