//
//  BaseViewController.m
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setMyTitle:(NSString *)myTitle {
    _myTitle = myTitle;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 42)];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = label;
    
    [label setText:_myTitle];
}

- (void)setLeftItemWithImage:(UIImage *)aImage andSelectImage:(UIImage *)sImage {

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (aImage) {
        [backButton setImage:aImage forState:UIControlStateNormal];
    }else{
        [backButton setImage:[UIImage imageNamed:@"navBack"] forState:UIControlStateNormal];
    }
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(leftItemMethod) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(0, 0, 24, 24)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void)setRightItemWithImage:(UIImage *)aImage
               andSelectImage:(UIImage *)sImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:aImage forState:UIControlStateNormal];
    [button setImage:sImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightItemMethod:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 24, 24 + 4)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 4, 0, -4)];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}


- (void)setRightItemWithText:(NSString *)aString andColor:(UIColor *)aColor {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:aString forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(rightItemMethod:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 56, 30)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, -6)];
    [button setTitleColor:aColor forState:UIControlStateNormal];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
 
}

- (void)leftItemMethod{}
- (void)rightItemMethod:(UIButton *)button{}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
