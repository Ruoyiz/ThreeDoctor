//
//  YZLoginModel.h
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZUserinfoModel.h"

typedef NS_ENUM(NSInteger, smsType){
    smsTypeDefault = 0,
    smsTypeVerifyPhono,
    smsTypeChangeDevice,
    smsTypeChangePassWord
};

typedef NS_ENUM(NSInteger, LoginStaus){
    LoginStausSuccess = 200,
    LoginStausFailure,
    LoginStausChangeDevice,
    LoginStausCompleteMessage
};

typedef NS_ENUM(NSInteger, SendStatus) {
    SendStatusSuccess = 200,
    SendStatusVerifyFailure,
    SendStatusSendFailure
};

@interface YZLoginModel : NSObject
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) LoginStaus status;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) YZUserinfoModel *userInfoModel;

//登录获取用户信息
+ (void)getModelWithUsername:(NSString *)username password:(NSString *)password sucessse:(void (^)(YZLoginModel *loginModel))success failure:(void(^)(NSError *errer))failure;
//发送短信验证码
+ (void)getSMSVerifyWithPhoneNumber:(NSString *)phonenumber smsType:(smsType)smsType success:(void(^)(SendStatus status, NSString *message))success failure:(void(^)())failure;
//退出登录
+ (void)logoutSuccess:(void(^)(BOOL success))success failure:(void(^)(void))failure;
//更换设备，忘记密码等
+ (void)changeDeviceOrForgetPassWordWithPhoneNumber:(NSString *)phoneNumber smsType:(smsType)smsType captchaNumber:(NSString *)captchaNumber success:(void(^)(BOOL isSuceess, NSString *message))success failure:(void(^)(void))failure;
//修改密码
+ (void)changePassword:(NSString *)oldPassword newPassword:(NSString *)newPassword confirmPassword:(NSString *)confirmPassword success:(void(^)(BOOL isSuceess, NSString *message))success failure:(void(^)(void))failure;
//修改用户信息
+ (void)updateUserInformation:(YZUserinfoModel *)userinfoModel Success:(void(^)(NSString * message))success failure:(void(^)(NSString *message))failure;

@end
