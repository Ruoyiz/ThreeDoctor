//
//  YZTestModelManger.m
//  ThreeDoctor
//
//  Created by 若义张 on 16/2/23.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "YZTestModelManger.h"

@implementation YZTestModelManger

+ (void)saveTestModel:(YZTextLoginModel *)model {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:model];
    }];
}

@end
