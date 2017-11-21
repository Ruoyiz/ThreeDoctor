//
//  YZResetViewController.m
//  CommunityDoctory
//
//  Created by 若义张 on 16/2/1.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "YZResetViewController.h"
#import "YZLoginModel.h"

@interface YZResetViewController () {

    UITextField *captchaTextFiele;
}

@end

@implementation YZResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
    [self loadUI];
}

- (void)config {
    [self.view setBackgroundColor:[UIColor redColor]];
    self.myTitle = @"重置密码";
    [self setLeftItemWithImage:nil andSelectImage:nil];
}

- (void)loadUI{
    CGFloat textHeight = 50;
    CGFloat textFieldFont = 13;
    
    if (SCREEN_HEIGHT >= 667) {
        textHeight = 55;
        textFieldFont = 14;
    }
    
    captchaTextFiele = [[UITextField alloc] initWithFrame:CGRectMake(22, 0, SCREEN_WIDTH - 44, textHeight)];
    captchaTextFiele.placeholder = @"请输入新密码";
    captchaTextFiele.font = [UIFont systemFontOfSize:textFieldFont];
    captchaTextFiele.clearButtonMode = UITextFieldViewModeWhileEditing;
    [captchaTextFiele becomeFirstResponder];
    captchaTextFiele.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:captchaTextFiele];
    
    UIView *sharpView = [[UIView alloc] initWithFrame:CGRectMake(0, textHeight - 0.6 + 0, SCREEN_WIDTH, 0.6)];
    sharpView.backgroundColor = [UIColor separator_gray_line_color];
    [self.view addSubview:sharpView];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(70, 30 + textHeight + 0, SCREEN_WIDTH - 140 , textHeight - 10)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor btn_green_bgColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(verifyDone:) forControlEvents:UIControlEventTouchUpInside];
    
    button.layer.cornerRadius = button.frame.size.height / 2.0;
    button.layer.masksToBounds = YES;
    
    button.layer.borderColor = [[UIColor btn_green_bgColor] CGColor];
    button.layer.borderWidth = 1;
    [self.view addSubview:button];
}

- (void)verifyDone:(UIButton *)button{
    
    NSLog(@"%lu",captchaTextFiele.text.length);
    if (captchaTextFiele.text.length != 6) {
//        [RYToastHelp showSVProgressToastWithError:@"请输入正确的验证码"];
        [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"请输入正确的验证码"];
    }else {
        [YZLoginModel changeDeviceOrForgetPassWordWithPhoneNumber:self.phoneNumber smsType:smsTypeChangePassWord captchaNumber:captchaTextFiele.text success:^(BOOL isSuceess, NSString *message) {
            if (isSuceess == YES) {
                [RYToastHelp showSVProgressWithSuccess:message];
            }else {
                if (message.length != 0) {
//                    [RYToastHelp showSVProgressToastWithError:message];
                    [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:message];

                }else {
//                    [RYToastHelp showSVProgressToastWithError:@"验证失败"];
                    [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"网络请求错误"];

                }
            }
        } failure:^{
            [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"网络请求错误"];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
