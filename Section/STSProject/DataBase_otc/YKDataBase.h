//
//  YKDataBase.h
//  figone
//
//  Created by 姚彦兆 on 16/7/15.
//  Copyright © 2016年 Uniqme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseQueue.h"

@class YZTeamModel;
@class YZPlayerModel;
@class YZStatisticsModel;
@class YZVoiceModel;

/**
 表结构设计 -- -- -- [t_all]
 
 match(比赛) 表
 ----------------------------------------------------------------------------------------
 | [id] 主键 存储比赛的ID (matchID) |
 |
 */
static NSString * const matchID = @"matchID";

/**
 team(球队) 表
 ----------------------------------------------------------------------------------------
 | [id] 主键(matchID 比赛的ID) | [teamID] 球队ID (主队客队) | [teamType]标识主队客队 |
 |                           |                          |                     |
 */

static NSString * const teamID = @"teamID";
static NSString * const teamType = @"teamType";

/**
 player(球员) 表
 ----------------------------------------------------------------------------------------
 | [id] 主键 球员ID | [teamID] 球队ID | [matchID] 比赛ID | [isPlaying]是否上场 |
 |                |                 |                 |                    |
 
 */
static NSString * const playerID = @"playerID";

static NSString * const stage = @"stage";
/**
 statistics(统计) 表
 ----------------------------------------------------------------------------------------
 | [id] 主键 球员ID | [teamID] 球队ID | [matchID] 比赛ID | [stage] 节次标志位 | ~ [各项统计数据]
 |                 |                |                 |
 */

/**
 stage(节次表)
 
 */

static NSString * const playerID_First = @"playerID_First";
static NSString * const playerID_Second = @"playerID_Second";
static NSString * const voiceContent = @"voiceContent";
/**
 voice(语音) 表
 ----------------------------------------------------------------------------------------
 | [id] 主键 语音ID | [matchID] 比赛ID | [teamID] 球队ID | [stage] 节次标志位 | [content]语音内容 | [playerID_First] 行动球员ID | [playerID_Second] 被影响球员ID |
 |                 |                 |                |                  |                  |                           |                              |
 
 */


//new database ------------------------------------------------------------------------

static NSString * const t_match = @"t_match"; // 所有比赛表
static NSString * const t_team = @"t_team"; // 所有队伍
static NSString * const t_player = @"t_player"; // 所有球员表
static NSString * const t_statistics = @"t_statistics"; // 所有统计数据表
static NSString * const t_statistics_stageOne = @"t_statistics_stageOne"; // 所有统计数据表 第一节
static NSString * const t_statistics_stageTwo = @"t_statistics_stageTwo"; // 所有统计数据表 第二节
static NSString * const t_statistics_stageThree = @"t_statistics_stageThree"; // 所有统计数据表 第三节
static NSString * const t_statistics_stageFour = @"t_statistics_stageFour"; // 所有统计数据表 第四节
static NSString * const t_statistics_OverTime1 = @"t_statistics_OverTime1"; // 所有统计数据表 加时赛第一节
static NSString * const t_statistics_OverTime2 = @"t_statistics_OverTime2"; // 所有统计数据表 加时赛第二节
static NSString * const t_statistics_OverTime3 = @"t_statistics_OverTime3"; // 所有统计数据表 加时赛第三节
static NSString * const t_voice = @"t_voice"; // 所有语音命令表

//------------------------------------------------------------------------------------------------

//球队字段
static NSString * const teamCoach = @"teamCoach";
static NSString * const teamName = @"teamName";

//球员字段
static NSString * const birthday = @"birthday";
static NSString * const cardNo = @"cardNo";
static NSString * const career = @"career";
static NSString * const cb = @"cb";
static NSString * const ct = @"ct";
static NSString * const eb = @"eb";
static NSString * const et = @"et";
static NSString * const gender = @"gender";
static NSString * const height = @"height";
//static NSString * playerID = @"playerID";
static NSString * const injuries = @"injuries";
static NSString * const name = @"name";
static NSString * const pinyin = @"pinyin";
static NSString * const playerNumber = @"playerNumber";
static NSString * const positional = @"positional";
static NSString * const weight = @"weight";
static NSString * const isFirst = @"isFirst";
static NSString * const isPlaying = @"isPlaying";

//技术统计字段
// 各个技术统计项目对应的标记号（标记好对应的数据为该项目的统计数量）
static NSString * const Timeout = @"Timeout"; // 暂停
static NSString * const FreeThrow = @"FreeThrow"; // 罚篮
static NSString * const OnePoints = @"OnePoints"; // 一分
static NSString * const TwoPoints = @"TwoPoints"; // 两分
static NSString * const ThreePoints = @"ThreePoints"; // 三分
static NSString * const OffensiveRebound = @"OffensiveRebound"; // 进攻篮板
static NSString * const DefensiveRebound = @"DefensiveRebound"; // 防守篮板
static NSString * const Steals = @"Steals"; // 抢断
static NSString * const Turnover = @"Turnover"; // 失误
static NSString * const BlockShots = @"BlockShots"; // 盖帽
static NSString * const Assists = @"Assists"; // 助攻
static NSString * const FoulsSum = @"FoulsSum"; // 总犯规次数
static NSString * const Fouls = @"Fouls"; // 犯规
static NSString * const TechnologyFouls = @"TechnologyFouls"; // 技术犯规+1
static NSString * const AgainstBodyFouls = @"AgainstBodyFouls"; // 违体犯规+1
static NSString * const PowerFouls = @"PowerFouls"; // 夺权犯规+1

#define PlayerStatisticsArray @[Timeout, FreeThrow, OnePoints, TwoPoints, ThreePoints, OffensiveRebound, DefensiveRebound, Steals, Turnover, BlockShots, Assists, Fouls,TechnologyFouls,AgainstBodyFouls,PowerFouls]

static NSString * const FreeThrowHit = @"FreeThrowHit"; // 罚篮命中数
static NSString * const OnePointsHit = @"OnePointsHit"; // 一分命中数
static NSString * const TwoPointsHit = @"TwoPointsHit"; // 2分命中数
static NSString * const ThreePointsHit = @"ThreePointsHit"; // 3分命中数

// 第一节、第二节、第三节、第四节标记字符串
static NSString * const StageOne = @"StageOne";
static NSString * const StageTwo = @"StageTwo";
static NSString * const StageThree = @"StageThree";
static NSString * const StageFour = @"StageFour";
static NSString * const OverTime1 = @"OverTime1";
static NSString * const OverTime2 = @"OverTime2";
static NSString * const OverTime3 = @"OverTime3";

#define StageFourArray @[StageOne, StageTwo, StageThree, StageFour]
#define StageAllArray @[StageOne, StageTwo, StageThree, StageFour, OverTime1, OverTime2, OverTime3]

@interface YKDataBase : NSObject

@property (nonatomic, strong) FMDatabase * database;

@property (strong, nonatomic) NSString *databasePath;
@property (strong, nonatomic) NSString *_currentUserFolder;

@property (nonatomic, assign, getter=isExist) BOOL exist;

@property (nonatomic, strong) NSMutableArray * errorArray;

@property (nonatomic, strong) NSMutableArray * resultArray;
+ (YKDataBase *)sharedDBInstance;
//首次进入直接创建数据表
- (BOOL) create_DatabaseAndTable;


/**
 保存比赛信息 (比赛表)

 @param match_Dic 比赛ID
 */
- (void) saveMatchInfo:(NSDictionary*) match_Dic;

/**
 保存队伍信息

 @param Team_Info 队伍信息
 */
- (void) saveTeamInfo:(NSDictionary *) Team_Info ;

/**
 存储球员数据表

 @param playerList 球员数据
 */
- (void) savePlayerInfoWithObject:(NSArray <YZPlayerModel *>*)playerList;

/**
 初始化这场比赛的球员数据

 @param scoreData 球员数据列表
 */
- (void) InitializeScoreinMatch:(NSArray <YZStatisticsModel *>*)scoreData;


/**
 更新比赛中的球员的上场数据

 @param playerModel 球员数据模型
 */
- (void) updatePlayerData:(YZPlayerModel *)playerModel;

/**
 更新比赛中的球员得分数据

 @param scoreData 一条球员得分数据模型
 */
- (void) updateScoreData:(YZStatisticsModel*)scoreData;

/**
 更新语音数据表

 @param voiceModel 传Model.isDelete 插入/删除数据
 */
- (void) updateVoiceList:(YZVoiceModel *)voiceModel;

#pragma mark -- 继续比赛的所有操作 --

/**
 获取本场比赛所有球员所有节次的技统数据

 @param matchID 比赛ID
 @return 技统数据列表
 */
- (NSArray <YZStatisticsModel *>*) getScoreDataWithMatchID:(NSString *)matchID;


/**
 获取本场比赛所有球员指定节次的技统数据

 @param matchID 比赛ID
 @param stage 节次标志
 @return 技统数据列表
 */
- (NSArray <YZStatisticsModel *>*) getScoreDataWithMatchID:(NSString *)matchID stage:(NSString *)stage;

/**
 获取整场比赛所有的球员信息

 @param matchID 比赛ID
 @return 返回球员模型列表
 */
- (NSArray <YZPlayerModel*>*) getPlayerWithMatchID:(NSString *)matchID;

/**
 获取整场比赛所有的语音信息

 @param matchID 比赛ID
 @return 语音模型列表
 */
- (NSArray <YZVoiceModel*>*) getVoiceListWithMatchID:(NSString *)matchID;

-(int)open;
-(void)close;

//用户第一次下载应用或者更新版本直接载入数据持久化
- (BOOL) saveDiseasesList:(NSArray *)diseases ;
- (void) checkErrorArray;
//获取需要的列表内容
- (NSArray *) getDiseasesList;

//更新数据库的列表
- (BOOL) uploadDiseasesList:(NSArray *)newDiseaseList;

//删除数据库
- (BOOL) deleteDiseasesList;

@end
