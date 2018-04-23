//
//  YZBasicNavigationController.h
//  Section
//
//  Created by QZL on 2017/2/20.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <UIKit/UIKit.h>

//'td' make -> to do;

@interface YZBasicNavigationController : UINavigationController

@property (nonatomic, assign) BOOL td_animation;

@property (nonatomic, copy) NSString * identifer;

@property (nonatomic, strong) NSArray * array;

@end
