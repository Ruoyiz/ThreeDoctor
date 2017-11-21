//
//  RYHelper.h
//  CommunityDoctory
//
//  Created by 若义张 on 16/1/28.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYHelper : NSObject
//获取idfv
+ (NSString *)getIdfv;
//获取appname
+ (NSString *)getAppName;
//获取app version
+ (NSString *)getAppVersion;
//获取app Buide Version
+ (NSString *)getAppBuideVersion;
//push
+ (void)pushViewControllerFromOriginVC:(UIViewController *)originVC destiantionVC:(UIViewController *)destiantionVC;
//json转dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//data转json
+(NSString*)DataTOjsonString:(id)object;
@end
