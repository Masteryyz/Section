//
//  CrazyEncrypt.h
//  CrazyNetWork
//
//  Created by dukai on 16/4/28.
//  Copyright © 2016年 dukai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrazyEncrypt : NSObject

//字典加密
+(NSDictionary *)AESDictionaryEncrypt:(NSDictionary *)parameters;
//解析字典
+(NSDictionary *)AESDictionaryDecrypt:(NSString *)text;
//加密字符串
+(NSString *)AESStringEncrypt:(NSString *)text;
//解析字符串
+(NSString *)AESStringDecrypt:(NSString *)text;

@end
