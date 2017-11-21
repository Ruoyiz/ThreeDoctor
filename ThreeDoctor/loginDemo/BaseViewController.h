//
//  BaseViewController.h
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *myTitle;

- (void)setLeftItemWithImage:(UIImage *)aImage andSelectImage:(UIImage *)sImage;
- (void)setRightItemWithImage:(UIImage *)aImage andSelectImage:(UIImage *)sImage;
- (void)setRightItemWithText:(NSString *)aString andColor:(UIColor *)aColor;
- (void)leftItemMethod;
- (void)rightItemMethod:(UIButton *)button;
@end
