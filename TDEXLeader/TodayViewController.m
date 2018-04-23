//
//  TodayViewController.m
//  TDEXLeader
//
//  Created by QZL on 2017/11/9.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) UIImageView * iconView ;
@property (nonatomic, strong) UILabel * nameLabel ;

@property (nonatomic, strong) UILabel * subTitleLabel;

@property (nonatomic, strong) UIButton * sureBtn;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUPUI];
    
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {

    return UIEdgeInsetsMake(0, 0, 0, 0);

}

- (void) setUPUI {

    if (!_iconView) {
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(12,12, 40, 40)];
        _iconView.image = [UIImage imageNamed:@"heihei.jpg"];
        
        _iconView.layer.cornerRadius = 20;
        _iconView.layer.masksToBounds = YES;
        
        _iconView.backgroundColor = [UIColor blueColor];
        
    }
    
    [self.view addSubview:_iconView];

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 40 + 12, 12, self.view.frame.size.width / 2, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor darkGrayColor];
        
        _nameLabel.text = @"绿水青山";
    }
    
    [self.view addSubview:_nameLabel];
    
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 40 + 12, 12 + 20, self.view.frame.size.width / 2, 20)];
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
        _subTitleLabel.textColor = [UIColor darkGrayColor];
        
        _subTitleLabel.text = @"风月白头";
    }
    
    [self.view addSubview:_subTitleLabel];
    
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(12, 12+40+12, self.view.frame.size.width *0.75, 30);
        [_sureBtn setTitle:@"抽   他!" forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_sureBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        _sureBtn.center = CGPointMake(self.view.frame.size.width / 2 , _sureBtn.frame.origin.y + 15);
    }
    
    [self.view addSubview:_sureBtn];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
