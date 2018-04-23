//
//  YZFoolPageController.m
//  Section
//
//  Created by QZL on 2017/7/6.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "YZFoolPageController.h"

@interface YZFoolPageController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * mainScro;

@end

@implementation YZFoolPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_mainScro) {
        _mainScro = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _mainScro.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1];
        
        _mainScro.delegate = self;
        
        [self.view addSubview:_mainScro];
    }
    
    for (int i = 0; i < 30; i ++) {
        
        UIView * fuck = [[UIView alloc] initWithFrame:CGRectMake(10 * i, 0, 44, [self getRandomNumber:10 to:300])];
        
        fuck.mj_origin = CGPointMake(20 * (i + 1) + fuck.width * i, 500 - fuck.height);
        
        fuck.backgroundColor = [self colorWithHexValue:0xf2f2f2 alpha:1];
        
        fuck.layer.borderColor = [self colorWithHexValue:0x199fff alpha:1].CGColor;
        fuck.layer.borderWidth = 1;
        fuck.layer.cornerRadius = 2;
        
        UILabel * labe = [[UILabel alloc] init];
        
        labe.text = @"操";
        
        labe.textColor = [UIColor redColor];
        
        labe.font = [UIFont systemFontOfSize:24 weight:1.5];
        
        [labe sizeToFit];
        labe.center = CGPointMake(fuck.width / 2, fuck.height / 2);
        
        [fuck addSubview:labe];
        
        labe.alpha = 0;
        
        [_mainScro addSubview:fuck];
        
        if (i == 29) {
            
            [self.mainScro setContentSize:CGSizeMake(CGRectGetMaxX(fuck.frame) + 50, 0)];
            
        }
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    DebugLog(@"%f" , offsetX);
    
    
    [_mainScro.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIView * vw = (UIView *)obj;
        
        if (vw.x < offsetX + WIDTH / 2 && CGRectGetMaxX(vw.frame) > offsetX + WIDTH / 2) {
            
            vw.backgroundColor = [UIColor orangeColor];
            
            [[vw subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                if ([obj isKindOfClass:[UILabel class]]) {
                    
                    obj.alpha = 1;
                }
                
            }];
            
        } else {
        
            vw.backgroundColor = [self colorWithHexValue:0xf2f2f2 alpha:1];
            
            [[vw subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[UILabel class]]) {
                    
                    obj.alpha = 0;
                }
                
            }];
            
        }
        
    }];
    
    
}

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

-(UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f
                           green:((hexValue >> 8) & 0x000000FF)/255.0f
                            blue:((hexValue) & 0x000000FF)/255.0
                           alpha:alpha];
}

-(UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
