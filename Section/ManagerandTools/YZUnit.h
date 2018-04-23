//
//  YZUnit.h
//  Section
//
//  Created by QZL on 2017/2/20.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/types.h>
#import <sys/sysctl.h>
static NSString * systemFontName = @"方正幼线简体";

@interface YZUnit : NSObject

+ (UILabel *) configNormalLabelWithFont:(CGFloat)font;

/**
 *  震动反馈
 *
 *  @param vibrate_type 反馈类型:长震, 短震, 3DTouch反馈效果
 */
+ (void)Vibrate_touch:(unsigned int) vibrate_type;

/**
 *  获得设备型号
 *
 *  @return 设备型号
 */
+ (NSString *)getCurrentDeviceModel;

+ (UIColor *) navigationBarThemeColor;

+ (UIImage*)createImageWithColor:(UIColor*) color;

+ (YZUnit *) shareinstancetype;

/**
 *  wechat tabbar them color _unselected
 *
 *  @return 797E83
 */
+ (UIColor *) getTabbarThemColor_Unselected;

/**
 *  taobao tabbar them color selected
 *
 *  @return DE3B3A
 */
+ (UIColor *) getTabbarThemColor_Selected;

/**
 *  theme bg color
 *
 *  @return F2F2F2
 */
+ (UIColor *) getThemeBackgroundcolor;

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)randomColor;

@end
