//
//  ChangeDeviceView.m
//  CommunityDoctory
//
//  Created by 若义张 on 16/2/1.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "ChangeDeviceView.h"
#import "YZLoginModel.h"

@interface ChangeDeviceView () <UITextFieldDelegate>{

    NSInteger _totolCount;
    NSString *_phoneNumber;
    BOOL _OverFiveMin;
}

@end

@implementation ChangeDeviceView

- (instancetype)initWithFrame:(CGRect)frame phoneNumber:(NSString *)phoneNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        _phoneNumber = phoneNumber;
        NSLog(@"phonetNameber === %@",phoneNumber);
        _totolCount = 60;
        CGFloat width = frame.size.width,height = frame.size.height;
        CGFloat titleLableHeight = 40*SCREEN_WIDTH/414.0;
        RYLable *titleLabel = [[RYLable alloc] initWithFrame:CGRectMake(0, 0, width, titleLableHeight) titleText:@"绑定设备" textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:18] lineSpace:0 autoHeight:NO];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.verticalAlignment = VerticalAlignmentMiddle;
        titleLabel.backgroundColor = [UIColor btn_green_bgColor];
        [self addSubview:titleLabel];
        
        RYButton *changebutton = [[RYButton alloc] initWithFrame:CGRectMake(0, height - titleLableHeight, width, titleLableHeight) titleText:@"确定" textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:18] backGroundColor:[UIColor btn_green_bgColor]];
        [changebutton addTarget:self action:@selector(changeBugonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:changebutton];
        
        
        CGFloat textFieldFont = 16;

        CGFloat textHeight = height/2.0 - titleLableHeight;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, titleLableHeight, width-10, textHeight)];
        textField.placeholder = [NSString stringWithFormat:@"%@",phoneNumber];
        textField.userInteractionEnabled = NO;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.font = [UIFont systemFontOfSize:textFieldFont];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.tag = 100;
        [self addSubview:textField];
        
        UIView *sharpView = [[UIView alloc] initWithFrame:CGRectMake(0, height/2.0 - 0.6, width, 0.6)];
        sharpView.backgroundColor = [UIColor grayColor];
        [self addSubview:sharpView];
        
        UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10, height/2.0 - 0.6, width-10, textHeight)];
        textField1.placeholder = @"请输入验证码";
        textField1.delegate = self;
        textField1.keyboardType = UIKeyboardTypeNumberPad;
        textField1.font = [UIFont systemFontOfSize:textFieldFont];
        textField1.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField1.tag = 101;
        [self addSubview:textField1];
        
        UIView *sharpView1 = [[UIView alloc] initWithFrame:CGRectMake(0, height - 0.6, width, 0.6)];
        sharpView1.backgroundColor = [UIColor grayColor];
        [self addSubview:sharpView1];

        CGFloat resendWidth = textHeight*2/3.0;
        _resendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, resendWidth*2.5, resendWidth)];
        _resendButton.center = CGPointMake(width - 22 - _resendButton.frame.size.width / 2.0, height / 2.0 + textHeight/2.0);
        _resendButton.backgroundColor = [UIColor whiteColor];
        [_resendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_resendButton setTitleColor:[UIColor btn_green_bgColor] forState:UIControlStateNormal];
        _resendButton.titleLabel.font = [UIFont systemFontOfSize:(int)resendWidth*5/12.0];
        [_resendButton addTarget:self action:@selector(resendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
        
        _resendButton.layer.cornerRadius = 6;
        _resendButton.layer.masksToBounds = YES;
        _resendButton.layer.borderColor = [[UIColor btn_green_bgColor] CGColor];
        _resendButton.layer.borderWidth = 1;
        
        _resendButton.enabled = YES;
        [self addSubview:_resendButton];
//        [self sendRequset];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCount:) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
//        [self resendVerifyCode];
    }
    return self;
}

- (void)sendRequset {
    _OverFiveMin = NO;
    [YZLoginModel getSMSVerifyWithPhoneNumber:_phoneNumber smsType:smsTypeChangeDevice success:^(SendStatus status, NSString *message) {
        if (status == SendStatusSuccess) {
            [RYToastHelp showSVProgressWithSuccess:message];
            double delayInSeconds = 60.0*5;//五分钟
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                NSLog(@"slfjklsjflksjflksjfklsjfksdlfkslfkdslk");
                _OverFiveMin = YES;
            });

        }else {
            [RYToastHelp showSVProgressToastWithTitle:@"发送失败" Info:message];
            [self resendButton];
        }
    } failure:^{
        [RYToastHelp showSVProgressToastWithTitle:@"发送失败" Info:@"网络请求失败"];
        [self resendButton];
    }];
}


- (void)timeCount:(NSTimer *)timer {
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

- (void)resendVerifyCode {
    [self sendRequset];
    _resendButton.enabled = NO;
    _resendButton.backgroundColor = [UIColor whiteColor];
    _resendButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [_resendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_resendButton setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)_totolCount] forState:UIControlStateNormal];
    [_timer setFireDate:[NSDate distantPast]];

}

- (void)changeBugonClicked {
    UITextField *textField = (UITextField *)[self viewWithTag:101];
    if (textField.text.length == 0) {
        [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"验证码不能为空"];
        return;
    }
    if (textField.text.length != 6) {
        [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"验证码为6位数"];
        return;
    }
    if (_OverFiveMin == YES) {
        [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"验证码验证失败,请重新获取"];
        return;
    }

    [YZLoginModel changeDeviceOrForgetPassWordWithPhoneNumber:_phoneNumber smsType:smsTypeChangeDevice captchaNumber:textField.text success:^(BOOL isSuceess, NSString *message) {
        if (isSuceess) {
            [RYToastHelp showSVProgressWithSuccess:message];
            [self hide];
            if (self.finshBlock) {
                self.finshBlock();
            }
        }else {
            if (message.length > 0) {
//                [RYToastHelp showSVProgressToastWithError:message];
                [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:message];
            }else {
                [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"网络请求失败"];
            }
            [self hide];
        }
    } failure:^{
        [RYToastHelp showSVProgressToastWithTitle:@"验证失败" Info:@"网络请求失败"];
    }];
}

- (void)show {
    AppDelegate *myApp = APP_DELEGATE;
    UIWindow *myWindow = myApp.window;
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backButton.alpha = 0.3;
    _backButton.backgroundColor = [UIColor blackColor];
    [_backButton addTarget:self action:@selector(backButonClicked) forControlEvents:UIControlEventTouchUpInside];
    [myWindow addSubview:_backButton];
    [myWindow addSubview:self];
}

- (void)hide {
    [_backButton removeFromSuperview];
    [UIView animateWithDuration:0.2 delay:0.05 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _backButton.userInteractionEnabled = YES;

    [UIView animateWithDuration:0.2 delay:0.05 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 100 , self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}

- (void)backButonClicked {
    UITextField *textField = (UITextField *)[self viewWithTag:101];
    [textField resignFirstResponder];
    _backButton.userInteractionEnabled = NO;

    [UIView animateWithDuration:0.2 delay:0.05 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 100 , self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}

@end
