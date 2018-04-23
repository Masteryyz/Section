//
//  YZUserManager.m
//  Section
//
//  Created by QZL on 2017/5/19.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "YZUserManager.h"

static YZUserManager * userManagerInstancetype = nil;

@implementation YZUserManager

- (BOOL) userIsExist{

    return YES;
}

- (NSDictionary *) getUserMessage{
    return @{
             @"userName" : @"Monster",
             @"userId" : @"xei120kjilfaxkwp931uo2931khy87f4jk1",
             @"userSex" : @"1",
             @"userAge" : @"18",
             @"userAvatar" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495186202323&di=dac2b9daf55023f36000ca099730d6c4&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D2a4d91fa7e310a55c424defc87444387%2F7796c5ea15ce36d3084288393df33a87e950b11c.jpg",
             @"userTEL" : @"17777862096"
             };
}

+ (YZUserManager *)shareManager {
    return [[self alloc]init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (userManagerInstancetype == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            userManagerInstancetype = [super allocWithZone:zone];
        });
    }
    return userManagerInstancetype;
}

- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManagerInstancetype = [super init];
    });
    return userManagerInstancetype;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return userManagerInstancetype;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return userManagerInstancetype;
}

@end
