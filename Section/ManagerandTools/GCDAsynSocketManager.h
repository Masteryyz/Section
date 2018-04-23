//
//  GCDAsynSocketManager.h
//  Section
//
//  Created by QZL on 2017/9/28.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^returnBlock)(NSData * data);
typedef void(^errorBlock)(NSError * error);

@interface GCDAsynSocketManager : NSObject

@property (nonatomic, strong) GCDAsyncSocket * socket;

@property (nonatomic, copy) returnBlock returnBlock;
@property (nonatomic, copy) errorBlock errorBlock;

+ (GCDAsynSocketManager *)shareManager;

- (void) socket_connetToServiceHostWithJsonData:(NSData *)jsonData andConnetBlock:(returnBlock)returnBlock hasError:(errorBlock)errorBlock;

- (void) socket_disConnet;

@end
