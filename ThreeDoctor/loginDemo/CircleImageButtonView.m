//
//  CircleImageButtonView.m
//  ThreeDoctor
//
//  Created by 若义张 on 16/1/27.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "CircleImageButtonView.h"

@implementation CircleImageButtonView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)aTitle {

    self = [super initWithFrame:frame];
    if (self) {
        CGFloat buttonWidth = frame.size.width;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = buttonWidth/2.0;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 1;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, buttonWidth/4.0, buttonWidth/4.0)];
        imageView.center = CGPointMake(buttonWidth/2.0, buttonWidth/4.0);
        imageView.image = [UIImage imageNamed:aTitle];
        [self addSubview:imageView];
        
        UILabel *bottomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, buttonWidth/8.0)];
        bottomeLabel.center = CGPointMake(buttonWidth/2.0, buttonWidth*3.0/4.0);
        bottomeLabel.textAlignment = NSTextAlignmentCenter;
        [bottomeLabel setTextColor:[UIColor whiteColor]];
        bottomeLabel.font = [UIFont systemFontOfSize:14];
        [bottomeLabel setText:aTitle];
        [self addSubview:bottomeLabel];

    }
    return self;
}

@end
