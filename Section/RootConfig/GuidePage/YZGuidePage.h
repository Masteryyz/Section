//
//  YZGuidePage.h
//  Section
//
//  Created by QZL on 2017/2/21.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZGuidePageDelegate <NSObject>

- (void) jumpToMainPage:(id) sender;

@end

@interface YZGuidePage : UIViewController

@property (nonatomic, assign) id<YZGuidePageDelegate> delegate;

@end
