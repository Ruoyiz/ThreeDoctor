//
//  RYToastHelp.m
//  CommunityDoctory
//
//  Created by 若义张 on 16/1/29.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "RYToastHelp.h"
#import "SVProgressHUD.h"

@implementation RYToastHelp
+ (void)showSVProgressToastWithTitle:(NSString *)title
{
    [SVProgressHUD setBackgroundColor:[UIColor darkGrayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //[SVProgressHUD setOffsetFromCenter:UIOffsetMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0)];
    [SVProgressHUD showWithStatus:title];
}

+ (void)showSVProgressToastWithTitle:(NSString *)title Info:(NSString *)info {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


+ (void)dismissSVProgress
{
    [SVProgressHUD dismiss];
}

+ (void)showSVProgressWithSuccess:(NSString *)str
{
    
//    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:"
//                                                          message:str delegate:nil
//                                                cancelButtonTitle:nil
//                                                otherButtonTitles:nil];
//    
//    [NSTimer scheduledTimerWithTimeInterval:1.5
//                                     target:self
//                                   selector:@selector(timerFireMethod:)
//                                   userInfo:promptAlert
//                                    repeats:NO];
//    [promptAlert show];
    
    [SVProgressHUD setBackgroundColor:[UIColor darkGrayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showSuccessWithStatus:str];
}

//+(void)timerFireMethod:(NSTimer*)theTimer//弹出框
//{
//    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
//    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
//    promptAlert = NULL;
//}

//+ (void)showSVProgressToastWithError:(NSString *)str{
//    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [SVProgressHUD showErrorWithStatus:str];
//}

@end
