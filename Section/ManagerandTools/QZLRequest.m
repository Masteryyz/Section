//
//  QZLRequest.m
//  跆拳道QZL
//
//  Created by QianZhengLong on 16/6/13.
//  Copyright © 2016年 QianZhengLong. All rights reserved.
//

#import "QZLRequest.h"

@interface QZLRequest ()

@property(nonatomic, strong) NSString *rURl;
@property YTKRequestMethod rMethod;
@property(nonatomic, strong) id rArgument;
@end


@implementation QZLRequest

- (instancetype)initWithRUrl:(NSString *)url
                  andRMethod:(YTKRequestMethod)method
                andRArgument:(id)argument {
    if (self = [super init]) {
        self.rURl = url;
        self.rMethod = YTKRequestMethodPOST;
        self.rArgument = argument;
    }
    return self;
}

#pragma mark--- 重载YTKRequest的一些设置方法

- (NSString *)requestUrl {
    return self.rURl;
}

- (YTKRequestMethod)requestMethod {
    return self.rMethod;
}

- (id)requestArgument {
    
    NSMutableDictionary * argDic = [[NSMutableDictionary alloc] init];
    NSArray * allKeys = [self.rArgument allKeys];
    for (NSString * key in allKeys) {
        [argDic setObject:[self.rArgument valueForKey:key] forKey:key];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    
    NSString * body = @"";
    
    if (appDelegate.isSecret) {
        
        body = [NSString stringWithFormat:@"%@",[self.rArgument valueForKey:@"body"]];
        body = [CrazyEncrypt AESStringEncrypt:body];
        
        argDic[@"secret"] = @"true";
        
    } else {
    
        body = [NSString stringWithFormat:@"%@",[self.rArgument valueForKey:@"body"]];
        
    }
    
    argDic[@"body"] = body;
    argDic[@"channel"] = @"ios";
    argDic[@"version"] = [QZLRequest getVersion];
    argDic[@"imei"] = [NSString stringWithFormat:@"ios%@",[QZLRequest getIMEI]];
    
    return argDic;
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
        NSString *uuid = [QZLRequest creatUUID];
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

@end
