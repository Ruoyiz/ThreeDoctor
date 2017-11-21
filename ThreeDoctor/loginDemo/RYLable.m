//
//  RYLable.m
//  CommunityDoctory
//
//  Created by 若义张 on 16/1/28.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "RYLable.h"

@interface RYLable (){
    CGRect Myframe;
    UIFont *myFont;
    UIColor *_textColor;
    NSMutableParagraphStyle *paragraphstyle;
    BOOL _autoHeight;
}
@end


@implementation RYLable
@synthesize verticalAlignment = verticalAlignment_;
- (instancetype)initWithFrame:(CGRect)frame titleText:(NSString *)title textColor:(UIColor *)textColor textFont:(UIFont *)textFont lineSpace:(CGFloat)lineSpace autoHeight:(BOOL)autoHeight{
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfLines = 0;
        paragraphstyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphstyle setLineSpacing:lineSpace];
        _autoHeight = autoHeight;
        _textColor = textColor;
        if (title.length > 0) {
            self.attributedText = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName:paragraphstyle}];
        }
         if (autoHeight) {
            CGSize size = [title boundingRectWithSize:CGSizeMake(frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphstyle} context:nil].size;
            self.frame =CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textColor:(UIColor *)textColor textFont:(UIFont *)textFont lineSpace:(CGFloat)lineSpace autoHeight:(BOOL)autoHeight{
    self = [super initWithFrame:frame];
    if (self) {
        Myframe = frame;
        myFont = textFont;
        _textColor = textColor;
        self.numberOfLines = 0;
        _autoHeight = autoHeight;
        paragraphstyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphstyle setLineSpacing:lineSpace];
        self.attributedText = [[NSAttributedString alloc] initWithString:@"label" attributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:textColor, NSParagraphStyleAttributeName:paragraphstyle}];
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment{
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (void)drawTextInRect:(CGRect)rect{
    CGRect acturlRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:acturlRect];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentMiddle:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height)/2.0;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        default:
            break;
    }
    
    return textRect;
}

- (void)setLabelText:(NSString *)LabelText{
    self.attributedText = [[NSAttributedString alloc] initWithString:LabelText attributes:@{NSFontAttributeName:myFont,NSForegroundColorAttributeName:_textColor, NSParagraphStyleAttributeName:paragraphstyle}];
    if (_autoHeight) {
        CGSize size = [LabelText boundingRectWithSize:CGSizeMake(Myframe.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:myFont,NSParagraphStyleAttributeName:paragraphstyle} context:nil].size;
        self.frame =CGRectMake(Myframe.origin.x, Myframe.origin.y, Myframe.size.width, size.height);
    }
}


@end
