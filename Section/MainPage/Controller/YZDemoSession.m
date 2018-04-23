//
//  YZDemoSession.m
//  Section
//
//  Created by QZL on 2017/10/9.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "YZDemoSession.h"

@interface YZDemoSession ()

@property (nonatomic, assign) NSInteger failCount;

@end

static YZDemoSession * managerInstance = nil;

@implementation YZDemoSession

+ (YZDemoSession *)shareManager {
    return [[self alloc]init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (managerInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            managerInstance = [super allocWithZone:zone];
            [managerInstance addObserver:managerInstance forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        });
    }
    return managerInstance;
}

- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerInstance = [super init];
    });
    return managerInstance;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return managerInstance;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return managerInstance;
}

#pragma mark -- GET --

-(void)YZ_GET_RequestWith_URL:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters autoAboundLast:(BOOL)autoAbound successBlock:(successBlock)success FailBlock:(failBlock)fail;
{
    
    if (autoAbound || _isSeparate) {
        if (_task && _task.state == NSURLSessionTaskStateRunning) {
            [_task cancel];
        }
    }
    
    //获取相关的参数字典
    
    /*盛放参数的可变字符串*/
    NSMutableString *strM = [[NSMutableString alloc] init];
    
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *paramaterKey = key;
        NSString *paramaterValue = obj;
        //拼接参数
        [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
    }];
    
    urlString = [NSString stringWithFormat:@"%@?%@",urlString,strM];
    urlString = [urlString substringToIndex:urlString.length - 1];
    
    /**
     
     http://60.219.169.5/app//request?body={"channel":"QZL","version":"1.0","sn":"fdb43f5e-2fd5-448b-9f06-198a9b726f3b","params":{},"service":"goods","method":"getHomeType"}
     
     http://60.219.169.5/app/request?body={"sn":"B48B3D3E-F796-4830-A2A0-40F5669F0C83","method":"getHomeType","channel":"ios","params":"","service":"goods","version":"0.0.1"}
     
     http://60.219.169.5/app/request?body={"sn":"B08601F9-D1F7-42A0-AC91-FFAC5E286A93","method":"getHomeType","channel":"ios","params":{},"service":"goods","version":"0.0.1"}
     
     */
    
    NSCharacterSet * charaSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:charaSet];
    
    NSLog(@"%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    
    //发送网络请求
    
    _task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        // 网络请求成功:
        if (data && !error) {
            // JSON 解析.
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            if (!object) {
                object = data;
            }
            // 成功回调
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (success) {
                    success(object,response);
                }
            });
            
        } else {//失败
            
            // 失败回调
            if (fail) {
                fail(response,error);
            }
            
        }
        
    }];
    
    [_task resume];
    
}

#pragma mark -- POST --

-(void)YZ_POST_RequestWith_URL:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters autoAboundLast:(BOOL)autoAbound successBlock:(successBlock)success FailBlock:(failBlock)fail
{
    
    if (autoAbound || _isSeparate) {
        if (_task && _task.state == NSURLSessionTaskStateRunning) {
            [_task cancel];
        }
    }
    
    //获取相关的参数字典
    
    /*盛放参数的可变字符串*/
    NSMutableString *strM = [[NSMutableString alloc] init];
    
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *paramaterKey = key;
        NSString *paramaterValue = obj;
        
        //拼接参数
        [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
    }];
    
    NSString *body = [strM substringToIndex:strM.length - 1];
    
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:paramaters options:NSJSONWritingPrettyPrinted error:nil];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    
    //设置请求方法POST
    request.HTTPMethod = @"POST";
    
    //设置请求体--来自于Data
    request.HTTPBody = bodyData;
    
    //发送网络请求
    
    _task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        // 网络请求成功:
        if (data && !error) {
            // JSON 解析.
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            if (!object) {
                object = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
            // 成功回调
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (success) {
                    success(object,response);
                }
            });
            
        } else {//失败
            
            // 失败回调
            if (fail) {
                fail(response,error);
            }
            
            
        }
        
    }];
    
    [_task resume];
    
}

- (NSString *)creatUUID {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (__bridge NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

- (NSString *) getVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appNewCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appNewCurVersion;
}

@end
