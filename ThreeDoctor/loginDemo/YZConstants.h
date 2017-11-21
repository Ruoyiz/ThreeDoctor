//
//  YZConstants.h
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#ifndef YZConstants_h
#define YZConstants_h

#define APP_DELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]//获得Appdelegate
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)  //获取屏幕 宽度
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height) //获取屏幕 高度
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UICOLOR(R, G, B, A)[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#endif /* YZConstants_h */
