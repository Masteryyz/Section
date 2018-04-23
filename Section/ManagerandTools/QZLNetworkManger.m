//
//  QZLNetworkManger.m
//  跆拳道QZL
//
//  Created by QianZhengLong on 16/6/13.
//  Copyright © 2016年 QianZhengLong. All rights reserved.
//

#import "QZLNetworkManger.h"
#import "SVProgressHUD.h"

static QZLNetworkManger * managerInstance = nil;

@interface QZLNetworkManger ()

@end

@implementation QZLNetworkManger

+ (NSDictionary *) analyticalData:(NSData *)data {
    
    NSDictionary * responseDictionary = [NSDictionary dictionary];
    NSArray * responseArray = [NSArray array];
    
    NSString * resStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    id jsonObj = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    
    if (appDelegate.isSecret) {
        
        jsonObj = [CrazyEncrypt AESStringDecrypt:resStr].mj_JSONObject;
        
    } else {
        
        jsonObj = resStr.mj_JSONObject;
        
    }
    
    if ([jsonObj isKindOfClass:[NSDictionary class]]) {
        
        responseDictionary = [NSDictionary dictionaryWithDictionary:(NSDictionary *)jsonObj];
        
    } else if ([jsonObj isKindOfClass:[NSArray class]]) {
        
        responseArray = [NSArray arrayWithArray:(NSArray *)jsonObj];
        
    }
    
    if (responseDictionary) {//请求有数据
        
        return responseDictionary;
        
    } else {//请求失败
        
        return nil;
        
    }
    
}

+ (void) startRequestWithParamas:(NSMutableDictionary *)dic andResponseResult:(QZLRequestBlock)resultBlock {
    
    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *myString =
    [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *pDic =
    [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    QZLRequest *request = [[QZLRequest alloc] initWithRUrl:Server_Host
                                                andRMethod:YTKRequestMethodGET
                                              andRArgument:pDic];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        resultBlock(request);
        
    } failure:^(YTKBaseRequest *request) {
        
        resultBlock(request);
        
    }];
    
}


/**
 发送扫描信息
 */
+ (void)signups_newApply:(NSDictionary *)rArgument responseResult:(QZLRequestBlock)resultBlock {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[@"channel"] = @"ios";
    dic[@"version"] = [self getVersion];
    dic[@"service"] = @"signups";
    dic[@"method"] = @"newApply";
    dic[@"params"] = rArgument;
    dic[@"sn"] = [self creatUUID];
    
    [QZLNetworkManger startRequestWithParamas:dic andResponseResult:resultBlock];
    
}


+ (NSString *) getVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appNewCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appNewCurVersion;
}


+ (NSString *)getIMEI {
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    BOOL result = [[df valueForKey:@"QZL_UUID_IS_FIRST_CREAT"] boolValue];
    if (result == NO) {
        NSString *uuid = [QZLNetworkManger creatUUID];
        [df setObject:uuid forKey:@"QZL_UUID"];
        [df setBool:YES forKey:@"QZL_UUID_IS_FIRST_CREAT"];
        [df synchronize];
        return uuid;
    } else {
        NSString *uuid = [df valueForKey:@"QZL_UUID"];
        return uuid;
    }
}

+ (NSString *)creatUUID {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (__bridge NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

//--------------------------------------------------------- Factory

+ (QZLNetworkManger *)shareManager {
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

@end

