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

//typedef NS_ENUM(NSInteger, KZoneRequestResult) {
//    KZoneRequestFailure = 0,
//    KZoneRequestSuccess,
//};

@interface QZLNetworkManger : NSObject

@property (nonatomic, strong) NSMutableArray * reqArray;
@property (nonatomic, copy) NSString * currentRequestID;
@property (nonatomic, strong) NSOperationQueue * queue;

@property (nonatomic, copy) NetworkResponse responseBlock;

/**
 发送扫描信息
 */
+ (void)signups_newApply:(NSDictionary *)rArgument responseResult:(QZLRequestBlock)resultBlock;

+ (QZLNetworkManger *)shareManager;

+ (NSDictionary *) analyticalData:(NSData *)data ;


@end


