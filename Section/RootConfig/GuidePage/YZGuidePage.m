//
//  YZGuidePage.m
//  Section
//
//  Created by QZL on 2017/2/21.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "YZGuidePage.h"

#define margin 4

@interface YZGuidePage ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) UIImageView * mainImageView;

@property (nonatomic, strong) UIImageView * imageView1;
@property (nonatomic, strong) UIImageView * imageView2;
@property (nonatomic, strong) UIImageView * imageView3;
@property (nonatomic, strong) UIImageView * imageView4;


@property (nonatomic, strong) UIView * totalView1;
@property (nonatomic, strong) UIView * totalView2;
@property (nonatomic, strong) UIView * totalView3;
@property (nonatomic, strong) UIView * totalView4;


@property (nonatomic, strong) UIView * finalView;
@property (nonatomic, strong) UIView * insertView;

@property (nonatomic, strong) UILabel * yi;
@property (nonatomic, strong) UILabel * nian;
@property (nonatomic, strong) UILabel * qing;
@property (nonatomic, strong) UILabel * cheng;

@property (nonatomic, strong) UIView * yinianView;
@property (nonatomic, strong) UIView * qingchengView;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSMutableArray * imageArray;
@property (nonatomic, strong) NSMutableArray * imageViewArray;

@end

@implementation YZGuidePage

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        
        NSLog(@"swipe down");
        //执行程序
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        
        NSLog(@"swipe up");
        //执行程序
    }
    
    
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"swipe left");
        //执行程序
    }
    
    
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"swipe right");
        //执行程序
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.view.backgroundColor = [YZUnit getThemeBackgroundcolor];
    
    _imageArray = [NSMutableArray arrayWithCapacity:4];
    _imageViewArray = [NSMutableArray arrayWithCapacity:4];
    
    for (int i = 0; i < 4; i ++) {
        
        NSString * str = [NSString stringWithFormat:@"guidePage_%d" , i];
        UIImage * image = [UIImage imageNamed:str];
        [_imageArray addObject:image];
        
    }
    
    [self configInedges];
    
    if (!_mainScrollView) {
        
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _mainScrollView.userInteractionEnabled = YES;
        _mainScrollView.scrollEnabled = YES;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.backgroundColor = [UIColor clearColor];
        //        _mainScrollView.backgroundColor = [UIColor darkGrayColor];
        //        _mainScrollView.alpha = 0.3;
        
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        
        _mainScrollView.delegate = self;
        
        _mainScrollView.contentSize = CGSizeMake(k_SCREEN_WIDTH * _imageArray.count, k_SCREEN_HEIGHT);
        
        
    }
    
    [self.view addSubview:_mainScrollView];
    
    _finalView = [[UIView alloc] initWithFrame:self.view.frame];
    _finalView.backgroundColor = [UIColor clearColor];
    _finalView.userInteractionEnabled = YES;
    _finalView.mj_origin = CGPointMake(k_SCREEN_WIDTH * 3, 0);
    [_mainScrollView addSubview:_finalView];
    
    _insertView = [[UIView alloc] initWithFrame:self.view.frame];
    _insertView.backgroundColor = [UIColor orangeColor];
    //    _insertView.alpha = 0.25;
    _insertView.alpha = 0;
    _insertView.userInteractionEnabled = YES;
    [_finalView addSubview:_insertView];
    //蘭氣隨風
    _yi = [[UILabel alloc] init];
    _yi.textColor = [YZUnit colorWithHexValue:0xf2f2f2 alpha:1];
    _yi.font = [UIFont fontWithName:kSystemFontName size:64.0f];
    _yi.text = @"一";
    _yi.numberOfLines = 0;
    [_yi sizeToFit];
    
    _yi.mj_origin = CGPointMake(_finalView.width * 0.3, _finalView.height * 0.2);
    [_finalView addSubview:_yi];
    _yi.alpha = 0;
    
    _nian = [[UILabel alloc] init];
    _nian.textColor = [YZUnit colorWithHexValue:0xf2f2f2 alpha:1];
    _nian.font = [UIFont fontWithName:kSystemFontName size:64.0f];
    _nian.text = @"念";
    _nian.numberOfLines = 0;
    [_nian sizeToFit];
    
    _nian.mj_origin = CGPointMake(_finalView.width * 0.3, _finalView.height * 0.3);
    [_finalView addSubview:_nian];
    _nian.alpha = 0;
    
    _qing = [[UILabel alloc] init];
    _qing.textColor = [YZUnit colorWithHexValue:0xf2f2f2 alpha:1];
    _qing.font = [UIFont fontWithName:kSystemFontName size:64.0f];
    _qing.text = @"倾";
    _qing.numberOfLines = 0;
    [_qing sizeToFit];
    
    _qing.mj_origin = CGPointMake(_finalView.width * 0.6, _finalView.height * 0.4);
    [_finalView addSubview:_qing];
    _qing.alpha = 0;
    
    _cheng = [[UILabel alloc] init];
    _cheng.textColor = [YZUnit colorWithHexValue:0xf2f2f2 alpha:1];
    _cheng.font = [UIFont fontWithName:kSystemFontName size:64.0f];
    _cheng.text = @"城";
    _cheng.numberOfLines = 0;
    [_cheng sizeToFit];
    
    _cheng.mj_origin = CGPointMake(_finalView.width * 0.6, _finalView.height * 0.5);
    [_finalView addSubview:_cheng];
    _cheng.alpha = 0;
    
    _yinianView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_yi.frame) + margin, _yi.y + 4, 1, 0)];
    _yinianView.backgroundColor = [UIColor whiteColor];
    [_finalView addSubview:_yinianView];
    
    _qingchengView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_qing.frame) + margin, _qing.y, 1, 0)];
    _qingchengView.backgroundColor = [UIColor whiteColor];
    [_finalView addSubview:_qingchengView];
    
    [self handle];
}

- (void) handle {
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.finalView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.finalView addGestureRecognizer:recognizer];
    
    
}


- (void) startyinianqingchengAnimation {
    
    //    [UIView animateWithDuration:0.25 animations:^{
    //
    //
    //
    //    }];
    
    [UIView animateWithDuration:0.75 animations:^{
        _insertView.alpha = 0.2;
        _yi.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.75 animations:^{
            
            _nian.alpha = 1;
            
        }];
        
    }];
    
    [UIView animateWithDuration:1.5 animations:^{
        
        _yinianView.height = CGRectGetMaxY(_nian.frame) - _yi.y - 4;
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(secondyinianqingchengAnimation) withObject:nil afterDelay:0.5];
        
    }];
    
}

- (void) secondyinianqingchengAnimation{
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    [UIView animateWithDuration:0.75 animations:^{
        
        _qing.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.75 animations:^{
            
            _cheng.alpha = 1;
            
        }];
        
    }];
    
    [UIView animateWithDuration:1.5 animations:^{
        
        _qingchengView.height = CGRectGetMaxY(_cheng.frame) - _qing.y;
        
    }];
    
    //    });
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
//    DebugLog(@"%@" , NSStringFromCGPoint(scrollView.contentOffset));
    
    if(scrollView.contentOffset.x == k_SCREEN_WIDTH * 3) {
        
        if ([self.delegate respondsToSelector:@selector(jumpToMainPage:)]) {
            [self.delegate jumpToMainPage:self];
        }
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    //    DebugLog(@"%@" , NSStringFromCGPoint(scrollView.contentOffset));
    //    DebugLog(@"%f" , scrollView.contentOffset.x / k_SCREEN_WIDTH);
    
    NSInteger index = scrollView.contentOffset.x / k_SCREEN_WIDTH;
    
    if (index == 0) {
        
        _imageView1.alpha = 1.0f - scrollView.contentOffset.x / k_SCREEN_WIDTH;
        _imageView2.alpha = scrollView.contentOffset.x / k_SCREEN_WIDTH;
        _imageView3.alpha = 0;
        _imageView4.alpha = 0;
        
        //        _imageView1.transform = CGAffineTransformMakeScale(scrollView.contentOffset.x / k_SCREEN_WIDTH + 1, scrollView.contentOffset.x / k_SCREEN_WIDTH + 1);
        
        //        if (scrollView.contentOffset.x / k_SCREEN_WIDTH > 0.5) {
        
        //        _imageView2.transform = CGAffineTransformMakeScale(scrollView.contentOffset.x / k_SCREEN_WIDTH, scrollView.contentOffset.x / k_SCREEN_WIDTH);
        
        //        }
        
        
//        DebugLog(@"%f" , scrollView.contentOffset.x / k_SCREEN_WIDTH);
        
    } else if (index == 1) {
        
        _imageView1.alpha = 0;
        _imageView2.alpha = 1.0f - (scrollView.contentOffset.x / k_SCREEN_WIDTH - 1);
        _imageView3.alpha = scrollView.contentOffset.x / k_SCREEN_WIDTH - 1;
        _imageView4.alpha = 0;
        
        //        _imageView2.transform = CGAffineTransformMakeScale(scrollView.contentOffset.x / k_SCREEN_WIDTH, scrollView.contentOffset.x / k_SCREEN_WIDTH);
        
        //        _imageView3.transform = CGAffineTransformMakeScale(scrollView.contentOffset.x / k_SCREEN_WIDTH - 1, scrollView.contentOffset.x / k_SCREEN_WIDTH - 1);
        
//        DebugLog(@"%f" , scrollView.contentOffset.x / k_SCREEN_WIDTH - 1);
        
    } else if (index == 2) {
        
        _imageView1.alpha = 0;
        _imageView2.alpha = 0;
        _imageView3.alpha = 1.0f - (scrollView.contentOffset.x / k_SCREEN_WIDTH - 2);
        _imageView4.alpha = scrollView.contentOffset.x / k_SCREEN_WIDTH - 2;
        
        //        _imageView3.transform = CGAffineTransformMakeScale(scrollView.contentOffset.x / k_SCREEN_WIDTH - 1, scrollView.contentOffset.x / k_SCREEN_WIDTH - 1);
        
        //        _imageView4.transform = CGAffineTransformMakeScale(scrollView.contentOffset.x / k_SCREEN_WIDTH - 2, scrollView.contentOffset.x / k_SCREEN_WIDTH - 2);
        
//        DebugLog(@"%f" , scrollView.contentOffset.x / k_SCREEN_WIDTH - 2);
        
        if (scrollView.contentOffset.x / k_SCREEN_WIDTH - 2 < 0.3f) {
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(secondyinianqingchengAnimation) object:nil];
            
            [_finalView.layer removeAllAnimations];
            [_yi.layer removeAllAnimations];
            [_nian.layer removeAllAnimations];
            [_qing.layer removeAllAnimations];
            [_cheng.layer removeAllAnimations];
            [_yinianView.layer removeAllAnimations];
            [_qingchengView.layer removeAllAnimations];
            
            _yi.alpha = 0;
            _nian.alpha = 0;
            _qing.alpha = 0;
            _cheng.alpha = 0;
            _insertView.alpha = 0;
            
            _yinianView.height = 0;
            _qingchengView.height = 0;
            
        }
        
    } else if (index == 3) {
        
        _imageView1.alpha = 0;
        _imageView2.alpha = 0;
        _imageView3.alpha = 0;
        _imageView4.alpha = 1.0f - (scrollView.contentOffset.x / k_SCREEN_WIDTH - 3);
        
        //        if (_imageView4.alpha < 0.2) {
        //
        //            _insertView.alpha = _imageView4.alpha;
        //
        //        }
        
//        DebugLog(@"%f" , scrollView.contentOffset.x / k_SCREEN_WIDTH - 3);
        
    } else {
//        
//        DebugLog(@"fuck");
        
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / k_SCREEN_WIDTH;
    
    if (index == 3) {
        
        [self startyinianqingchengAnimation];
        
    }
    
}

- (void) configInedges {
    
    _imageView1 = [[UIImageView alloc] initWithFrame:self.view.frame];
    _imageView1.userInteractionEnabled = YES;
    _imageView1.alpha = 1;
    [_imageView1 setImage:[_imageArray firstObject]];
    [self.view addSubview:_imageView1];
    
    
    _totalView1 = [[UIView alloc] initWithFrame:self.view.frame];
    _totalView1.backgroundColor = [UIColor clearColor];
    UILabel * label1_1 = [[UILabel alloc] init];
    label1_1.textColor = RGB(60, 60, 60);
    label1_1.font = [UIFont fontWithName:kSystemFontName size:42.0f];
    label1_1.text = @"嘿~妹纸.";
    
    [label1_1 sizeToFit];
    label1_1.mj_origin = CGPointMake(k_SCREEN_WIDTH * 0.1, k_SCREEN_HEIGHT * 0.07);
    
    [_totalView1 addSubview:label1_1];
    
    UILabel * label1_2 = [[UILabel alloc] init];
    label1_2.textColor = RGB(60, 60, 60);
    label1_2.font = [UIFont fontWithName:kSystemFontName size:36.0f];
    label1_2.text = @"约吗?";
    
    [label1_2 sizeToFit];
    label1_2.mj_origin = CGPointMake(k_SCREEN_WIDTH * 0.45, k_SCREEN_HEIGHT * 0.2);
    
    [_totalView1 addSubview:label1_2];
    
    [_imageView1 addSubview:_totalView1];
    
    
    _imageView2 = [[UIImageView alloc] initWithFrame:self.view.frame];
    _imageView2.userInteractionEnabled = YES;
    _imageView2.alpha = 0;
    [_imageView2 setImage:[_imageArray objectAtIndex:1]];
    [self.view addSubview:_imageView2];
    
    _totalView2 = [[UIView alloc] initWithFrame:self.view.frame];
    _totalView2.backgroundColor = [UIColor clearColor];
    UILabel * label2_1 = [[UILabel alloc] init];
    label2_1.textColor = RGB(0, 0, 0);
    label2_1.font = [UIFont fontWithName:kSystemFontName size:42.0f];
    label2_1.text = @"嘿~大叔.";
//    label2_1.numberOfLines = label2_1.text.length;
    [label2_1 sizeToFit];
    label2_1.mj_origin = CGPointMake(k_SCREEN_WIDTH * 0.32, k_SCREEN_HEIGHT * 0.7);
    
    [_totalView2 addSubview:label2_1];
    
    UILabel * label2_2 = [[UILabel alloc] init];
    label2_2.textColor = RGB(0, 0, 0);
    label2_2.font = [UIFont fontWithName:kSystemFontName size:36.0f];
    label2_2.text = @"撩吗?";
//    label2_2.numberOfLines = label2_2.text.length;
    [label2_2 sizeToFit];
    label2_2.mj_origin = CGPointMake(k_SCREEN_WIDTH * 0.47, k_SCREEN_HEIGHT * 0.85);
    
    [_totalView2 addSubview:label2_2];
    
    [_imageView2 addSubview:_totalView2];
    
    _imageView3 = [[UIImageView alloc] initWithFrame:self.view.frame];
    _imageView3.userInteractionEnabled = YES;
    _imageView3.alpha = 0;
    [_imageView3 setImage:[_imageArray objectAtIndex:2]];
    [self.view addSubview:_imageView3];
    
    
    _totalView3 = [[UIView alloc] initWithFrame:self.view.frame];
    _totalView3.backgroundColor = [UIColor clearColor];
    UILabel * label3_1 = [[UILabel alloc] init];
    label3_1.textColor = RGB(0, 0, 0);
    label3_1.font = [UIFont fontWithName:kSystemFontName size:42.0f];
    label3_1.text = @"听说你喜欢我~";
//    label3_1.numberOfLines = label3_1.text.length;
    [label3_1 sizeToFit];
    label3_1.mj_origin = CGPointMake(k_SCREEN_WIDTH * 0.17, k_SCREEN_HEIGHT * 0.2);
    
    [_totalView3 addSubview:label3_1];
    
    UILabel * label3_2 = [[UILabel alloc] init];
    label3_2.textColor = RGB(0, 0, 0);
    label3_2.font = [UIFont fontWithName:kSystemFontName size:36.0f];
    label3_2.text = @"那就告诉我啊笨蛋";
//    label3_2.numberOfLines = label3_2.text.length;
    [label3_2 sizeToFit];
    label3_2.mj_origin = CGPointMake(k_SCREEN_WIDTH * 0.17, k_SCREEN_HEIGHT * 0.85);
    
    [_totalView3 addSubview:label3_2];
    
    [_imageView3 addSubview:_totalView3];
    
    _imageView4 = [[UIImageView alloc] initWithFrame:self.view.frame];
    _imageView4.userInteractionEnabled = YES;
    _imageView4.alpha = 0;
    [_imageView4 setImage:[_imageArray lastObject]];
    [self.view addSubview:_imageView4];
    
    
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
    
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
