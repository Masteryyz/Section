//
//  YZDemoSession.h
//  Section
//
//  Created by QZL on 2017/10/9.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 blockSet
*/
typedef void(^successBlock)(id re_object, NSURLResponse * response);

typedef void(^failBlock)(NSURLResponse * response, NSError * error);

@interface YZDemoSession : NSObject

//该实例中是否只存在一个请求
@property (nonatomic, assign) BOOL isSeparate;

/**
 task
 */
@property (nonatomic, strong) NSURLSessionDataTask * task;

/**
 blockAttribute
*/
@property (nonatomic, copy) successBlock success;
@property (nonatomic, copy) failBlock fail;


+ (YZDemoSession *)shareManager;

/**
 Get请求

 @param urlString Host
 @param paramaters 参数字典
 @param autoAbound 自动放弃之前的网络请求
 @param success 成功回调
 @param fail 失败回调
 */
-(void)YZ_GET_RequestWith_URL:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters autoAboundLast:(BOOL)autoAbound successBlock:(successBlock)success FailBlock:(failBlock)fail;


/**
 POST请求
 
 @param urlString Host
 @param paramaters 参数字典
 @param autoAbound 自动放弃之前的网络请求
 @param success 成功回调
 @param fail 失败回调
 */
-(void)YZ_POST_RequestWith_URL:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters autoAboundLast:(BOOL)autoAbound successBlock:(successBlock)success FailBlock:(failBlock)fail;

- (NSString *) getVersion;
- (NSString *)creatUUID;

@end
