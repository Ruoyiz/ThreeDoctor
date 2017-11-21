//
//  NSString+ThreeDES.h
//  ThreeDoctor
//
//  Created by 若义张 on 16/1/27.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "GTMBase64.h"

@interface NSString (ThreeDES)
-(NSString *)doEncryptStr;
-(NSString*)doDecEncryptStr;
@end
