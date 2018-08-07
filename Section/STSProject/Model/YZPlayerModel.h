//
//  YZPlayerModel.h
//  Section
//
//  Created by QZL on 2018/6/14.
//  Copyright © 2018年 WTF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZPlayerModel : NSObject

//确定比赛场次和球员所属队伍的属性
@property (nonatomic, copy) NSString * matchID;
@property (nonatomic, copy) NSString * teamID;
@property (nonatomic, copy) NSString * teamType;

// 一些自定义的需要保存的模型 -----------------------------------
/**
 是否首发
 */
@property (nonatomic, copy) NSString * isFirst;
/**
 是否上场
 */
@property (nonatomic, copy) NSString * isPlaying;

//----------------------------------------------------------------------

/**
 生日
 */
@property (nonatomic, copy) NSString * birthday;

/**
 号码
 */
@property (nonatomic, copy) NSString * cardNo;

/**
 生涯
 */
@property (nonatomic, copy) NSString * career;

@property (nonatomic, copy) NSString * cb;
@property (nonatomic, copy) NSString * ct;
@property (nonatomic, copy) NSString * eb;
@property (nonatomic, copy) NSString * et;

/**
 性别
 */
@property (nonatomic, copy) NSString * gender;

/**
 身高
 */
@property (nonatomic, copy) NSString * height;

/**
 球员ID
 */
@property (nonatomic, copy) NSString * playerID;

/**
 是否受伤
 */
@property (nonatomic, copy) NSString * injuries;

/**
 球员姓名
 */
@property (nonatomic, copy) NSString * name;

/**
 拼音
 */
@property (nonatomic, copy) NSString * pinyin;

/**
 注册时的球员号码
 */
@property (nonatomic, copy) NSString * playerNumber;

/**
 位置(前锋/中锋/后卫)
 */
@property (nonatomic, copy) NSString * positional;

/**
 体重
 */
@property (nonatomic, copy) NSString * weight;

@end
