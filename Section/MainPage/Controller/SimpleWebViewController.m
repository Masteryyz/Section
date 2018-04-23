//
//  SimpleWebViewController.m
//  figone
//
//  Created by MBP on 15/5/28.
//  Copyright (c) 2015年 Uniqme. All rights reserved.
//

#import "SimpleWebViewController.h"
#import "AppDelegate.h"
#import "MJRefresh.h"

@interface SimpleWebViewController ()

@property (strong, nonatomic) NSString* urlString;
@property (strong, nonatomic) UIViewController* webViewController;
@property BOOL isSelfLoad;
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIView * error404PageView;
@property (nonatomic, strong) UIButton * gobackBtn;

@property (nonatomic, strong)UIView *coverView;
@property (nonatomic, strong) UIButton * doMissionButton;
@end

@implementation SimpleWebViewController

- (instancetype)initWithUrlString:(NSString*)urlString {
    self = [super init];
    if (self){
        _urlString = urlString;
        _isSelfLoad = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 不设置translucent，上传图片返回后进入页面，会出现下方的黑色区域
//    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.title = @"球联客";
    
    UIWebView *webView = [[UIWebView alloc]
                          initWithFrame: CGRectMake(0,64,WIDTH, HEIGHT - 64)];
    
    if (!_urlString.length) {
        
        _urlString = @"http://qlk1.com/";
        
    }
    
    NSURL * url = [NSURL URLWithString:_urlString];
    webView.delegate = self;
    self.webView = webView;
    [self.view addSubview: _webView];
    
    [self.view addSubview:self.coverView];
    [webView loadRequest:[NSURLRequest
                          requestWithURL:url]];
    
    
    //设置返回按钮
    [self creatLeftItem];
    
}

- (void)creatLeftItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 44);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [button setImage:[UIImage imageNamed:@"backButtonImage"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"backButtonImage"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(webviewGoback) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)webviewGoback {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)refreshWebView {

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    [[YZBasicTabbarController shareinstancetype] hideTabbar];
    
//    self.fd_prefersNavigationBarHidden = YES;
    
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dismissControllerSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dismissControllerSuccessFailed" object:nil];
    
    [[YZBasicTabbarController shareinstancetype] showTabbar];
    
//    self.fd_prefersNavigationBarHidden = NO;
    
}

//-(void)videoStarted:(NSNotification *)notification{
//    // Entered Fullscreen code goes here..
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.fullScreenVideoIsPlaying = NO;
//}
//
//-(void)videoFinished:(NSNotification *)notification{
//    // Left fullscreen code goes here...
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.fullScreenVideoIsPlaying = NO;
//    
//    //CODE BELOW FORCES APP BACK TO PORTRAIT ORIENTATION ONCE YOU LEAVE VIDEO.
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
//    //present/dismiss viewcontroller in order to activate rotating.
//    //    UIViewController *mVC = [[UIViewController alloc] init];
//    //    [self presentViewController:mVC animated:NO completion:nil];
//    //    [self dismissViewControllerAnimated:NO completion:nil];
//}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

    if([self isViewLoaded] && self.view.window == nil)
    {
        self.view = nil;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.coverView removeFromSuperview];
    [self.webView.scrollView.mj_header endRefreshing];

    
    NSString *js_result = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('q')[0].value='朱祁林';"];
    
//    NSString *js = @"document.body.innerText";
        NSString *js = @"var testa = document.body.getElementsByClassName('header').innerHTML";
    NSString *pageSource = [webView stringByEvaluatingJavaScriptFromString:js];

        self.navigationItem.title = pageSource;
//    self.navigationItem.titleView = [Util naviagtionBarTitleWithString:theTitle];
    if ([[[self navigationController] viewControllers] lastObject] == self) {
        // 仅在当前页面是顶层页面，并完成加载动作时，停止loading动画
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    
    //根据请求截取网络状态
    NSHTTPURLResponse *response = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:webView.request returningResponse:&response error:nil];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.coverView removeFromSuperview];
    if ([[[self navigationController] viewControllers] lastObject] == self) {
        // 仅在当前页面是顶层页面，并完成加载动作时，停止loading动画
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    //    Error Domain=NSURLErrorDomain Code=-999 "(null)" UserInfo={NSErrorFailingURLStringKey=http://v.qq.com/iframe/player.html?vid=m0167zd8e6m&auto=0, NSErrorFailingURLKey=http://v.qq.com/iframe/player.html?vid=m0167zd8e6m&auto=0}
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    [self.webView.scrollView insertSubview:_error404PageView atIndex:0];
    _error404PageView.alpha = 0;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
//    if (_isSelfLoad == NO) {
//        NSString* urlString = [request.URL absoluteString];
//        if (![urlString isEqualToString:@""]) {
//            if (![urlString isEqualToString:@"about:blank"]) {
//                if ([urlString rangeOfString:@"qq.com"].location == NSNotFound) {
//                    self.urlString = urlString;
//                }
//            }
//        }
//        if ([Util isSameBaseUrl:_urlString otherUrl:urlString]) {
//            return YES;
//        }
//        if([Util isInframeUrl:urlString]){
//            return YES;
//        }
//        if(![Util isInternalUrl:urlString]) {
//            return YES;
//            //            SimpleWebViewController * webVC = [[SimpleWebViewController alloc]initWithUrlString:urlString];
//            //            webVC.isSource = NO;
//            //            [self.navigationController pushViewController:webVC animated:YES];
//        } else {
//            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//            // 根据不同内部url地址，push不同的vc
//            NSURL *url = [NSURL URLWithString:urlString];
//            if ([[url path] isEqualToString:@"/detail"]) {
//                NSString* pid = [Util getFromUrlString:urlString withKey:@"pid"];
//                DetailViewController *dvc = [[DetailViewController alloc]initWithPid:pid];
//                dvc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:dvc animated:YES];
//            }
//            return YES;
//            
//        }
//        return NO;
//    }
//    else {
//        _isSelfLoad = NO;
//        return YES;
//    }
    
    return YES;
}

#pragma mark - 打卡
//底部按钮通知
//- (void)changeButtonStatSuccess:(NSNotification *)notify {
//    if (self.doMissionButton) {
//        self.doMissionButton.userInteractionEnabled = NO;
//        [self.doMissionButton setTitle:@"正在获取任务信息" forState:UIControlStateNormal];
//        [self requestFromServerWithSuccess:^{
//            if (self.model.stat == 0) {
//                self.doMissionButton.userInteractionEnabled = YES;
//                [self.doMissionButton setTitle:@"点击去完成" forState:UIControlStateNormal];
//            } else if (self.model.stat == 1) {
//                self.doMissionButton.userInteractionEnabled = YES;
//                [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//            } else {
//                self.doMissionButton.userInteractionEnabled = YES;
//                [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//            }
//        }];
//    }
//}
//
//- (void)changeButtonStatFailed:(NSNotification *)notify {
//    if (self.doMissionButton) {
//        [self.doMissionButton setTitle:@"点击去完成" forState:UIControlStateNormal];
//    }
//}
////构建底部按钮
//- (void)createBottomButton {
//    UIImage *image = [UIImage imageNamed:@"invitateFriendsButton"];
//    CGFloat buttonHeight = image.size.height / (image.size.width / [Util getScreenWidth]);
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, [Util getScreenHeight] - 64 - buttonHeight, [Util getScreenWidth], buttonHeight);
//    [button setBackgroundColor:[MyConfig themeColor]];
//    [button setTitle:@"点击去完成" forState:UIControlStateNormal];
//    //设置"点击去完成"的字体大小 默认32
//    if (isRetina || iPhone5) {
//        [button.titleLabel setFont:[UIFont systemFontOfSize:32]];
//    } else if (iPhonePLUS) {
//        [button.titleLabel setFont:[UIFont systemFontOfSize:32 * kScreenProportion]];
//    } else if (iPhone6) {
//        [button.titleLabel setFont:[UIFont systemFontOfSize:32 * kScreenProportion6]];
//    }
//    [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
//    [button addTarget:self action:@selector(doMessionButtonPress) forControlEvents:UIControlEventTouchUpInside];
//    self.doMissionButton = button;
//    [self.view addSubview:self.doMissionButton];
//    [self.view bringSubviewToFront:self.doMissionButton];
//}
////点击去做任务按钮
//- (void)doMessionButtonPress {
//    if ([self.doMissionButton.titleLabel.text isEqualToString:@"任务进行中"]) {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务正在进行中, 请您详细阅读说明并按步骤去完成哦" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//        [alert show];
//    } else if ([self.doMissionButton.titleLabel.text isEqualToString:@"任务已完成"]) {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//        [alert show];
//    } else {
//        if ([self.delegate respondsToSelector:@selector(messionWebViewControllerDelegateWith:)]) {
//            [self.delegate messionWebViewControllerDelegateWith:self];
//        }
//        __weak typeof(self) weakSelf = self;
//        [AuthManager authInViewController:weakSelf success:^{
//            [self requestFromServerWithSuccess:^{
//                MessionModel * mession = self.model;
//                if (mession) {
//                    NSString * action = mession.action;
//                    NSLog(@"MISSION ACTION IS %@" , action);
//                    NSDictionary * userDic = [AuthManager getCurrentUser];
//                    NSString * userID = userDic[@"id"];
//                    if ([action isEqualToString:@"submit_profile"]) {//完善个人信息
//                        if (mession.stat == 0) {
//                            if ([AuthManager getCurrentUser] != nil) {
//                                EditUserInfoTableViewController *vc = [[EditUserInfoTableViewController alloc]init];
//                                vc.hidesBottomBarWhenPushed = YES;
//                                vc.userID = userID;
//                                [self.navigationController pushViewController:vc animated:YES];
//                            }
//                        } else if (mession.stat == 1) {
//                            [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务正在进行中, 请您详细阅读说明并按步骤去完成哦" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        } else if (mession.stat == 2) {
//                            [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                    } else if ([action isEqualToString:@"submit_cert"]) {//上传认证资料
//                        if (mession.stat == 0) {
//                            AuthenticationViewController *auVC = [[AuthenticationViewController alloc] init];
//                            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:auVC];
//                            [self presentViewController:naVC animated:YES completion:nil];
//                        } else if (mession.stat == 1) {
//                            [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//                            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"我们将于1~2个工作日完成审核,请您耐心等待" description:nil type:TWMessageBarMessageTypeInfo duration:1.0];
//                        } else if (mession.stat == 2) {
//                            [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                    } else if ([action isEqualToString:@"submit_image"]) {//上传病例
//                        if (self.model.stat == 0) {
//                            [self.navigationController popToRootViewControllerAnimated:YES];
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [[NSNotificationCenter defaultCenter] postNotificationName:@"backToMainPage" object:@"1"];
//                            });
//                        } else if (mession.stat == 1) {
//                            [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务正在进行中, 请您详细阅读说明并按步骤去完成哦" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        } else if (mession.stat == 2) {
//                            [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                    } else if ([action isEqualToString:@"submit_comment"]) {//发表评论
//                        
//                        if (self.model.stat == 0) {
//                            [self.tabBarController setSelectedIndex:0];
//                            [self.navigationController popToRootViewControllerAnimated:YES];
//
//                        } else if (mession.stat == 1) {
//                            [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务正在进行中, 请您详细阅读说明并按步骤去完成哦" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        } else if (mession.stat == 2) {
//                            [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                    } else if ([action isEqualToString:@"share"]) {//天天分享
//                        if (self.model.stat == 0) {
//                            [self.tabBarController setSelectedIndex:0];
//                            [self.navigationController popToRootViewControllerAnimated:YES];
//                        } else if (mession.stat == 1) {
//                            [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务正在进行中, 请您详细阅读说明并按步骤去完成哦" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        } else if (mession.stat == 2) {
//                            [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                    } else if ([action isEqualToString:@"invite_answer"]) {//邀请回答
//                        if (self.model.stat == 0) {
//                            [self.tabBarController setSelectedIndex:0];
//                            [self.navigationController popToRootViewControllerAnimated:YES];
//                        } else if (mession.stat == 1) {
//                            [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务正在进行中, 请您详细阅读说明并按步骤去完成哦" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        } else if (mession.stat == 2) {
//                            [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                    } else if ([action isEqualToString:@"favorite"]) {//收藏案例
//                        if (self.model.stat == 0) {
//                            [self.tabBarController setSelectedIndex:0];
//                            [self.navigationController popToRootViewControllerAnimated:YES];
//                        } else if (mession.stat == 1) {
//                            [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务正在进行中, 请您详细阅读说明并按步骤去完成哦" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        } else if (mession.stat == 2) {
//                            [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                    } else if ([action isEqualToString:@"contribute"]) {//病例挑战投稿
//                        if (self.model.stat == 0) {
//                            [self.tabBarController setSelectedIndex:0];
//                            [self.navigationController popToRootViewControllerAnimated:YES];
//                        } else if (mession.stat == 1) {
//                            [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务正在进行中, 请您详细阅读说明并按步骤去完成哦" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        } else if (mession.stat == 2) {
//                            [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                    } else if ([action isEqualToString:@"invite_friends"]) {//邀请好友注册
//                        if (self.model.stat == 0) {
//                            [self.tabBarController setSelectedIndex:0];
//                            [self.navigationController popToRootViewControllerAnimated:YES];
//                        } else if (mession.stat == 1) {
//                            [self.doMissionButton setTitle:@"任务进行中" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务正在进行中, 请您详细阅读说明并按步骤去完成哦" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        } else if (mession.stat == 2) {
//                            [self.doMissionButton setTitle:@"任务已完成" forState:UIControlStateNormal];
//                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任务已经完成啦! 去看看别的任务吧" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                    }
//                    
//                } else {
//                    NSLog(@"MISSION LOST");
//                    [Util showErrorNotice:@"获取任务信息失败"];
//                }
//            }];
//        } failure:^{
//            
//        }];
//    }
//}
//
//- (void)requestFromServerWithSuccess:(void(^)(void))success {
//    [NetworkManager get:[Util getFullUrlFrom:@"/activity/checkin"] parameters:nil inViewController:self showError:YES success:^(AFHTTPRequestOperation *request, id JSON) {
//        DLog(@"%@",JSON);
//        NSString *status = [JSON objectForKey:@"status"];
//        if (![status isEqualToString:@"fail"]) {
//            NSDictionary * dict = (NSDictionary *)JSON;
//            NSMutableArray * missionArray = [NSMutableArray array];
//            if (dict[@"missions"]) {
//                missionArray = [NSMutableArray arrayWithArray:dict[@"missions"]];
//            }
//            [missionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSDictionary * missionDetailDic = (NSDictionary *)obj;
//                if (missionDetailDic) {
//                    if ([missionDetailDic[@"action"] isEqualToString:self.model.action]) {
//                        self.model.stat = [missionDetailDic[@"stat"] integerValue];
//                    }
//                }
//            }];
//            success();
//        }
//    } failureExtra:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
//        [Util showErrorNotice:@"获取任务信息失败"];
//    }];
//}


@end
