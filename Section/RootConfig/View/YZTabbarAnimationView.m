//
//  YZTabbarAnimationView.m
//  Section
//
//  Created by QZL on 2017/2/20.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "YZTabbarAnimationView.h"
#import "YZTabbarButton.h"

//static YZTabbarAnimationView * Instance = nil;

#define kAniIconSize                                          24

@interface YZTabbarAnimationView ()

/**
 *  User Interface
 */
@property (nonatomic, strong) UIView * basicView;
@property (nonatomic, strong) UIView * insertView;
@property (nonatomic, strong) UIView * forgroundView;

@property (nonatomic, strong) UIView * coverView;

@property (nonatomic, strong) UIView * badgeView;

@property (nonatomic, strong) NSMutableArray * buttonArray;

@property (nonatomic, strong) YZTabbarButton * selectedButton;


/**
 *  animationView
 */
@property (nonatomic, strong) UIImageView * aniView;


/**
 *  Interaction Mode
 */

@property (nonatomic, strong) CABasicAnimation * cabAnimation;
@property (nonatomic, strong) UIBezierPath * bPath;

/**
 *  NetWork conpany
 */

@property (nonatomic, strong) NSDictionary * json_Dict;
@property (nonatomic, strong) NSMutableArray * dataArray;



@end

@implementation YZTabbarAnimationView

- (instancetype)initWithFrame:(CGRect)frame andImageArray:(NSMutableArray *)imageArray andTitleArray:(NSMutableArray *)titleArray {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _titleArray = titleArray;
        _imageArray = imageArray;
        
        NSInteger issuccess = [self initializationViewSystem];
        
        if (!issuccess)
            NSAssert(!issuccess, @"数据出错.....");
        
    }

    return self;

}

- (NSInteger) initializationViewSystem {

    if (self) {
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, k_SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        
        _basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _basicView.backgroundColor = [UIColor clearColor];
        [self addSubview:_basicView];
        
        _insertView = [[UIView alloc] initWithFrame:_basicView.frame];
        _insertView.backgroundColor = [UIColor whiteColor];
        _insertView.alpha = 0.5;
//        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:_insertView.frame];
//        toolbar.barStyle = UIBarStyleBlackTranslucent;

//        [_insertView addSubview:toolbar];
        [_basicView addSubview:_insertView];
        
        
        _aniView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, kAniIconSize, kAniIconSize)];
        _aniView.backgroundColor = [UIColor clearColor];
        _aniView.alpha = 0.3;
        [_aniView setImage:[UIImage imageNamed:@"LoadingImage_NoText"]];
        [_basicView addSubview:_aniView];
        
        [self startAnimation];
        
        _forgroundView = [[UIView alloc] initWithFrame:_basicView.frame];
        _forgroundView.backgroundColor = [UIColor clearColor];
        [_basicView addSubview:_forgroundView];
        
        if (_titleArray.count == _imageArray.count && _titleArray.count != 0 && _imageArray.count != 0) {
            
            CGFloat x = self.width / _titleArray.count / 2 - (kAniIconSize / 2);
            _aniView.x = x;
            
            _buttonArray = [NSMutableArray arrayWithCapacity:_imageArray.count];
            
            for (int i = 0; i<_titleArray.count; i++) {
                
                YZTabbarButton * button = [[YZTabbarButton alloc] initWithFrame:CGRectMake(i * (_basicView.width / _titleArray.count), 0, _basicView.width / _titleArray.count, _basicView.height)];
                
                button.backgroundColor = [UIColor clearColor];
                button.index = i;
                
                [button setTitle:[NSString stringWithFormat:@"%@" , [_titleArray objectAtIndex:i]] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_unselected" , [_imageArray objectAtIndex:i]]] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected" , [_imageArray objectAtIndex:i]]] forState:UIControlStateSelected];
//                [button setTitle:[NSString stringWithFormat:@"%@" , [_titleArray objectAtIndex:i]]];
//                [button setImageName:[NSString stringWithFormat:@"%@" , [_imageArray objectAtIndex:i]]];
                
                [button addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [_forgroundView addSubview:button];
                
                [_buttonArray addObject:button];

                if (i == 0) {
                    [button setSelected:YES];
                    self.selectedButton = button;
                }
                
            }
            
            
        } else return 0;
        
        return 1;
    }
    
    return 0;

}

- (void) tabbarButtonClick:(YZTabbarButton *) sender {

    if (sender != self.selectedButton) {
        
        [self.selectedButton setSelected:NO];
        
        [sender setSelected:YES];
        
        self.selectedButton = sender;
        
        [YZUnit Vibrate_touch:1519];
        
    }
    
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:sender];
        
        [_aniView.layer removeAllAnimations];
        
        [UIView animateWithDuration:0.25 animations:^{
           
            _aniView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            _aniView.x = self.width / _titleArray.count * (sender.index + 1) - ((self.width / _titleArray.count) / 2) - (kAniIconSize / 2);
            
            [UIView animateWithDuration:0.25 animations:^{
                
                _aniView.alpha = 0.3;
                
                [self startAnimation];
                
            }];
            
        }];
        
    }

}

- (void) startAnimation {

    CABasicAnimation * tranformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    tranformAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    tranformAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
    tranformAnimation.repeatCount = MAXFLOAT;
    tranformAnimation.duration = 12.5;
    //    tranformAnimation.autoreverses = YES;
    tranformAnimation.cumulative = YES;
    tranformAnimation.removedOnCompletion = NO;
    
    tranformAnimation.delegate = self;
    
    _aniView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [_aniView.layer addAnimation:tranformAnimation forKey:@"---"];

}

//+ (YZTabbarAnimationView *)shareinstancetype {
//    return [[self alloc]init];
//}
//
//+ (id)allocWithZone:(struct _NSZone *)zone
//{
//    if (Instance == nil) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            Instance = [super allocWithZone:zone];
//        });
//    }
//    return Instance;
//}
//
//- (id)init
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Instance = [super init];
//    });
//    return Instance;
//}
//
//+ (id)copyWithZone:(struct _NSZone *)zone
//{
//    return Instance;
//}
//
//+ (id)mutableCopyWithZone:(struct _NSZone *)zone
//{
//    return Instance;
//}


@end
