//
//  YZTabbarAnimationView.h
//  Section
//
//  Created by QZL on 2017/2/20.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationConfig_Type) {
    
    YZTabbarAnimationViewTypeNone = 0,
    
    YZTabbarAnimationViewTypeSlideIN,
    
    YZTabbarAnimationViewTypeSildeOut,
    
    YZTabbarAnimationViewTypeGradient,
    
};


@class YZTabbarButton;
@protocol YZTabbarAnimationViewDelegate <NSObject>

- (void) clickButton:(YZTabbarButton *)sender;

@end

@interface YZTabbarAnimationView : UIView

//+ (YZTabbarAnimationView *) shareinstancetype;

@property (nonatomic, assign) id<YZTabbarAnimationViewDelegate> delegate;

@property (nonatomic, assign) AnimationConfig_Type animationType;

@property (nonatomic, assign) BOOL isHide;

@property (nonatomic, strong) NSMutableArray * imageArray;
@property (nonatomic, strong) NSMutableArray * titleArray;

- (instancetype)initWithFrame:(CGRect)frame andImageArray:(NSMutableArray *)imageArray andTitleArray:(NSMutableArray *)titleArray;

@end
