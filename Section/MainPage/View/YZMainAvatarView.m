//
//  YZMainAvatarView.m
//  Section
//
//  Created by QZL on 2017/5/19.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "YZMainAvatarView.h"

#define kDefaultMaxSize                                         H(80)
#define kDefaultMinSize                                         kDefaultMaxSize * 0.75

@interface YZMainAvatarView ()

@property (nonatomic, strong) UIView * backgroundView;

@property (nonatomic, strong) UIImageView * decoration;

@property (nonatomic, strong) UIImageView * avatarView;

@property (nonatomic, assign) CGFloat Estimate_Size;

@property (nonatomic, strong) YZUserManager * user_Main;
@property (nonatomic, strong) NSDictionary * user_Dict;

@end

@implementation YZMainAvatarView

- (void)setAvatarURL:(NSString *)avatarURL {

    _avatarURL = avatarURL;

}

- (void)setDecorationURL:(NSString *)decorationURL {

    _decorationURL = decorationURL;

}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        CGFloat tmpH        = frame.size.height;
        CGFloat tmpW        = frame.size.width;
        
        _Estimate_Size      = tmpH >= tmpH ? tmpH : tmpW;
        self.size           = CGSizeMake(_Estimate_Size, _Estimate_Size);
        
        _user_Main          = [YZUserManager shareManager];
        
        [self configUserInterface];
        
    }

    return self;

}

- (void) configUserInterface {

    if (!_backgroundView) {
        
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _Estimate_Size, _Estimate_Size)];
        _backgroundView.backgroundColor = [UIColor clearColor];
        _backgroundView.userInteractionEnabled = YES;
        
        [self addSubview:_backgroundView];
        
    }
    
    if (!_decoration) {
        
        _decoration = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _Estimate_Size, _Estimate_Size)];
        _decoration.backgroundColor = [UIColor clearColor];
        _decoration.userInteractionEnabled = YES;
        
        _decoration.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_decoration];
        
    }
    
    [_decoration setImage:[UIImage imageNamed:@"LoadingImage_NoText"]];
    
    if (!_avatarView) {
        
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _Estimate_Size * 0.75, _Estimate_Size * 0.75)];
        _avatarView.backgroundColor = [UIColor clearColor];
        _avatarView.userInteractionEnabled = YES;
        
        _avatarView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_avatarView];
        
        _avatarView.layer.cornerRadius = _Estimate_Size * 0.75 / 2;
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _avatarView.layer.borderWidth = 0.5f;
        
        _avatarView.center = CGPointMake(_Estimate_Size / 2, _Estimate_Size /  2);
    }
    
    _user_Dict = [_user_Main getUserMessage];
    
    NSString * avatarUrl = [NSString stringWithFormat:@"%@" , [_user_Dict objectForKey:@"userAvatar"]];

    [_avatarView sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"snowman_selected"]];
    
}

@end
