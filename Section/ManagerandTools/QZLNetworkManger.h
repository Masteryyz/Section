//
//  QZLNetworkManger.h
//  跆拳道QZL
//
//  Created by QianZhengLong on 16/6/13.
//  Copyright © 2016年 QianZhengLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZLRequest.h"

typedef void (^QZLRequestBlock)(YTKBaseRequest *request);

typedef void(^NetworkResponse)(id responseObj);

typedef void (^Success)(id responseObject);
typedef void (^Failed)(NSError * error);

//typedef NS_ENUM(NSInteger, KZoneRequestResult) {
//    KZoneRequestFailure = 0,
//    KZoneRequestSuccess,
//};

@interface QZLNetworkManger : NSObject

@property (nonatomic, strong) NSMutableArray * reqArray;
@property (nonatomic, copy) NSString * currentRequestID;
@property (nonatomic, strong) NSOperationQueue * queue;

@property (nonatomic, copy) NetworkResponse responseBlock;

// ==================================================================================================================================

// ========================================================  语音技统接口  ============================================================

+ (void)amateurstatistic_saveMatchScore:(NSDictionary *)rArgument responseResult:(QZLRequestBlock)resultBlock;

+ (void)startLoginBCBC:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

+ (void)cbo_queryPlayByTeam:(NSDictionary *)rArgument responseSuccess:(Success)success responseFailed:(Failed)failed token:(NSString *)token;

// ==================================================================================================================================

+ (void)signups_Apply:(NSDictionary *)rArgument responseResult:(QZLRequestBlock)resultBlock;
/**
 发送扫描信息
 */
+ (void)signups_newApply:(NSDictionary *)rArgument responseResult:(QZLRequestBlock)resultBlock;

+ (QZLNetworkManger *)shareManager;

+ (NSDictionary *) analyticalData:(NSData *)data ;


@end


