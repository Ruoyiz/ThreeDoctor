//
//  FirstPageCollectionViewCell.m
//  ThreeDoctor
//
//  Created by 若义张 on 16/1/27.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "FirstPageCollectionViewCell.h"

@implementation FirstPageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/5.0, SCREEN_WIDTH/5.0)];
        [self addSubview:self.imageView];
    }
    return self;
}


@end
