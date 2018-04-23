//
//  YZUserManager.h
//  Section
//
//  Created by QZL on 2017/5/19.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZUserManager : NSObject

- (BOOL) userIsExist;

- (NSDictionary *) getUserMessage;

+ (YZUserManager *) shareManager;

@end
