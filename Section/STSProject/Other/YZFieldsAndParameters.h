//
//  YZFieldsAndParameters.h
//  Section
//
//  Created by QZL on 2018/6/14.
//  Copyright © 2018年 WTF. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef YZFieldsAndParameters_h
#define YZFieldsAndParameters_h
//static NSString * const My_UMeng_Appkey = @"598a7966c89576489d000cb8";
static NSString * const My_UMeng_Appkey = @"5acc2593a40fa367640000f6";

static NSString * const MicrophoneURLStr = @"App-Prefs:root=Privacy&path=MICROPHONE";

// 讯飞
static NSString * const IFLY_APPID_VALUE = @"599f8c84";

// 微信支付appId
static NSString * const WXAppId_Pay = @"wx3ce22732707ec63d";
// 微信支付商户号
static NSString * const WXPartnerId_Pay = @"1487563712";

// contact way
static NSString * const ContactUSContent = @"赛事组织及赛事技术统计合作请致电客服电话：400-631-3677";

// database set
static NSString * const TSDBName = @"TSDB.db";

static NSString * const VoiceTable = @"voice_table"; // 所有语音命令

static NSString * const PlayerTable = @"player_table"; // 每个球员单节操作信息
static NSString * const GameTable = @"game_table"; // 未提交节次
static NSString * const PlayerIdTable = @"playerId_table"; //球员主客队 Id
static NSString * const TSCheckTable = @"ts_check_table"; // 检录表（包括赛前检录、主队球员和客队球员信息

static NSString * const GameCheckID = @"game_check_id"; // 赛前检录数据id
static NSString * const TeamCheckID_H = @"team_check_id_h"; // 主队球员检录数据id
static NSString * const TeamCheckID_G = @"team_check_id_g"; // 客队球员检录数据id

static NSString * const GameIsFinished = @"isFinish";
static NSString * const GameIsSubmitAll = @"isSubmit";

// 用于查询比赛相关的所有数据（包括：全队犯规、暂停等）

static NSString * const GameId = @"gameId";

static NSString * const Voice = @"voice";

static NSString * const PlayerId = @"playerId";

static NSString * const GameStatus = @"gameStatus"; // 比赛是否结束
static NSString * const CurrentStage = @"currentStage";
static NSString * const CurrentStageDataSubmitted = @"currentStageDataSubmitted";
static NSString * const GameQuaretArr = @"gameQuaretArr";


static NSString * const BnfTeameType = @"<teamName>";
static NSString * const BnfTenNumberType = @"<tenNumber>";
static NSString * const BnfBitsNumberType = @"<bitsNumber>";
static NSString * const BnfTenNumberType2 = @"<tenNumber2>";
static NSString * const BnfBitsNumberType2 = @"<bitsNumber2>";
static NSString * const BnfBehaviorType = @"<behavior>";
static NSString * const BnfResultType = @"<result>";

static NSString * const NumbResultStr = @"NumbResultStr";
static NSString * const NumbResultStr2 = @"NumbResultStr2";
static NSString * const BehaviorNumb = @"behaviorNumb"; // 用于标记行为

//#define TS_SERVER_URL_TEST @"http://test2.qiuyouzone.com/statistics/request"//测试
#define TS_SERVER_URL_TEST @"http://bcbc.qiuyouzone.com/statistics/request"//正式

//语音技统数据库操作
/**
 *  DATABASE
 */
#import "YKDataBase.h"

#define dataBaseFileName @"YYJT.sqlite"

#define checkinFileName @"YYJT_check.sqlite"

#define scoreFileName @"YYJT_score.sqlite"

#define playerFileName @"YYJT_player.sqlite"

#endif /* YZFieldsAndParameters_h */
