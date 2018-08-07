//
//  YZStatisticsModel.h
//  Section
//
//  Created by QZL on 2018/6/14.
//  Copyright © 2018年 WTF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZStatisticsModel : NSObject

//场次数据和节次数据
@property (nonatomic, copy) NSString * playerID;//球员ID
@property (nonatomic, copy) NSString * playerNumber;//球员号码
@property (nonatomic, copy) NSString * teamID;//队伍ID
@property (nonatomic, copy) NSString * matchID;//比赛ID
@property (nonatomic, copy) NSString * teamType;//队伍主客队
@property (nonatomic, copy) NSString * stage;//节次

//暂停
@property (nonatomic, copy) NSString * Timeout;

//得分数据

@property (nonatomic, copy) NSString * OnePoints;//一分
@property (nonatomic, copy) NSString * OnePointsHit;//一分命中

@property (nonatomic, copy) NSString * TwoPoints;//两分
@property (nonatomic, copy) NSString * TwoPointsHit;//两份命中

@property (nonatomic, copy) NSString * ThreePoints;//三分
@property (nonatomic, copy) NSString * ThreePointsHit;//三分命中

@property (nonatomic, copy) NSString * FreeThrow;//罚篮
@property (nonatomic, copy) NSString * FreeThrowHit;//罚篮命中

//篮板数据
@property (nonatomic, copy) NSString * OffensiveRebound;//进攻篮板
@property (nonatomic, copy) NSString * DefensiveRebound;//防守篮板

//抢断数据
@property (nonatomic, copy) NSString * Steals;

//失误
@property (nonatomic, copy) NSString * Turnover;
//盖帽
@property (nonatomic, copy) NSString * BlockShots;
//助攻
@property (nonatomic, copy) NSString * Assists;
//犯规数据
@property (nonatomic, copy) NSString * FoulsSum;// 总犯规次数
@property (nonatomic, copy) NSString * Fouls; // 犯规
@property (nonatomic, copy) NSString * TechnologyFouls;// 技术犯规+1
@property (nonatomic, copy) NSString * AgainstBodyFouls;// 违体犯规+1
@property (nonatomic, copy) NSString * PowerFouls;// 夺权犯规+1

@end
