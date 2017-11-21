//
//  ChangeDeviceView.h
//  CommunityDoctory
//
//  Created by 若义张 on 16/2/1.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeDeviceView : UIView
@property (nonatomic, strong)UIButton *resendButton;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UIButton *backButton;
@property (nonatomic, copy) void(^finshBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame phoneNumber:(NSString *)phoneNumber;
- (void)show;
- (void)hide;
@end
