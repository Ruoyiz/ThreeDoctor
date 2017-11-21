




//  YZUserinfoModel.m
//  CommunityDoctory
//
//  Created by 若义张 on 16/2/2.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "YZUserinfoModel.h"

@implementation YZUserinfoModel

+ (YZUserinfoModel *)getUserInfoModelWithDict:(NSDictionary *)userinfoDict {
    YZUserinfoModel *model = [[YZUserinfoModel alloc] init];
    model.department = userinfoDict[@"department"];
    model.mail = userinfoDict[@"mail"];
    model.mobile = userinfoDict[@"mobile"];
    model.realName = userinfoDict[@"realName"];
    model.userId = userinfoDict[@"userId"];
    model.userName = userinfoDict[@"userName"];
    
    return model;
}

@end
