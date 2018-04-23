//
//  CheckUpTableViewController.h
//  Section
//
//  Created by QZL on 2017/1/18.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlphaBlock)(CGFloat alpha);

@interface CheckUpTableViewController : UITableViewController

@property (nonatomic, copy) AlphaBlock alphaBlock;


@end
