//
//  NetworkManager.h
//  figone
//
//  Created by MBP on 15/5/20.
//  Copyright (c) 2015年 Uniqme. All rights reserved.
//
// 封装了AFNetworking的网络请求函数，主要添加了响应400时的错误处理
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef void (^AFNSuccessBlock)(id responseObject);
typedef void (^AFNFailedBlock)(NSError * error);

@interface NetworkManager : NSObject

// GET方法，在成功时执行success函数，当出现400错误时提示登录，当出现其他错误时执行failureExtra函数，并弹出错误提示（始终执行）
+ (void) get:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock;

// POST方法，在成功时执行success函数，当出现400错误时提示登录，当出现其他错误时执行failureExtra函数，并弹出错误提示（始终执行）
+ (void) post:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock;

// DELETE方法
+ (void) DELETE:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock;

+ (void) get:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController showError:(BOOL)showError successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock;

+ (void) post:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController showError:(BOOL)showError successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock;

@end
