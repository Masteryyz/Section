//
//  YZUnit.m
//  Section
//
//  Created by QZL on 2017/2/20.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "YZUnit.h"
#import <QuartzCore/QuartzCore.h>

static YZUnit * YZUnitInstance = nil;

@interface YZUnit ()

@property (nonatomic, strong) CADisplayLink * displayLink;
@property (nonatomic, copy) NSString * mode;

@end

@implementation YZUnit

+ (UILabel *) configNormalLabelWithFont:(CGFloat)font{
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"---";
    lb.numberOfLines = 1;
    lb.textColor = [UIColor colorWithHexValue:0x666666 alpha:1];
    lb.font = [UIFont fontWithName:@"Helvetica" size:font];
    
    lb.textAlignment = NSTextAlignmentLeft;
    
    return lb;
    
}

// 普通短震，3D Touch 中 Peek 震动反馈
//AudioServicesPlaySystemSound(1519);
// 普通短震，3D Touch 中 Pop 震动反馈
//AudioServicesPlaySystemSound(1520);
// 连续三次短震
//AudioServicesPlaySystemSound(1521);
+ (void)Vibrate_touch:(unsigned int) vibrate_type {

    AudioServicesPlaySystemSound(vibrate_type);

//    if ([[YZUnit getCurrentDeviceModel] isEqualToString:@"iPhone7"] || [[YZUnit getCurrentDeviceModel] isEqualToString:@"iPhone7Plus"]) {
//        
//        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleLight];
//        [generator prepare];
//        [generator impactOccurred];
//        
//    }
    
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

+ (UIColor *) navigationBarThemeColor {
 
    return [YZUnit colorWithHexValue:0xE4D098 alpha:0.75];
    
}

+ (UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (CADisplayLink *) isExistDisplayLink {
    if (_displayLink)
        return _displayLink;
    else
        return nil;
}

- (CADisplayLink *) getMainDisplayLinkFroSelector:(SEL) selector andMode:(NSString *) mode{

    if (!_displayLink) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:selector];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:mode];
        _mode = mode;
    }
    return _displayLink;
}

- (BOOL) killDisplayLink {
    if (_displayLink) {
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:_mode];
        [_displayLink invalidate];
        _displayLink = nil;
        return 1;
    }
    return 0;
}

+ (UIColor *) getTabbarThemColor_Unselected {
    return RGBA(121, 126, 131, 1);
}

+ (UIColor *) getTabbarThemColor_Selected {
    return RGBA(222, 59, 58, 1);
}

+ (UIColor *) getThemeBackgroundcolor {

    return RGBA(242, 242, 242, 0.9);
//    return [self randomColor];

}

+(UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f
                           green:((hexValue >> 8) & 0x000000FF)/255.0f
                            blue:((hexValue) & 0x000000FF)/255.0
                           alpha:alpha];
}

+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (YZUnit *)shareinstancetype {
    return [[self alloc]init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (YZUnitInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            YZUnitInstance = [super allocWithZone:zone];
        });
    }
    return YZUnitInstance;
}

- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YZUnitInstance = [super init];
    });
    return YZUnitInstance;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return YZUnitInstance;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return YZUnitInstance;
}

@end
