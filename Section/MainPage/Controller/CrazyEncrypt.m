//
//  CrazyEncrypt.m
//  CrazyNetWork
//
//  Created by dukai on 16/4/28.
//  Copyright © 2016年 dukai. All rights reserved.
//

#import "CrazyEncrypt.h"
//#import "AES128.h"
#import "DES.h"

#define security_UrlKey @"Keys"
#define security_Key @"jklasfjlksdghsdsadsdwfgj"
#define security_iv @"01234567"

@implementation CrazyEncrypt

+(NSDictionary *)AESDictionaryEncrypt:(NSDictionary *)parameters{
    NSString *json = [CrazyEncrypt crazy_ObjectToJsonString:parameters];
    NSString *security_json = [DES  DESEncrypt:json key:security_Key iv:security_iv];
    parameters = @{security_UrlKey:security_json};
    
    return parameters;
}
+(NSDictionary *)AESDictionaryDecrypt:(NSString *)text{
    NSMutableString *str = [[NSMutableString alloc]initWithString:text];
    NSString * json = [DES  DESDecrypt:str key:security_Key iv:security_iv];
    return [CrazyEncrypt crazy_JsonStringToObject:json];
}

+(NSString *)AESStringEncrypt:(NSString *)text{
    return [DES  DESEncrypt:text key:security_Key iv:security_iv];
}
+(NSString *)AESStringDecrypt:(NSString *)text{
    NSMutableString *str = [[NSMutableString alloc]initWithString:text];
    return [DES  DESDecrypt:str key:security_Key iv:security_iv];
}

//字典或者数组 转换成json串
+(NSString *)crazy_ObjectToJsonString:(id)object{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:nil
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
    
}
//json串 转换成字典或者数组
+(id)crazy_JsonStringToObject:(NSString *)JsonString{
    JsonString = [JsonString stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    NSData *jsonData = [JsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id objc = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
    return objc;
}
@end
