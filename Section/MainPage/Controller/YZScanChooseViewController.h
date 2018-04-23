//
//  YZScanChooseViewController.h
//  Section
//
//  Created by QZL on 2018/4/2.
//  Copyright © 2018年 WTF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^chooseResult)(NSArray <NSString *>* strArray);

@interface YZScanChooseViewController : UIViewController

@property (nonatomic, strong) UIImage * image ;
@property (nonatomic, strong) NSArray * scanResult ;

@property (nonatomic, copy) chooseResult returnBlock;

@end
