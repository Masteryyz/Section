//
//  YZTabbarButton.m
//  Section
//
//  Created by QZL on 2017/2/20.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "YZTabbarButton.h"

@interface YZTabbarButton ()

@property (nonatomic,strong)UILabel * customLabel;

@property (nonatomic, strong) UIImageView * customImageView;

@property (nonatomic, strong) UIImage * selectedImage;
@property (nonatomic, strong) UIImage * unselectedImage;

@end

@implementation YZTabbarButton

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
//        _customImageView = [[UIImageView alloc] init];
////        _customImageView.backgroundColor = [UIColor clearColor];
//        _customImageView.frame = CGRectMake(0, 6, 24, 24);
//        _customImageView.userInteractionEnabled = YES;
//        _customImageView.centerX = self.width / 2;
//        [self addSubview:_customImageView];
//        
//        _customLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_customImageView.frame) + 2, frame.size.width, 14)];
//        _customLabel.font = [UIFont systemFontOfSize:12.0f];
//        _customLabel.numberOfLines = 1;
//        _customLabel.textColor = [YZUnit getTabbarThemColor_Unselected];
//        _customLabel.textAlignment = NSTextAlignmentCenter;
//        _customLabel.userInteractionEnabled = YES;
//        _customLabel.backgroundColor = [UIColor clearColor];
//        
//        
//        [self addSubview:_customLabel];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self setTitleColor:[YZUnit getTabbarThemColor_Unselected] forState:UIControlStateNormal];
        [self setTitleColor:[YZUnit getTabbarThemColor_Selected] forState:UIControlStateSelected];
        
    }
    
    return self;

}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    return CGRectMake(self.width / 2 - 12, 6, 24, 24);

}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    return CGRectMake(0, 32, self.width, 14);

}

- (void)setSelected:(BOOL)selected {

    [super setSelected:selected];

    if (selected) {

//        [_customImageView setImage:_selectedImage];
//        [_customLabel setTextColor:[YZUnit getTabbarThemColor_Selected]];
        
//        DebugLog(@"%@" , _customLabel);
        
        [UIView animateWithDuration:0.25 animations:^{
            
//            _customImageView.alpha = 0;
//            _customLabel.alpha = 0;
            self.titleLabel.alpha = 0;
            self.imageView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.25 animations:^{
               
//                _customImageView.alpha = 1;
//                _customLabel.alpha = 1;
                
                self.titleLabel.alpha = 1;
                self.imageView.alpha = 1;
                
            }];
            
        }];
        
//        [_customImageView setUserInteractionEnabled:YES];
        
    }
    
//    else {
    
        //        [_customImageView setImage:_unselectedImage];
        //        [_customLabel setTextColor:[YZUnit getTabbarThemColor_Unselected]];
        //
        //        [_customImageView setUserInteractionEnabled:YES];
        
//    }
    
}

- (void)setTitle:(NSString *)title {

    _customLabel.text = title;
    
}

- (void) setImageName:(NSString *)imageName {
    
    self.unselectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_unselected" , imageName]];
    self.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected" , imageName]];
    
    [_customImageView setImage:_unselectedImage];
    [_customImageView setUserInteractionEnabled:YES];
    
}

@end
