//
//  YZBasicTabbarController.m
//  Section
//
//  Created by QZL on 2017/2/20.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "YZBasicTabbarController.h"
#import "YZBasicNavigationController.h"
#import "YZMainPageViewController.h"
#import "YZFoundPageViewController.h"
#import "YZFriendPageViewController.h"
#import "YZMyPageViewController.h"
#import "YZTabbarAnimationView.h"
#import "YZTabbarButton.h"

@interface YZBasicTabbarController () <YZTabbarAnimationViewDelegate>

@property (nonatomic, strong) NSMutableArray * imageArray;
@property (nonatomic, strong) NSMutableArray * titleArray;

@property (nonatomic, assign) CGRect tabbarRect;

@property (nonatomic, strong) YZTabbarAnimationView * custabBar;

@property (nonatomic, assign) BOOL isHideTabbar;
@end

static YZBasicTabbarController * YZBasicTabbarControllerInstance = nil;

@implementation YZBasicTabbarController

- (void) hideTabbar {

    if (!_isHideTabbar) {
        
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:8.0 options:UIViewAnimationOptionTransitionNone animations:^{

            _custabBar.y += kTabbarHeight;
            
        } completion:^(BOOL finished) {

            _isHideTabbar = YES;
            
        }];
        
    }
    
}
- (void) showTabbar {
    
    if (_isHideTabbar) {
        
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:8.0 options:UIViewAnimationOptionTransitionNone animations:^{
            
            _custabBar.y -= kTabbarHeight;
            
        } completion:^(BOOL finished) {
            
            _isHideTabbar = NO;
            
        }];
        
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  data
     */
    NSDictionary * jsonData = @{
                                
                                @"titles" : @[@"主页" , @"发现" , @"好友" , @"我的"] ,
                                
                                @"images" : @[@"meet" , @"owl" , @"ps4-controller" , @"snowman"]
                                
                                };
    
    
    _titleArray = [NSMutableArray arrayWithArray:(NSArray *)[jsonData objectForKey:@"titles"]];
    _imageArray = [NSMutableArray arrayWithArray:(NSArray *)[jsonData objectForKey:@"images"]];


    _tabbarRect = self.tabBar.frame;
    if ([self.tabBar respondsToSelector:@selector(removeFromSuperview)]) {
        [self.tabBar removeFromSuperview];
    } else {
        NSAssert(YES, @"tabbar布局失败");
        return;
    }
    
    _custabBar = [[YZTabbarAnimationView alloc] initWithFrame:_tabbarRect andImageArray:_imageArray andTitleArray:_titleArray];
    _custabBar.animationType = YZTabbarAnimationViewTypeNone;
    _custabBar.delegate = self;
    [self.view addSubview:_custabBar];
    
    SimpleWebViewController * webview = [[SimpleWebViewController alloc] initWithUrlString:@"http://qlk1.com/"];
    
    YZBasicNavigationController *nav0 = [[YZBasicNavigationController alloc] initWithRootViewController:[[YZMainPageViewController alloc] init]];
//    YZBasicNavigationController *nav0 = [[YZBasicNavigationController alloc] initWithRootViewController:webview];
    [self addChildViewController:nav0];
    
    YZBasicNavigationController *nav1 = [[YZBasicNavigationController alloc] initWithRootViewController:[[YZFoundPageViewController alloc] init]];
    [self addChildViewController:nav1];
    
    YZBasicNavigationController *nav2 = [[YZBasicNavigationController alloc] initWithRootViewController:[[YZFriendPageViewController alloc] init]];
    [self addChildViewController:nav2];
    
    YZBasicNavigationController *nav3 = [[YZBasicNavigationController alloc] initWithRootViewController:[[YZMyPageViewController alloc] init]];
    [self addChildViewController:nav3];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)clickButton:(YZTabbarButton *)sender {
    
    self.selectedIndex = sender.index;
    
}

+ (YZBasicTabbarController *)shareinstancetype {
    return [[self alloc]init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (YZBasicTabbarControllerInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            YZBasicTabbarControllerInstance = [super allocWithZone:zone];
        });
    }
    return YZBasicTabbarControllerInstance;
}

- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YZBasicTabbarControllerInstance = [super init];
    });
    return YZBasicTabbarControllerInstance;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return YZBasicTabbarControllerInstance;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return YZBasicTabbarControllerInstance;
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
