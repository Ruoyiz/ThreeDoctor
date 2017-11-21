//
//  YZHLLoginViewController.m
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "YZHLLoginViewController.h"
#import "FirstPageViewController.h"
#import "LeftSortsViewController.h"
#import "YZNavigationViewController.h"
#import "YZForgetPasswordViewController.h"
#import "YZLoginModel.h"
#import "ChangeDeviceView.h"

@interface YZHLLoginViewController () <UITextFieldDelegate> {

    UIImageView *backgroundView;
    UIView *textfiledView;
    YZLoginModel *_loginModel;
}

@end

@implementation YZHLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)layoutUI {
    
    backgroundView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundView.image = [UIImage imageNamed:@"登陆背景"];
    backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:backgroundView];

    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
    [backgroundView addGestureRecognizer:tapGes];
    
    //Logo
    CGFloat indexY = 20;
    CGFloat logoWidth = 120.0 * SCREEN_WIDTH/414.0;
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, indexY + logoWidth, logoWidth, logoWidth)];
    logoImageView.image = [UIImage imageNamed:@"登陆icon"];
    logoImageView.center = CGPointMake(SCREEN_WIDTH /2.0, indexY + SCREEN_HEIGHT/4.0);
    logoImageView.layer.masksToBounds = YES;
    logoImageView.layer.cornerRadius = logoWidth/2.0;
    [self.view addSubview:logoImageView];
    
    indexY += logoWidth*2;
    
    [self addTextFieldView:SCREEN_HEIGHT/2.0];
    
}

- (void)addTextFieldView:(CGFloat)indexY{
    NSArray *textArray = [NSArray arrayWithObjects:@"请输入您的帐号" ,@"请输入您的密码", nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"账户", @"密码", nil];
    
    CGFloat textHeight = 50;
    CGFloat textFieldFont = 13;
    
    if (SCREEN_HEIGHT >= 667) {
        textHeight = 55;
        textFieldFont = 14;
    }
    
    textfiledView = [[UIView alloc] initWithFrame:CGRectMake(0, indexY, SCREEN_WIDTH, textHeight * textArray.count)];
    textfiledView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textfiledView];
    
    for (int i = 0 ; i < textArray.count; i++){
        
        UIImageView *textFieldImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22,textHeight * i, 20, textHeight)];
        textFieldImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        textFieldImageView.contentMode = UIViewContentModeCenter;
        [textfiledView addSubview:textFieldImageView];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(22 + 30, textHeight * i, SCREEN_WIDTH - 44 - 30, textHeight)];
        textField.delegate = self;
        textField.placeholder = [textArray objectAtIndex:i];
        textField.font = [UIFont systemFontOfSize:textFieldFont];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.tag = 100 + i;
        if (i == 0) {
            textField.keyboardType = UIKeyboardTypeAlphabet;
        }else{
            textField.keyboardType = UIKeyboardTypeAlphabet;
            textField.secureTextEntry = YES;
            textField.returnKeyType = UIReturnKeyDone;
        }
        [textfiledView addSubview:textField];
        
        UIView *sharpView = [[UIView alloc] initWithFrame:CGRectMake(20, textHeight * (i + 1) - 2, SCREEN_WIDTH - 40, 1)];
        sharpView.backgroundColor = [UIColor whiteColor];
        sharpView.alpha = 0.3;
        [textfiledView addSubview:sharpView];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, indexY + 3 * textHeight - 20, SCREEN_WIDTH - 40, textHeight - 10);
    [button setTitle:@"登录" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 6;
    button.layer.borderColor = [[UIColor whiteColor] CGColor];
    button.layer.borderWidth = 1;
    [self.view addSubview:button];
    
    UIButton *resetSecButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55 - 15, button.frame.origin.y + textHeight + 20, 55, 23)];
    [resetSecButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    resetSecButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [resetSecButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    resetSecButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [resetSecButton addTarget:self action:@selector(forgetSecret) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetSecButton];
    
    UIView *sharpView = [[UIView alloc] initWithFrame:CGRectMake(4, resetSecButton.frame.size.height - 0.6 - 5, resetSecButton.frame.size.width - 4, 0.6)];
    sharpView.backgroundColor = [UIColor whiteColor];
    sharpView.alpha = 0.3;
    [resetSecButton addSubview:sharpView];
    
}

#pragma mark - textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 101) {
        [textField resignFirstResponder];
        [self returnTextfiledAnimation];
        return YES;
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textfiledView.frame.origin.y == SCREEN_HEIGHT/2.0) {
        [UIView animateWithDuration:0.3 animations:^{
            textfiledView.frame = CGRectMake(textfiledView.frame.origin.x, textfiledView.frame.origin.y - 100, textfiledView.frame.size.width, textfiledView.frame.size.height);
        }];
    }
}

#pragma mark -- buttonClicked
- (void)tapClicked {
    [self resignResponder];
    [self returnTextfiledAnimation];
}

- (void)login {
    
    UITextField *phoneTextField = (UITextField *)[self.view viewWithTag:100];
    UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:101];
    //test
//    phoneTextField.text = @"chc_tier1";
//    passwordTextField.text = @"123456";
    if(phoneTextField.text.length == 0 || passwordTextField.text.length == 0){
        [RYToastHelp showSVProgressToastWithTitle:@"登录失败" Info:@"账号或密码为空,请重新输入"];
        return;
    }
    
    if(![self judgeUsernameLegal:phoneTextField.text]||![self judgePassWordLegal:passwordTextField.text]){
//        [RYToastHelp showSVProgressToastWithError:@"用户名或密码格式错误,请重新输入"];
        [RYToastHelp showSVProgressToastWithTitle:@"登录失败" Info:@"用户名或密码格式错误,请重新输入"];
    
        return;
    }

    
    [phoneTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [RYToastHelp showSVProgressToastWithTitle:@"正在登录"];
    
    [YZLoginModel getModelWithUsername:phoneTextField.text password:passwordTextField.text sucessse:^(YZLoginModel *loginModel) {
        _loginModel = loginModel;
        [RYToastHelp dismissSVProgress];
        switch (loginModel.status) {
            case LoginStausSuccess:
                [RYToastHelp showSVProgressWithSuccess:loginModel.message];
                [self loginSuccess];
                break;
                case LoginStausFailure:
                if (loginModel.message.length > 0) {
//                    [RYToastHelp showSVProgressToastWithError:loginModel.message];
                    [RYToastHelp showSVProgressToastWithTitle:@"登录失败" Info:loginModel.message];
                }else {
//                    [RYToastHelp showSVProgressToastWithError:@"登录失败"];
                    [RYToastHelp showSVProgressToastWithTitle:@"登录失败" Info:@"网络请求错误"];

                }
                break;
                case LoginStausChangeDevice:
                [self changeDeviceWithPhoneNumber:loginModel.userInfoModel.mobile];
                break;
                case LoginStausCompleteMessage:
                [self completeMessage];
                break;
            default:
                break;
        }
    } failure:^(NSError *errer) {
        [RYToastHelp dismissSVProgress];
        [RYToastHelp showSVProgressToastWithTitle:@"登录失败" Info:@"网络请求错误"];
    }];
}

- (void)loginSuccess {
    [self updateLocalUserinfoData];
    [self presentFistpageVC];
}

- (void)changeDeviceWithPhoneNumber:(NSString *)phoneNumber{
    [RYToastHelp dismissSVProgress];
    ChangeDeviceView *deviceView = [[ChangeDeviceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*4/5.0, SCREEN_WIDTH/2.0) phoneNumber:phoneNumber];
    deviceView.backgroundColor = [UIColor whiteColor];
    deviceView.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    [deviceView show];
    deviceView.finshBlock = ^ {
        [self updateLocalUserinfoData];
        [self presentFistpageVC];
    };
}

- (void)updateLocalUserinfoData {
    UITextField *phoneTextField = (UITextField *)[self.view viewWithTag:100];
    UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:101];
    [[NSUserDefaults standardUserDefaults]setUserName:phoneTextField.text];
    [[NSUserDefaults standardUserDefaults]setPassWord:passwordTextField.text];
    [[NSUserDefaults standardUserDefaults] setDeviceToken:_loginModel.token];
}

- (void)completeMessage {
    [RYToastHelp dismissSVProgress];

}

- (void)forgetSecret {
    
    YZForgetPasswordViewController *forgetVC = [[YZForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];

}

- (void)presentFistpageVC {
    AppDelegate *myapp = APP_DELEGATE;
    FirstPageViewController *firstVC = [[FirstPageViewController alloc] init];
    myapp.mainNavigationController = [[YZNavigationViewController alloc] initWithRootViewController:firstVC];
    LeftSortsViewController *leftSortVC = [[LeftSortsViewController alloc] init];
    myapp.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftSortVC andMainView:myapp.mainNavigationController];
    [self presentViewController:myapp.LeftSlideVC animated:YES completion:nil];
}

- (void)resignResponder {
    UITextField *textField = (UITextField *)[self.view viewWithTag:100];
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:101];
    [textField resignFirstResponder];
    [textField1 resignFirstResponder];
}

- (void)returnTextfiledAnimation {
    if (textfiledView.frame.origin.y == SCREEN_HEIGHT/2.0 - 100) {
        [UIView animateWithDuration:0.3 animations:^{
            textfiledView.frame = CGRectMake(textfiledView.frame.origin.x, textfiledView.frame.origin.y + 100, textfiledView.frame.size.width, textfiledView.frame.size.height);
        }];
    }
}

- (BOOL)judgePassWordLegal:(NSString *)passWord {
    BOOL result = false;
    if ([passWord length] >= 6){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^[0-9A-Za-z]{6,12}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:passWord];
    }
    return result;
}

- (BOOL)judgeUsernameLegal:(NSString *)userName {
    BOOL result = false;
    if ([userName length] >= 6){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^[0-9A-Za-z_]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:userName];
    }
    return result;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
