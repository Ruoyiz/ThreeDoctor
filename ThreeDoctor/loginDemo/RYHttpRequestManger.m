//
//  RYHttpRequestManger.m
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "RYHttpRequestManger.h"

@implementation RYHttpRequestManger

+ (RYHttpRequestManger *)shareInstance {
    
    static dispatch_once_t onceToken;
    static RYHttpRequestManger *requestClient = nil;
    dispatch_once(&onceToken, ^{
        requestClient = [[RYHttpRequestManger alloc] init];
        // init Http HEADER
        requestClient.manger = [AFHTTPSessionManager manager];
        [requestClient setHttpHeader:requestClient.manger];
    });
    return requestClient;
}


- (void)Get:(NSString *)urlstring parameters:(NSDictionary *)bodyString downloadProgress:(void (^)(NSProgress *))downloadprogressBlock success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    urlstring = [NSString stringWithFormat:@"%@%@",baseUrl,urlstring];
    NSDictionary *param = @{@"header":@{@"deviceId":[RYHelper getIdfv],@"appToken":@"",@"serviceCode":@"login",@"appType":@5,@"appVersion":[RYHelper getAppVersion],@"clientType":@2},@"body":@{@"param":bodyString}};
    NSDictionary *paramDict = @{@"data":[RYHelper DataTOjsonString:param]};
    NSLog(@"param ======== == %@",paramDict);
    
    self.sessionDataTask = [self.manger GET:urlstring parameters:paramDict progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadprogressBlock) {
            downloadprogressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (void)Post:(NSString *)urlstring parameters:(NSString *)bodyString downloadProgress:(void (^)(NSProgress *))downloadprogressBlock success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    urlstring = [NSString stringWithFormat:@"%@%@",baseUrl,urlstring];
    NSDictionary *param = @{@"header":@{@"deviceId":[RYHelper getIdfv],@"appToken":[NSUserDefaults standardUserDefaults].deviceToken,@"serviceCode":@"login",@"appType":@5,@"appVersion":[RYHelper getAppVersion],@"clientType":@2},@"body":@{@"param":bodyString}};
    NSDictionary *paramDict = @{@"data":[RYHelper DataTOjsonString:param]};
    NSLog(@"param ======== == %@",paramDict);
    
    self.sessionDataTask = [self.manger POST:urlstring parameters:paramDict progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadprogressBlock) {
            downloadprogressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    
}

- (void)cancelRequest {
    [self.sessionDataTask cancel];
}

- (void)setHttpHeader:(AFHTTPSessionManager *)session {
    //@"header":@{@"deviceId":@"",@"appToken":@"",@"serviceCode":@"login",@"appType":@1,@"appVersion":@1,@"clientType":@1}
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [session setResponseSerializer:responseSerializer];
    session.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    //    [session.requestSerializer setValue:@"" forKey:@"deviceId"];
    //    [session.requestSerializer setValue:@"" forKey:@"appToken"];
    //    [session.requestSerializer setValue:@"login" forKey:@"serviceCode"];
    //    [session.requestSerializer setValue:@1 forKey:@"appType"];
    //    [session.requestSerializer setValue:@1 forKey:@"appVersion"];
    //    [session.requestSerializer setValue:@1 forKey:@"clientType"];
}


@end
