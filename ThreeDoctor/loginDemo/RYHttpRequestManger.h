//
//  RYHttpRequestManger.h
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface RYHttpRequestManger : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;
@property (nonatomic, strong)AFHTTPSessionManager *manger;

+ (RYHttpRequestManger *)shareInstance;
- (void)Get:(NSString *)urlstring
 parameters:(NSString *)bodyString
downloadProgress:(void (^)(NSProgress* downloadProgress))downloadprogressBlock
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (void)Post:(NSString *)urlstring
  parameters:(NSString *)bodyString
downloadProgress:(void (^)(NSProgress* downloadProgress))downloadprogressBlock
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (void)cancelRequest;
@end
