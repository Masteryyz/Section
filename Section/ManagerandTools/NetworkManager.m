//
//  NetworkManager.m
//  figone
//
//  Created by MBP on 15/5/20.
//  Copyright (c) 2015年 Uniqme. All rights reserved.
//

#import "NetworkManager.h"


static AFHTTPSessionManager *afManager = nil;
//[AFHTTPSessionManager manager];

@implementation NetworkManager

+ (AFHTTPSessionManager*) getManager {
    if (afManager == nil) {
        afManager = [AFHTTPSessionManager manager];
    }
    return afManager;
}

+ (void) get:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock {

    [NetworkManager get:url parameters:params inViewController:viewController showError:YES successBlock:successBlock andFailedBlock:failedBlock];
    
}

+ (void) get:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController showError:(BOOL)showError successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock {
    AFHTTPSessionManager *manager = [NetworkManager getManager];

#warning message -- 忽略空值, 发布版本时候需要打开, 确保空数据不会引起解析器崩溃 --
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failedBlock) {
            failedBlock(error);
        }

        
    }];
    

}

+ (void) post:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock{
    
    [NetworkManager post:url parameters:params inViewController:viewController showError:YES successBlock:successBlock andFailedBlock:failedBlock];
}

+ (void) post:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController showError:(BOOL)showError successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock {
    
    AFHTTPSessionManager *manager = [NetworkManager getManager];
    
#warning message -- 此处注释需要特别研究, 别问我为什么 --
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
#warning message -- 忽略空值, 发布版本时候需要打开, 确保空数据不会引起解析器崩溃 --
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failedBlock) {
            failedBlock(error);
        }
        
    }];
    
}

+ (void) DELETE:(NSString*)url parameters:(NSDictionary*)params inViewController:(UIViewController*)viewController successBlock:(AFNSuccessBlock)successBlock andFailedBlock:(AFNFailedBlock)failedBlock{

    AFHTTPSessionManager *manager = [NetworkManager getManager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:[AuthManager getCookie] forHTTPHeaderField:@"X-CSRFToken"];
    
#warning message -- 忽略空值, 发布版本时候需要打开, 确保空数据不会引起解析器崩溃 --
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
    
    [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failedBlock) {
            failedBlock(error);
        }
        
    }];
    
}

@end
