//
//  YZMainAvatarView.h
//  Section
//
//  Created by QZL on 2017/5/19.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZMainAvatarView : UIView

@property (nonatomic, copy) NSString * avatarURL;

@property (nonatomic, copy) NSString * decorationURL;

- (instancetype)initWithFrame:(CGRect)frame;

@end
