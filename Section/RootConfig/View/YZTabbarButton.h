//
//  YZTabbarButton.h
//  Section
//
//  Created by QZL on 2017/2/20.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZTabbarButton : UIButton

@property (nonatomic, assign) BOOL isPostButton;

@property (nonatomic, assign) NSInteger index;

- (void) setTitle:(NSString *)title;
- (void) setImageName:(NSString *)imageName;

@end
