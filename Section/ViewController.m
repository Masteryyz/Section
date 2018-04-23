//
//  ViewController.m
//  Section
//
//  Created by QZL on 2017/1/18.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "ViewController.h"
#import "CheckUpTableViewController.h"

//$(PRODUCT_NAME)

static NSString * ca = @"dadada";

@interface ViewController () <UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton * button ;

@property (nonatomic, assign) CGSize window_Size;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _window_Size = [[[UIApplication sharedApplication] delegate] window].frame.size;
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, 320, 40);
    _button.titleLabel.text = @"点击跳转TableView";
    
    _button.center = self.view.center;
    
    _button.layer.borderColor = [UIColor grayColor].CGColor;
    _button.layer.cornerRadius = 4;
    _button.layer.borderWidth = 1;
    
    [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button];
    
}

- (void) clickButton:(id) sender{

    CheckUpTableViewController * vc = [[CheckUpTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
