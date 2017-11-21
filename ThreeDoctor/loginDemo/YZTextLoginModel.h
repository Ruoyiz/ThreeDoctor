//
//  YZTextLoginModel.h
//  ThreeDoctor
//
//  Created by 若义张 on 16/2/23.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import <Realm/Realm.h>

@interface YZTextLoginModel : RLMObject
@property NSString *userName;
@property NSInteger userId;
@property NSString *realName;
@property NSInteger mobile;
@property NSString *mail;
+ (YZTextLoginModel *)testUserinfoModelWithDict:(NSDictionary *)dict;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<YZTextLoginModel>
RLM_ARRAY_TYPE(YZTextLoginModel)
