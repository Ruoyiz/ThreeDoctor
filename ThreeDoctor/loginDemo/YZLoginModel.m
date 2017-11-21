//
//  YZLoginModel.m
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "YZLoginModel.h"
#import "YZTestModelManger.h"

@implementation YZLoginModel

+ (void)getModelWithUsername:(NSString *)username password:(NSString *)password sucessse:(void (^)(YZLoginModel *))success failure:(void (^)(NSError *))failure {
    
    NSString *bodyString = [[NSString stringWithFormat:@"{\"pwd\":\"%@\",\"userName\":\"%@\"}",password,username] doEncryptStr];
    [[RYHttpRequestManger shareInstance] Post:Http_Login parameters:bodyString downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response == %@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            YZLoginModel *model = [[YZLoginModel alloc] init];
            [self setModelWithDict:responseObject model:model];
            if (success) {
                success(model);
            }
        }else {
            failure(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"errer == %@",error);
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)getSMSVerifyWithPhoneNumber:(NSString *)phonenumber smsType:(smsType)smsType success:(void (^)(SendStatus, NSString *))success failure:(void (^)())failure {
    NSString *bodyString = [[NSString stringWithFormat:@"{\"phone\":\"%@\",\"smsType\":\"%ld\"}",phonenumber,(long)smsType] doEncryptStr];
//    NSLog(@"bodyString == %@",bodyString);
    [[RYHttpRequestManger shareInstance] Post:Http_SendSMS parameters:bodyString downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *data = [responseObject objectForKey:@"data"];
            NSDictionary *responseDict = [RYHelper dictionaryWithJsonString:data.doDecEncryptStr];
            if (success) {
                success([responseDict[@"status"] integerValue],responseDict[@"message"]);
            }
        }else {
            if (failure) {
                failure();
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure();
        }
    }];

}

+ (void)logoutSuccess:(void (^)(BOOL))success failure:(void (^)(void))failure {
    [[RYHttpRequestManger shareInstance]Post:Http_Logout parameters:[@"" doEncryptStr] downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *data = [responseObject objectForKey:@"data"];
            NSDictionary *responseDict = [RYHelper dictionaryWithJsonString:data.doDecEncryptStr];
            if ([[responseDict objectForKey:@"status"] integerValue] == 200) {
                if (success) {
                    success(YES);
                }
            }else {
                if (failure) {
                    failure();
                }
            }
        }else {
            if (failure) {
                failure();
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure();
        }
    }];
}

+ (void)changeDeviceOrForgetPassWordWithPhoneNumber:(NSString *)phoneNumber smsType:(smsType)smsType captchaNumber:(NSString *)captchaNumber success:(void (^)(BOOL, NSString *))success failure:(void (^)(void))failure {
    NSString *bodyString = [[NSString stringWithFormat:@"{\"phone\":\"%@\",\"smsType\":\"%ld\",\"captcha\":\"%@\"}",phoneNumber,(long)smsType,captchaNumber] doEncryptStr];
    NSLog(@"bodyString == %@",[bodyString doDecEncryptStr]);
    [[RYHttpRequestManger shareInstance] Post:Http_ChangeDevice parameters:bodyString downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject == %@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *data = [responseObject objectForKey:@"data"];
            NSDictionary *responseDict = [RYHelper dictionaryWithJsonString:data.doDecEncryptStr];
            NSLog(@"responseDict == %@",responseDict);
            if (success) {
                BOOL issucess ;
                if ([responseDict[@"status"] integerValue] == 200) {
                    issucess = YES;
                }else {
                    issucess = NO;
                }
                success(issucess ,responseDict[@"message"]);
            }
        }else {
            if (failure) {
                failure();
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure();
        }
    }];
    

}

+ (void)changePassword:(NSString *)oldPassword newPassword:(NSString *)newPassword confirmPassword:(NSString *)confirmPassword success:(void (^)(BOOL, NSString *))success failure:(void (^)(void))failure{
    NSString *bodyString = [[NSString stringWithFormat:@"{\"oldPassword\":\"%@\",\"newPassword\":\"%@\",\"confirmPassword\":\"%@\"}",oldPassword,newPassword,confirmPassword] doEncryptStr];
    [[RYHttpRequestManger shareInstance] Post:Http_ChangePassWord parameters:bodyString downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *data = [responseObject objectForKey:@"data"];
            NSDictionary *responseDict = [RYHelper dictionaryWithJsonString:data.doDecEncryptStr];
            if ([[responseDict objectForKey:@"status"] integerValue] == 200) {
                if (success) {
                    success(YES ,[responseDict objectForKey:@"message"]);
                }
            }else {
                if (success) {
                    success(NO ,[responseDict objectForKey:@"message"]);
                }
            }

        }else {
            if (failure) {
                failure();
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure();
        }
    }];
                        
}

+ (void)updateUserInformation:(YZUserinfoModel *)userinfoModel Success:(void (^)(NSString *))success failure:(void (^)(NSString *))failure {
    NSString *bodyString = [[NSString stringWithFormat:@"{\"userName\":\"%@\",\"realName\":\"%@\",\"mail\":\"%@\",\"mobile\":\"%@\",\"department\":\"%ld\"}",userinfoModel.userName,userinfoModel.realName,userinfoModel.mail,userinfoModel.mobile,(long)userinfoModel.department] doEncryptStr];
    [[RYHttpRequestManger shareInstance] Post:Http_UserUpdate parameters:bodyString downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *data = [responseObject objectForKey:@"data"];
            NSDictionary *responseDict = [RYHelper dictionaryWithJsonString:data.doDecEncryptStr];
            if ([[responseDict objectForKey:@"status"] integerValue] == 200) {
                if (success) {
                    success([responseDict objectForKey:@"message"]);
                }
            }else {
                if (failure) {
                    failure([responseDict objectForKey:@"message"]);
                }
            }

         }else {
            if (failure) {
                failure(@"更新失败");
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(@"更新失败，请检查网络");
        }
    }];

}

+ (void)setModelWithDict:(NSDictionary *)responseDict model:(YZLoginModel *)model{
    model.code = [NSString stringWithFormat:@"%@",responseDict[@"code"]];
    NSString *dataString = responseDict[@"data"];
    NSDictionary *dataDict = [RYHelper dictionaryWithJsonString:dataString.doDecEncryptStr];
    NSLog(@"dataDict == %@",dataDict);
    model.status = [dataDict[@"status"] integerValue];
    model.message = dataDict[@"message"];
    model.token = dataDict[@"token"];
    [[NSUserDefaults standardUserDefaults]setDeviceToken:model.token];
    [YZTestModelManger saveTestModel:[YZTextLoginModel testUserinfoModelWithDict:dataDict[@"userInfo"]]];
    
    model.userInfoModel = [YZUserinfoModel getUserInfoModelWithDict:dataDict[@"userInfo"]];
}

@end
