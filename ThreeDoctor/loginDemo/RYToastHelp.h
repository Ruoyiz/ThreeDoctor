//
//  RYToastHelp.h
//  CommunityDoctory
//
//  Created by 若义张 on 16/1/29.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYToastHelp : NSObject
+ (void)showSVProgressToastWithTitle:(NSString *)title;
+ (void)showSVProgressToastWithTitle:(NSString *)title Info:(NSString *)info;
+ (void)dismissSVProgress;
+ (void)showSVProgressWithSuccess:(NSString *)str;

//+ (void)showSVProgressToastWithError:(NSString *)str;
@end
