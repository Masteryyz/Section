//
//  YZTeamModel.m
//  Section
//
//  Created by QZL on 2018/6/14.
//  Copyright © 2018年 WTF. All rights reserved.
//

#import "YZTeamModel.h"
#import "YZPlayerModel.h"
@implementation YZTeamModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"playInfos":[YZPlayerModel class]
             };
    
}

@end
