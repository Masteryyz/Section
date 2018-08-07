//
//  YZVoiceModel.h
//  Section
//
//  Created by QZL on 2018/6/19.
//  Copyright © 2018年 WTF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZVoiceModel : NSObject

@property (nonatomic, assign) BOOL isDelete ;

@property (nonatomic, copy) NSString * matchID;
@property (nonatomic, copy) NSString * teamID;
@property (nonatomic, copy) NSString * stage;
@property (nonatomic, copy) NSString * playerID;

/**
 语音字符串
 */
@property (nonatomic, copy) NSString * voiceContent;
@property (nonatomic, copy) NSString * playerID_First;
@property (nonatomic, copy) NSString * playerID_Second;

@end
