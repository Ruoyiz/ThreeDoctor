//
//  YZForgetPasswordViewController.m
//  CommunityDoctory
//
//  Created by 若义张 on 16/1/29.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "YZForgetPasswordViewController.h"
#import "YZLoginModel.h"
#import "YZResetViewController.h"

@interface YZForgetPasswordViewController (){

    NSTimer *_timer;
    
    CGFloat _totolCount;
    
    UIButton *_resendButton;
    SendStatus _sendStatus;
    NSString *_sendMessage;
    NSString *_codeId;
    BOOL _OverFiveMin;

}

@end

@implementation YZForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSelf];
    [self loadUI];
}

- (void)configSelf {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setLeftItemWithImage:nil andSelectImage:nil];
    self.myTitle = @"忘记密码";
    
    _totolCount = 60;
    
}

- (void)sendRequest
{
    [RYToastHelp showSVProgressToastWithTitle:@"正在发送"];
    _OverFiveMin = NO;
    [YZLoginModel getSMSVerifyWithPhoneNumber:self.phone smsType:smsTypeChangePassWord success:^(SendStatus status, NSString *message) {
        [RYToastHelp dismissSVProgress];
        _sendStatus = status;
        _sendMessage = message;
        
        UITextField *codeTextField = (UITextField *)[self.view viewWithTag:200];
        if (!codeTextField) {
            [self loadVerifyView];
        }
        if (status != SendStatusSuccess) {
            [self performSelector:@selector(showMessage) withObject:message afterDelay:0.5];
        }
        
        if (status == SendStatusSuccess) {
            [RYToastHelp showSVProgressWithSuccess:message];
            double delayInSeconds = 60.0*5;//五分钟
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                NSLog(@"slfjklsjflksjflksjfklsjfksdlfkslfkdslk");
                _OverFiveMin = YES;
            });
        }
        
    } failure:^{
        [RYToastHelp dismissSVProgress];
        [RYToastHelp showSVProgressToastWithTitle:@"发送失败" Info:@"网络请求错误"];
//        [RYToastHelp showSVProgressToastWithError:@"发送失败"];
        [self resetResendButton];
//        [_timer setFireDate:[NSDate distantFuture]];
//        [_resendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [_resendButton setTitleColor:[UIColor btn_green_bgColor] forState:UIControlStateNormal];
//        _resendButton.layer.borderColor = [[UIColor btn_green_bgColor] CGColor];
//        
//        _totolCount = 60;
//        _resendButton.enabled = YES;

    }];
}

- (void)showMessage {
//    [RYToastHelp showSVProgressToastWithError:_sendMessage];
    [RYToastHelp showSVProgressToastWithTitle:@"发送失败" Info:_sendMessage];
    [self resetResendButton];
}

- (void)loadUI
{
    CGFloat textHeight = 50;
    CGFloat textFieldFont = 13;
    CGFloat resendHeight = 30;
    CGFloat resendWdth = 105;
    
    if (SCREEN_HEIGHT >= 667) {
        textHeight = 55;
        textFieldFont = 13;
        resendHeight = 34;
        resendWdth = 115;
    }
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(22, 0, SCREEN_WIDTH - 44 - resendWdth - 15, textHeight)];
    textField.placeholder = @"请输入手机号";
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.font = [UIFont systemFontOfSize:textFieldFont];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.tag = 100;
    [textField becomeFirstResponder];
    [self.view addSubview:textField];
    
    
    UIView *sharpView = [[UIView alloc] initWithFrame:CGRectMake(0, textHeight - 0.6, SCREEN_WIDTH, 0.6)];
    sharpView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sharpView];
    
    _resendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, resendWdth, resendHeight)];
    _resendButton.center = CGPointMake(SCREEN_WIDTH - 22 - _resendButton.frame.size.width / 2.0, textHeight / 2.0);
    _resendButton.backgroundColor = [UIColor whiteColor];
    [_resendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_resendButton setTitleColor:[UIColor btn_green_bgColor] forState:UIControlStateNormal];
    _resendButton.titleLabel.font = [UIFont systemFontOfSize:textFieldFont + 1];
    [_resendButton addTarget:self action:@selector(resendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    _resendButton.layer.cornerRadius = _resendButton.frame.size.height / 2.0;
    _resendButton.layer.masksToBounds = YES;
    _resendButton.layer.borderColor = [[UIColor btn_green_bgColor] CGColor];
    _resendButton.layer.borderWidth = 1;
    
    _resendButton.enabled = YES;
    
    [self.view addSubview:_resendButton];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCount:) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)loadVerifyView
{
    CGFloat textHeight = 50;
    CGFloat textFieldFont = 13;
    
    if (SCREEN_HEIGHT >= 667) {
        textHeight = 55;
        textFieldFont = 14;
    }
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(22, textHeight, SCREEN_WIDTH - 44, textHeight)];
    textField.placeholder = @"请输入验证码";
    textField.tag = 200;
    textField.font = [UIFont systemFontOfSize:textFieldFont];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textField becomeFirstResponder];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:textField];
    
    UIView *sharpView = [[UIView alloc] initWithFrame:CGRectMake(0, textHeight * 2 - 0.6, SCREEN_WIDTH, 0.6)];
    sharpView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sharpView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(70, 30 + 2 * textHeight, SCREEN_WIDTH - 140, textHeight - 10)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor btn_green_bgColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(verifyDone:) forControlEvents:UIControlEventTouchUpInside];
    
    button.layer.cornerRadius = button.frame.size.height / 2.0;
    button.layer.masksToBounds = YES;
    
    button.layer.borderColor = [[UIColor btn_green_bgColor] CGColor];
    button.layer.borderWidth = 1;
    [self.view addSubview:button];
}

- (void)timeCount:(NSTimer *)timer
{
    if (_totolCount > 0) {
        _totolCount--;
        [_resendButton setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)_totolCount] forState:UIControlStateNormal];
        _resendButton.enabled = NO;
    }else{
        [self resetResendButton];
    }
}

- (void)resetResendButton {
    [_resendButton setTitle:[NSString stringWithFormat:@"重新发送"] forState:UIControlStateNormal];
    [_resendButton setTitleColor:[UIColor btn_green_bgColor] forState:UIControlStateNormal];
    _resendButton.backgroundColor = [UIColor whiteColor];
    _resendButton.layer.borderColor = [[UIColor btn_green_bgColor] CGColor];
    _resendButton.enabled = YES;
    [_timer setFireDate:[NSDate distantFuture]];
    _totolCount = 60;

}

- (void)verifyDone:(UIButton *)button
{
    UITextField *textField = (UITextField *)[self.view viewWithTag:100];
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:200];
    if (_sendStatus == SendStatusSuccess) {
        if (textField1.text.length == 0) {
            [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"验证码不能为空"];
            return;
        }
        if (textField1.text.length != 6) {
            [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"验证码为6位数"];
            return;
        }
        if (_OverFiveMin == YES) {
            [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"验证码验证失败,请重新获取"];
            return;
        }

        [YZLoginModel changeDeviceOrForgetPassWordWithPhoneNumber:textField.text smsType:smsTypeChangePassWord captchaNumber:textField1.text success:^(BOOL isSuceess, NSString *message) {
            if (isSuceess == YES) {
                [RYToastHelp showSVProgressWithSuccess:message];
            }else {
                if (message.length != 0) {
                    //                        [RYToastHelp showSVProgressToastWithError:message];
                    [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:message];
                    
                }else {
                    //                        [RYToastHelp showSVProgressToastWithError:@"验证失败"];
                    [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"网络请求错误"];
                }
            }
        } failure:^{
            [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"网络请求错误"];
        }];

//
//        YZResetViewController *resetVC = [[YZResetViewController alloc] init];
//        resetVC.phoneNumber = textField.text;
//        [self.navigationController pushViewController:resetVC animated:YES];
    }else {
//        [RYToastHelp showSVProgressToastWithError:_sendMessage];
        [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:_sendMessage];
    }
}

-(BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

- (void)resendVerifyCode
{
    UITextField *textField = (UITextField *)[self.view viewWithTag:100];
    
    if (textField.text.length == 0) {
        
//        [RYToastHelp showSVProgressToastWithError:@"请输入手机号"];
        [RYToastHelp showSVProgressToastWithTitle:@"请输入手机号" Info:nil];
        return;
    }
    
    if(![self isValidateMobile:textField.text]){
//        [RYToastHelp showSVProgressToastWithError:@"请输入正确的手机号"];
        [RYToastHelp showSVProgressToastWithTitle:@"请输入正确的手机号" Info:nil];

        return;
    }
    
    self.phone = textField.text;
    [self sendRequest];
    
    _resendButton.enabled = NO;
    _resendButton.backgroundColor = [UIColor whiteColor];
    _resendButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [_resendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_resendButton setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)_totolCount] forState:UIControlStateNormal];
    
    [_timer setFireDate:[NSDate distantPast]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
