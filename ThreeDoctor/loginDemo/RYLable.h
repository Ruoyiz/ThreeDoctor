//
//  RYLable.h
//  CommunityDoctory
//
//  Created by 若义张 on 16/1/28.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    VerticalAlignmentTop = 0,//labelText 顶端显示
    VerticalAlignmentMiddle,//labelText 竖直方向居中
    VerticalAlignmentBottom,//labelText 靠底显示
} VerticalAlignment;


@interface RYLable : UILabel

//已知title
- (instancetype)initWithFrame:(CGRect)frame titleText:(NSString *)title textColor:(UIColor *)textColor textFont:(UIFont *)textFont lineSpace:(CGFloat)lineSpace autoHeight:(BOOL)autoHeight;
//未知title
- (instancetype)initWithFrame:(CGRect)frame textColor:(UIColor *)textColor textFont:(UIFont *)textFont lineSpace:(CGFloat)lineSpace autoHeight:(BOOL)autoHeight;

@property (nonatomic, strong) NSString *LabelText;
@property (nonatomic) VerticalAlignment verticalAlignment;

@end
