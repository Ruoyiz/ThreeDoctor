//
//  RYButton.m
//  CommunityDoctory
//
//  Created by 若义张 on 16/2/2.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "RYButton.h"

@implementation RYButton

- (instancetype)initWithFrame:(CGRect)frame titleText:(NSString *)title textColor:(UIColor *)textColor textFont:(UIFont *)textFont backGroundColor:(UIColor *)backgroundColor
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self.titleLabel setFont:textFont];
        [self setBackgroundColor:backgroundColor];
    }
    return self;
}
@end
