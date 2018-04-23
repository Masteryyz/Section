//
//  YZMainPageViewController.m
//  Section
//
//  Created by QZL on 2017/2/20.
//  Copyright © 2017年 WTF. All rights reserved.
//

//我是赵飒

#import "YZMainPageViewController.h"
#import "CheckUpTableViewController.h"
#import "YZBlueToothServiceModel.h"
#import "UpSimpleHttpClient.h"
#import "UpYun.h"
#import "YZMainAvatarView.h"
#import "YZXIBView.h"
#import "YZFoolPageController.h"
#import "SimpleWebViewController.h"

#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <math.h>
#import <QN_GTM_Base64.h>
#import <AVFoundation/AVFoundation.h>

#import "GTMBase64.h"
#import "GTMDefines.h"
#import "UIImage+G8Filters.h"

#import "CrazyEncrypt.h"


#define gkey @"jklasfjlksdghsdsadsdwfgj"
#define gIv  @"jklasfjlksdghsdsadsdwfgj"

#define kCommonWidth  (WIDTH - H(20))

static NSString * cellidentifer = @"cellIDdwadwahdhlwahdluiwjoabfourhbnksbouicbilheuiowila8293178941728412";

@interface YZMainPageViewController () <

UIScrollViewDelegate,
UITextViewDelegate,
UITextFieldDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
G8TesseractDelegate


>

@property (nonatomic, strong) CADisplayLink * displayLink;

@property (nonatomic, strong) UIButton * button ;
@property (nonatomic, strong) UIButton * paperButton ;

@property (nonatomic, strong) UIButton * sendBtn ;
@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UIScrollView * mainScrollView;

@property (nonatomic, strong) UITextView * inputView;

@property (nonatomic, strong) UITextField * numberField ;
@property (nonatomic, strong) UITextField * nameField ;
@property (nonatomic, strong) UITextField * dateField ;
@property (nonatomic, strong) UITextField * signDateField ;

@property (nonatomic, strong) UIImage * resultImage ;
@property (nonatomic, strong) UIImageView * resultImageView ;


@property (nonatomic, strong) NSMutableArray * resultArray ;

@property (nonatomic, assign) BOOL isPaper ;


@end

@implementation YZMainPageViewController {
    
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
    
}

/**
 *  color enum
 
 78AFE7 -- 天蓝色
 AA8DE2 -- 中正紫
 98DBCF -- 淡绿
 D989C7 -- 玫瑰粉
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //    [[AipOcrService shardService] authWithAK:@"RVTMAs8Ph42BqrvKtZrVZkKu" andSK:@"ndu0Xi1WVHAjgu2z9VpymmGEGYCjW9d0"]; //__ YYZ
    //    [[AipOcrService shardService] authWithAK:@"9KVf9lcs3Gilf1TGFvx9bLT4" andSK:@"4QVfbXGusIqgeGklyEjbZgApREAZbjjz"]; //__ QY
    //
    //    [[AipOcrService shardService] authWithAK:@"y8MulB3ojLBXyQPKFte623lo" andSK:@"wvthCO3M672ShMcGOHyFUrgXIbufSdMZ"]; //__ ZH
    
    //    扫卡验证新版
    [[AipOcrService shardService] authWithAK:@"NuEo4LbD3WG3mbn1Lt4mbFtB" andSK:@"9eiEoCbpvSyP4OFGF0yyjeQRfa3YRoY0"]; //__ YYZ
    
    [self setUpUI];
    [self configCallback];
    
}

- (void)handleDisplayLink:(CADisplayLink *)dis {
    
    NSLog(@"%@" , dis);
    
}

- (void)clickMainButton:(id) sender{
    
    _isPaper = NO;
    
    __weak typeof(self) weakSelf = self;
    
    UIViewController * vc = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        [SVProgressHUD showWithStatus:@"正在识别"];
        
        _resultImage = image;
        [_resultImageView setImage:_resultImage];
        
        [[AipOcrService shardService] detectWebImageFromImage:image
                                                  withOptions:nil
                                               successHandler:_successHandler
                                                  failHandler:_failHandler];
    }];
    [self presentViewController:vc animated:YES completion:nil];
    
    //    UIViewController * vc = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
    //
    //        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    //        [SVProgressHUD showWithStatus:@"正在识别"];
    //
    //        _resultImage = image;
    //        [_resultImageView setImage:_resultImage];
    //
    //        NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
    //        [[AipOcrService shardService] detectTextAccurateBasicFromImage:image
    //                                                           withOptions:options
    //                                                        successHandler:_successHandler
    //                                                           failHandler:_failHandler];
    //
    //    }];
    //
    //
    //    [self presentViewController:vc animated:YES completion:nil];
    
    //    // 判断是否支持相机
    //    YZCustomCameraViewController * vc = [[YZCustomCameraViewController alloc] init];
    //    [self presentViewController:vc animated:YES completion:^{
    //
    //
    //    }];
    //
    //    vc.resultImageBlock = ^(UIImage *resultImage) {
    //
    //        _resultImage = resultImage;
    //        [_resultImageView setImage:_resultImage];
    //
    //        [self doOCRScanTheText];
    //
    //    };
    
    
}

- (void) clickPaperButton:(id) sender {
    
    _isPaper = YES;
    
    __weak typeof(self) weakSelf = self;
    
    UIViewController * vc = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        [SVProgressHUD showWithStatus:@"正在识别"];
        
        _resultImage = image;
        [_resultImageView setImage:_resultImage];
        
        [[AipOcrService shardService] detectWebImageFromImage:image
                                                  withOptions:nil
                                               successHandler:_successHandler
                                                  failHandler:_failHandler];
    }];
    [self presentViewController:vc animated:YES completion:nil];
    
}


- (void)configCallback {
    
    __weak typeof(self) weakSelf = self;
    
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        
        _resultArray = [NSMutableArray array];
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@", result);
        NSString *title = @"识别结果";
        NSMutableString *message = [NSMutableString string];
        
        if(result[@"words_result"]){
            if([result[@"words_result"] isKindOfClass:[NSDictionary class]]){
                [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    
                    [weakSelf.resultArray addObject:obj];
                    
                    //                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                    //                        [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
                    //                    }else{
                    //                        [message appendFormat:@"%@: %@\n", key, obj];
                    //                    }
                    
                }];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakSelf configTextField];
                    
                });
                
            }else if([result[@"words_result"] isKindOfClass:[NSArray class]]){
                for(NSDictionary *obj in result[@"words_result"]){
                    
                    [weakSelf.resultArray addObject:obj];
                    
                    //                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                    //                        [message appendFormat:@"%@\n", obj[@"words"]];
                    //                    }else{
                    //                        [message appendFormat:@"%@\n", obj];
                    //                    }
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakSelf configTextField];
                    
                });
            }
            
        }else{
            [message appendFormat:@"%@", result];
        }
        
    };
    
    _failHandler = ^(NSError *error){
        
        _resultArray = [NSMutableArray array];
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }];
    };
}


- (void) configTextField {
    
    if (_isPaper) {
        
        _signDateField.text = @"";
        _signDateField.placeholder = @"这里显示发证日期(纸质证书不显示)";
        
        if (_resultArray.count >= 6) {
            
            __block NSInteger NoIndex = -1;
            __block NSInteger NameIndex = -1;
            
            [_resultArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDictionary * dic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)obj];
                
                NSString * str = [NSString stringWithFormat:@"%@" , [dic valueForKey:@"words"]];
                
                if (
                    [str containsString:@"NO"] ||
                    [str containsString:@"No"] ||
                    [str containsString:@"no"] ||
                    [str containsString:@"nO"]
                    ) {
                    
                    NoIndex = idx;
                    
                }
                
                if ([str containsString:@"Name"]) {
                    
                    NameIndex = idx;
                    
                }
                
            }];
            
            if (NoIndex == -1 || NameIndex == -1) {
                
                //        [NSOrderedSame new];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [[[UIAlertView alloc] initWithTitle:@"错误" message:@"信息不足请重写识别" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    
                    
                }];
                
                return;
                
            } else {
                
                //处理编号情况
                if (_resultArray.count > NoIndex + 1) {
                    
                    NSDictionary * dic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[_resultArray objectAtIndex:(NoIndex + 1)]];
                    
                    NSString * tempStr = [NSString stringWithFormat:@"%@" , [dic valueForKey:@"words"]];
                    
                    tempStr = [tempStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                    tempStr = [tempStr stringByReplacingOccurrencesOfString:@":" withString:@""];
                    
                    _numberField.text = tempStr;
                    
                } else {
                    
                    [self showErrorWithLessMessage];
                    
                }
                
                //处理姓名情况
                if (_resultArray.count > NameIndex) {
                    
                    NSDictionary * dic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[_resultArray objectAtIndex:(NameIndex)]];
                    
                    NSString * tempStr = [NSString stringWithFormat:@"%@" , [dic valueForKey:@"words"]];
                    
                    if (tempStr.length >= 7) {//处理姓名在一行的情况
                        
                        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"Name" withString:@""];
                        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"name" withString:@""];
                        
                        _nameField.text = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                        
                        //处理生日情况
                        if (_resultArray.count > (NameIndex + 1)) {
                            
                            NSDictionary * dic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[_resultArray objectAtIndex:(NameIndex + 1)]];
                            
                            NSString * tempStr = [NSString stringWithFormat:@"%@" , [dic valueForKey:@"words"]];
                            
                            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
                            
                            tempStr = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                            
                            if (tempStr.length > 13) {
                                
                                tempStr = [tempStr substringFromIndex:tempStr.length - 13];
                                
                                tempStr = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                                
                                tempStr = [tempStr stringByReplacingOccurrencesOfString:@" " withString:@"_"];
                                
                                tempStr = [tempStr stringByReplacingOccurrencesOfString:@"." withString:@""];
                                
                                if (tempStr.length > 12) {
                                    
                                    _dateField.text = [tempStr substringFromIndex:tempStr.length - 12];
                                    
                                } else {
                                    
                                    _dateField.text = tempStr;
                                    
                                }
                                
                            } else {
                                [self showErrorWithLessMessage];
                            }
                            //                            tempStr
                            
                        } else {
                            
                            [self showErrorWithLessMessage];
                            
                        }
                        
                    } else { //处理姓名不在一行的情况
                        
                        if (_resultArray.count > NameIndex + 1) {
                            
                            NSDictionary * dic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[_resultArray objectAtIndex:(NameIndex + 1)]];
                            
                            NSString * tempStr = [NSString stringWithFormat:@"%@" , [dic valueForKey:@"words"]];
                            
                            _nameField.text = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                            
                            //处理生日情况
                            if (_resultArray.count > (NameIndex + 2)) {
                                
                                NSDictionary * dic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[_resultArray objectAtIndex:(NameIndex + 2)]];
                                
                                NSString * tempStr = [NSString stringWithFormat:@"%@" , [dic valueForKey:@"words"]];
                                
                                tempStr = [tempStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
                                
                                tempStr = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                                
                                if (tempStr.length > 12) {
                                    
                                    tempStr = [tempStr substringFromIndex:tempStr.length - 12];
                                    
                                    tempStr = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                                    
                                    tempStr = [tempStr stringByReplacingOccurrencesOfString:@" " withString:@"_"];
                                    
                                    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"." withString:@""];
                                    
                                    if (tempStr.length >= 11) {
                                        
                                        _dateField.text = [tempStr substringFromIndex:tempStr.length - 11];
                                        
                                    } else {
                                        
                                        _dateField.text = tempStr;
                                        
                                    }
                                    
                                } else {
                                    [self showErrorWithLessMessage];
                                }
                                //                            tempStr
                                
                            } else {
                                
                                [self showErrorWithLessMessage];
                                
                            }
                            
                        } else {
                            
                            [self showErrorWithLessMessage];
                            
                        }
                        
                    }
                    
                } else {
                    
                    [self showErrorWithLessMessage];
                    
                }
                
                
            }
            
        } else {
            
            [self showErrorWithLessMessage];
            
        }
        
    } else {
        
        if (_resultArray.count >= 7) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString * no_Str = [NSString stringWithFormat:@"%@" , [[_resultArray firstObject] valueForKey:@"words"]];
                [_numberField setText:[no_Str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                
                NSString * name_Str = [NSString stringWithFormat:@"%@" , [[_resultArray objectAtIndex:1] valueForKey:@"words"]];
                [_nameField setText:[name_Str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                
                NSString * date_Str = [NSString stringWithFormat:@"%@" , [[_resultArray objectAtIndex:2] valueForKey:@"words"]];
                
                date_Str = [date_Str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                if( date_Str.length > 12 )
                    date_Str = [date_Str substringFromIndex:date_Str.length - 12];
                
                date_Str = [date_Str stringByReplacingOccurrencesOfString:@"." withString:@"_"];
                date_Str = [date_Str stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                NSMutableString * date_Muta = [[NSMutableString alloc] initWithString:date_Str];
                if (date_Muta.length > 2) {
                    
                    [date_Muta insertString:@"_" atIndex:2];
                    
                    [_dateField setText:date_Muta];
                    
                } else {
                    
                    [self showErrorWithLessMessage];
                    
                }
                
                //配置发证日期
                NSString * signDate_Str = [NSString stringWithFormat:@"%@" , [[_resultArray objectAtIndex:6] valueForKey:@"words"]];
                signDate_Str = [signDate_Str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                if (signDate_Str.length >= 12) {
                    
                    signDate_Str = [signDate_Str stringByReplacingOccurrencesOfString:@"." withString:@""];
                    signDate_Str = [signDate_Str stringByReplacingOccurrencesOfString:@"," withString:@""];
                    signDate_Str = [signDate_Str stringByReplacingOccurrencesOfString:@" " withString:@"_"];
                    
                    [_signDateField setText:[signDate_Str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                    
                } else {
                    
                    [self showErrorWithLessMessage];
                    
                }
                
            });
            
        } else {
            
            [self showErrorWithLessMessage];
            
        }
        
    }
    
}

- (void) showErrorWithLessMessage {
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"信息不足请重写识别" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _numberField.text = @"";
        _numberField.placeholder = @"这里显示卡片序列号";
        
        _nameField.text = @"";
        _nameField.placeholder = @"这里显示英文姓名";
        
        _dateField.text = @"";
        _dateField.placeholder = @"这里显示日期";
        
        _signDateField.text = @"";
        _signDateField.placeholder = @"这里显示发证日期(纸质证书不显示)";
        
    });
    
    return;
    
}

- (void) sendtoService:(id) sender {
    
//    NSArray * array = @[
//                        @{
//                            @"birthday" : @"2005-01-15 00:00:00",
//                            @"englishName" : @"JIA XIAO CHEN",
//                            @"statiumName" : @"大粑粑",
//                            @"applyDan" : @"3"
//                            },
//
//                        @{
//                            @"birthday" : @"2005-01-15 00:00:00",
//                            @"englishName" : @"JIA XIAO CHEN",
//                            @"statiumName" : @"小粑粑",
//                            @"applyDan" : @"2"
//                            },
//
//                        @{
//                            @"birthday" : @"2005-01-15 00:00:00",
//                            @"englishName" : @"JIA XIAO CHEN",
//                            @"statiumName" : @"哎呦喂",
//                            @"applyDan" : @"1"
//                            }
//                        ];
//
//    YZCustomCameraViewController * vc = [[YZCustomCameraViewController alloc] init];
//    vc.dataArray = [NSMutableArray arrayWithArray:array];
//    [self presentViewController:vc animated:YES completion:nil];
//    return;
    
    if (!_numberField.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入段位号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
    }
    
    if (!_nameField.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入英文姓名(大写)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
    }
    
    if (!_dateField.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入生日(DD_MM_YYYY)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
    }
    
    NSDictionary * paramas;
    
    if (!_isPaper) {
        
        if (!_signDateField.text.length) {
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入发证日期(DD_MM_YYYY)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            return;
        }
        
        //卡片加个参数. 下发日期
        paramas = @{
                    
                    @"cardNo":[_numberField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    @"cname":[_nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    @"bir":[_dateField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    @"oldDanDate":[_signDateField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
                    };

        
    } else {
        
        paramas = @{
                    
                    @"cardNo":[_numberField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    @"cname":[_nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    @"bir":[_dateField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
                    
                    };

        
    }
    
    
    [SVProgressHUD showWithStatus:@"发送中..."];
    
    /**
     {
     entity =     {
     list =         (
     {
     applyDan = 1;
     birthday = "2005-01-15 00:00:00";
     certificateBirthday = "1995-12-09";
     certificateNum = 230602200501154425;
     ct = "2018-03-27 11:25:35";
     englishName = "JIA XIAO CHEN";
     et = "2018-03-27 11:25:35";
     flag = Y;
     id = dc44bedd836c430aad4c50b66eaf2fa7;
     nationality = CHINA;
     sex = 1;
     statiumName = "\U5929\U6d25\U5ddd\U6b63";
     userName = "\U674e\U660e\U54f2";
     }
     );
     };
     sn = "A6AFD555-A985-4593-802C-9DED7F3FF74C";
     success = 1;
     }
     */
    
    [QZLNetworkManger signups_newApply:paramas responseResult:^(YTKBaseRequest *request) {
        
        NSDictionary * responseJSONObject = [QZLNetworkManger analyticalData:request.responseData];
        
        if ([[responseJSONObject objectForKey:@"success"] intValue] == 1) {
            
             NSString * str = [NSString stringWithFormat:@"%@" , responseJSONObject[@"entity"][@"msg"]];
            
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showSuccessWithStatus:str];
            
//
//
//            NSLog(@"%@" , str);
            
//            NSArray * array = [NSArray arrayWithArray:(NSArray *)responseJSONObject[@"entity"][@"list"]];
//
//            YZCustomCameraViewController * vc = [[YZCustomCameraViewController alloc] init];
//            vc.dataArray = [NSMutableArray arrayWithArray:array];
//            [self presentViewController:vc animated:YES completion:nil];
            
//            [SVProgressHUD dismiss];
            
        } else {
            
            [SVProgressHUD dismiss];
            NSString * rea = responseJSONObject[@"entity"][@"reason"];
            if (rea) {
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:rea];
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
            }
        }
        
    }];
    
    
}


- (void)viewDidAppear:(BOOL)animated {
    
    [[YZBasicTabbarController shareinstancetype] showTabbar];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void) setUpUI {
    
    self.title = @"扫描界面";
    
    [self.navigationController.navigationBar setBackgroundImage:[YZUnit createImageWithColor:[YZUnit navigationBarThemeColor]] forBarMetrics:UIBarMetricsDefault];
    
    
    _bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //    _bgImageView.image = [[UIImage imageNamed:@"MainPageBG2"] imageBluredWithRadius:10.0 tintColor:nil saturationDeltaFactor:0.7 maskImage:nil];
    
    [self.view insertSubview:_bgImageView atIndex:0];
    
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.userInteractionEnabled = YES;
        _mainScrollView.delegate = self;
        
        _mainScrollView.scrollEnabled = YES;
        
        _mainScrollView.contentSize = CGSizeMake(0, HEIGHT);
    }
    [self.view addSubview:_mainScrollView];
    
    
    _resultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, H(300), H(189))];
    _resultImageView.userInteractionEnabled = YES;
    
    _resultImageView.layer.borderColor = [UIColor colorWithHexValue:0x78AFE7 alpha:1].CGColor;
    _resultImageView.layer.cornerRadius = H(4);
    _resultImageView.layer.borderWidth = 2;
    _resultImageView.layer.masksToBounds = YES;
    
    _resultImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.mainScrollView addSubview:_resultImageView];
    
    _resultImageView.centerX = _mainScrollView.width / 2;
    _resultImageView.y = H(20);
    
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, WIDTH / 2 - H(20), H(30));
    [_button setTitle:@"扫描卡片" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithHexValue:0xD989C7 alpha:1] forState:UIControlStateNormal];
    [_button.titleLabel setFont:[UIFont systemFontOfSize:H(12)]];
    _button.center = self.mainScrollView.center;
    
    _button.layer.borderColor = [UIColor colorWithHexValue:0xD989C7 alpha:1].CGColor;
    _button.layer.cornerRadius = 4;
    _button.layer.borderWidth = 1;
    
    [_button addTarget:self action:@selector(clickMainButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _button.y = _mainScrollView.height - H(0) - H(50) - H(100);
    _button.centerX = WIDTH / 4;
    
    [self.mainScrollView addSubview:_button];
    
    
    _paperButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _paperButton.frame = CGRectMake(0, 0, WIDTH / 2 - H(20), H(30));
    [_paperButton setTitle:@"扫描纸质证书" forState:UIControlStateNormal];
    [_paperButton setTitleColor:[UIColor colorWithHexValue:0xD989C7 alpha:1] forState:UIControlStateNormal];
    [_paperButton.titleLabel setFont:[UIFont systemFontOfSize:H(12)]];
    _paperButton.center = self.mainScrollView.center;
    
    _paperButton.layer.borderColor = [UIColor colorWithHexValue:0xD989C7 alpha:1].CGColor;
    _paperButton.layer.cornerRadius = 4;
    _paperButton.layer.borderWidth = 1;
    
    [_paperButton addTarget:self action:@selector(clickPaperButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _paperButton.y = _mainScrollView.height - H(0) - H(50) - H(100);
    _paperButton.centerX = (WIDTH / 4) * 3;
    
    [self.mainScrollView addSubview:_paperButton];
    
    
    _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendBtn.frame = CGRectMake(0, 0, WIDTH - H(20), H(30));
    [_sendBtn setTitle:@"点击认证" forState:UIControlStateNormal];
    [_sendBtn setTitleColor:[UIColor colorWithHexValue:0xD989C7 alpha:1] forState:UIControlStateNormal];
    [_sendBtn.titleLabel setFont:[UIFont systemFontOfSize:H(12)]];
    _sendBtn.center = self.mainScrollView.center;
    _sendBtn.y = _mainScrollView.height - H(0) - H(100);
    
    _sendBtn.layer.borderColor = [UIColor colorWithHexValue:0xD989C7 alpha:1].CGColor;
    _sendBtn.layer.cornerRadius = 4;
    _sendBtn.layer.borderWidth = 1;
    
    [_sendBtn addTarget:self action:@selector(sendtoService:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainScrollView addSubview:_sendBtn];
    
    //    _inputView = [[UITextView alloc] initWithFrame:CGRectMake(0, H(20), kCommonWidth, H(200))];
    //    _inputView.textAlignment = NSTextAlignmentLeft;
    //    _inputView.font = [UIFont systemFontOfSize:H(13)];
    //    //    _inputView.backgroundColor = [UIColor colorWithHexValue:0xfafafa alpha:1];
    //    _inputView.backgroundColor = [UIColor colorWithHexValue:0xffffff alpha:1];
    //
    //    _inputView.layer.borderWidth = 2;
    //    _inputView.layer.cornerRadius = H(3);
    //    _inputView.layer.borderColor = [UIColor colorWithHexValue:0x78AFE7 alpha:1].CGColor;
    //    _inputView.layer.masksToBounds = YES;
    //
    //    _inputView.delegate = self;
    //    _inputView.centerX = _mainScrollView.width / 2;
    //    [_mainScrollView addSubview:_inputView];
    
    _numberField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kCommonWidth, H(30))];
    _numberField.textAlignment = NSTextAlignmentLeft;
    _numberField.font = [UIFont systemFontOfSize:H(11)];
    _numberField.placeholder = @"这里显示卡片序列号";
    _numberField.textColor = [UIColor blackColor];
    
    _numberField.layer.borderWidth = 2;
    _numberField.layer.cornerRadius = H(3);
    _numberField.layer.borderColor = [UIColor colorWithHexValue:0x98DBCF alpha:1].CGColor;
    _numberField.layer.masksToBounds = YES;
    
    //    _numberField.delegate = self;
    _numberField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, H(10), 1)];
    _numberField.leftViewMode = UITextFieldViewModeAlways;
    [_mainScrollView addSubview:_numberField];
    
    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kCommonWidth, H(30))];
    _nameField.textAlignment = NSTextAlignmentLeft;
    _nameField.font = [UIFont systemFontOfSize:H(11)];
    _nameField.placeholder = @"这里显示英文姓名";
    _nameField.textColor = [UIColor blackColor];
    
    _nameField.layer.borderWidth = 2;
    _nameField.layer.cornerRadius = H(3);
    _nameField.layer.borderColor = [UIColor colorWithHexValue:0x98DBCF alpha:1].CGColor;
    _nameField.layer.masksToBounds = YES;
    
    //    _nameField.delegate = self;
    _nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, H(10), 1)];
    _nameField.leftViewMode = UITextFieldViewModeAlways;
    [_mainScrollView addSubview:_nameField];
    
    _dateField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kCommonWidth, H(30))];
    _dateField.textAlignment = NSTextAlignmentLeft;
    _dateField.font = [UIFont systemFontOfSize:H(11)];
    _dateField.placeholder = @"这里显示日期";
    _dateField.textColor = [UIColor blackColor];
    
    _dateField.layer.borderWidth = 2;
    _dateField.layer.cornerRadius = H(3);
    _dateField.layer.borderColor = [UIColor colorWithHexValue:0x98DBCF alpha:1].CGColor;
    _dateField.layer.masksToBounds = YES;
    
    //    _dateField.delegate = self;
    _dateField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, H(10), 1)];
    _dateField.leftViewMode = UITextFieldViewModeAlways;
    [_mainScrollView addSubview:_dateField];
    
    _nameField.center = _mainScrollView.center;
    
    _numberField.centerX = _nameField.centerX;
    _dateField.centerX = _nameField.centerX;
    
    _numberField.y = _nameField.y - H(20) - H(30);
    _dateField.y = CGRectGetMaxY(_nameField.frame) + H(20);
    
    
    _signDateField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kCommonWidth, H(30))];
    _signDateField.textAlignment = NSTextAlignmentLeft;
    _signDateField.font = [UIFont systemFontOfSize:H(11)];
    _signDateField.placeholder = @"这里显示发证日期(纸质证书不显示)";
    _signDateField.textColor = [UIColor blackColor];
    
    _signDateField.layer.borderWidth = 2;
    _signDateField.layer.cornerRadius = H(3);
    _signDateField.layer.borderColor = [UIColor colorWithHexValue:0x98DBCF alpha:1].CGColor;
    _signDateField.layer.masksToBounds = YES;
    
    //    _dateField.delegate = self;
    _signDateField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, H(10), 1)];
    _signDateField.leftViewMode = UITextFieldViewModeAlways;
    [_mainScrollView addSubview:_signDateField];
    
    _signDateField.centerX = _mainScrollView.width / 2;
    _signDateField.y = CGRectGetMaxY(_dateField.frame) + H(20);
    
}

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end
