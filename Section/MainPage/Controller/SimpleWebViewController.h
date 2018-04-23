//
//  SimpleWebViewController.h
//  figone
//
//  Created by MBP on 15/5/28.
//  Copyright (c) 2015年 Uniqme. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MessionWebViewControllerDelegate <NSObject>

- (void)messionWebViewControllerDelegateWith:(UIViewController *)viewController;

@end

@interface SimpleWebViewController : UIViewController <UIWebViewDelegate>

@property BOOL isSource;

@property (nonatomic, assign) NSInteger webviewType;//1 我的打卡
@property (nonatomic, weak) id<MessionWebViewControllerDelegate> delegate;

- (instancetype)initWithUrlString:(NSString*)urlString;

@end
