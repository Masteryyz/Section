//
//  CheckUpTableViewController.m
//  Section
//
//  Created by QZL on 2017/1/18.
//  Copyright © 2017年 WTF. All rights reserved.
//

/*
苍天细雨意随风,
筱筱红袖玉玲珑.
惦念昨日晴方好,
守得云开见月明.
*/

#import "CheckUpTableViewController.h"

#define kFlagPoint                              (k_SCREEN_WIDTH * 0.625)

@interface CheckUpTableViewController ()

@property (nonatomic, strong)UIImageView * avatorView;
@property (nonatomic, strong)UIImageView * avatorView_index;

@property (nonatomic, assign)CGFloat alphaMemory;

@property (nonatomic, assign)BOOL statusBarControl;
@end

@implementation CheckUpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.tintColor = [YZUnit colorWithHexValue:0xf2f2f2 alpha:1];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.tableHeaderView = [self setUptableViewHeaderView];
    
    UIView * titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.size = CGSizeMake(200, 34);
    _avatorView_index = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    _avatorView_index.center = self.navigationItem.titleView.center;
    _avatorView_index.image = [UIImage imageNamed:@"LoadingImage"];
    _avatorView_index.backgroundColor = [YZUnit colorWithHexValue:0xf2f2f2 alpha:1];
    _avatorView_index.alpha = 0;

    
    
    _avatorView_index.layer.borderWidth = 1;
    _avatorView_index.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _avatorView_index.layer.cornerRadius = 34 / 2;
    _avatorView_index.layer.masksToBounds = YES;
    
    [titleView addSubview:_avatorView_index];
    _avatorView_index.center = CGPointMake(titleView.width / 2, titleView.height / 2);
    
    self.navigationItem.titleView = titleView;
    
    [self.view addSubview:titleView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_alphaMemory];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    
    if (_alphaMemory == 0) {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    else {
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.alphaBlock) {
        self.alphaBlock(_alphaMemory);
    }
    
    if (_alphaMemory < 1) {
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_alphaMemory];
        [UIView animateWithDuration:0.15 animations:^{
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
                    [self.navigationController.navigationBar setBackgroundImage:[YZUnit createImageWithColor:[YZUnit navigationBarThemeColor]] forBarMetrics:UIBarMetricsDefault];
        }];
        
        [UIView animateWithDuration:0.11 animations:^{
            
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
            
        } completion:^(BOOL finished) {
            
            
            
        }];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {

    if (_statusBarControl)
        return UIStatusBarStyleDefault;
    else
        return UIStatusBarStyleLightContent;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    DebugLog(@"%@" , NSStringFromCGPoint(self.tableView.contentOffset));
    
    CGFloat offsetY = self.tableView.contentOffset.y;
    
    CGFloat scaleValue = 0;
    CGFloat navAlphaPoint =  117;
    
    if (offsetY > navAlphaPoint) {
        
        _statusBarControl = YES;
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
        self.avatorView.alpha = 0;
        _alphaMemory = 1;
        [UIView animateWithDuration:0.25 animations:^{
            
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
            self.avatorView_index.alpha = 1;
            
        }];
        
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
    }
    else if (offsetY <= navAlphaPoint) {
        
        _statusBarControl = NO;
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
        self.avatorView.alpha = 1;
        _alphaMemory = 0;
        [UIView animateWithDuration:0.25 animations:^{
            
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
            self.avatorView_index.alpha = 0;
            
        }];
        
        self.navigationController.navigationBar.tintColor = [YZUnit colorWithHexValue:0xf2f2f2 alpha:1];
        
    }
    
    if (offsetY > 0 && offsetY < navAlphaPoint) {
        
        scaleValue = 1 - offsetY / 175;
        
        self.avatorView.transform = CGAffineTransformMakeScale(scaleValue, scaleValue);
        
    }
    
    if(scaleValue > 80) {
        
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
        
    }
    
    //    self.avatorView.transform = CGAffineTransformMakeScale(<#CGFloat sx#>, <#CGFloat sy#>)
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
- (UIView *) setUptableViewHeaderView {
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_WIDTH * 0.625)];
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:view.frame];
    image.image = [UIImage imageNamed:@"titleBg"];
    
    [view addSubview:image];
    
    _avatorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH / 4, k_SCREEN_WIDTH / 4)];
    _avatorView.userInteractionEnabled = YES;
    _avatorView.backgroundColor = [YZUnit colorWithHexValue:0xf2f2f2 alpha:1];
    
    _avatorView.layer.borderWidth = 1;
    _avatorView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _avatorView.layer.cornerRadius = k_SCREEN_WIDTH / 8;
    _avatorView.layer.masksToBounds = YES;
    
    _avatorView.image = [UIImage imageNamed:@"LoadingImage"];
    [image addSubview:_avatorView];
    
    _avatorView.center = CGPointMake(image.centerX, image.centerY + 30);
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
    
    return view;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 60;
}
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 49;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * ID = [NSString stringWithFormat:@"cell%ld" , (long)indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld , %ld--- Cell" , (long)indexPath.section , (long)indexPath.row];
    cell.backgroundColor = [YZUnit randomColor];
    
    return cell;
}

@end
