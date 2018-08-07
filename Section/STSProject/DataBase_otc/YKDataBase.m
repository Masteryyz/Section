//
//  YKDataBase.m
//  figone
//
//  Created by 姚彦兆 on 16/7/15.
//  Copyright © 2016年 Uniqme. All rights reserved.
//

#import "YKDataBase.h"
#import "YZTeamModel.h"
#import "YZPlayerModel.h"
#import "YZStatisticsModel.h"
#import "YZVoiceModel.h"

@interface YKDataBase ()

@end

@implementation YKDataBase

@synthesize databasePath;
@synthesize _currentUserFolder;

static YKDataBase * ykDatabaseInstance = nil;

- (BOOL) create_DatabaseAndTable {
    
    if ([self.database open])
    {
        //创建所有表 --
        NSLog(@"\n $$ - $$ \n $$ ---------------------------------------------- $$ \n $$ start loading data.. $$ \n $$ ALLTABLE $$ \n $$ YYJT.app $$ \n $$ -- developer yzyao -- $$ \n $$ ---------------------------------------------- $$");
        
        //                      比赛     队伍    队员     统计数据        语音
        //        NSArray * t_array = @[t_match,t_team,t_player,t_statistics,t_voice];
        
        //        NSString * sql_order_match = [NSString stringWithFormat:@"CREATE TABLE if not exists %@(id TEXT PRIMARY KEY, %@ TEXT, enabled BIT)" , t_match ,
        //                                      matchID
        //                                      ];
        NSString * sql_order_match = [NSString stringWithFormat:@"CREATE TABLE if not exists %@(id integer primary key autoincrement, %@ TEXT, enabled BIT)" , t_match ,
                                      matchID
                                      ];
        
        NSString * sql_order_team = [NSString stringWithFormat:@"CREATE TABLE if not exists %@(id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, enabled BIT)" , t_team ,
                                     matchID ,
                                     teamID ,
                                     teamType
                                     ];
        
        NSString * sql_order_player = [NSString stringWithFormat:@"CREATE TABLE if not exists %@(id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, enabled BIT)" , t_player ,
                                       playerID ,
                                       matchID,
                                       teamID ,
                                       teamType,
                                       cardNo,
                                       name,
                                       playerNumber,
                                       isPlaying,
                                       isFirst
                                       ];
        
        NSString * sql_order_statistics = [NSString stringWithFormat:@"CREATE TABLE if not exists %@(id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, enabled BIT)" , t_statistics ,
                                           playerID ,
                                           playerNumber ,
                                           matchID ,
                                           teamID ,
                                           teamType,
                                           stage ,
                                           Timeout ,
                                           
                                           FreeThrow ,
                                           FreeThrowHit ,
                                           
                                           OnePoints ,
                                           OnePointsHit,
                                           
                                           TwoPoints,
                                           TwoPointsHit,
                                           
                                           ThreePoints,
                                           ThreePointsHit,
                                           
                                           OffensiveRebound,
                                           DefensiveRebound,
                                           
                                           Steals,
                                           Turnover,
                                           BlockShots,
                                           Assists,
                                           
                                           FoulsSum,
                                           Fouls,
                                           TechnologyFouls,
                                           AgainstBodyFouls,
                                           PowerFouls
                                           ];
        
        NSString * sql_order_voice = [NSString stringWithFormat:@"CREATE TABLE if not exists %@(id integer primary key autoincrement, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, enabled BIT)" , t_voice ,
                                      matchID ,
                                      teamID ,
                                      voiceContent,
                                      playerID_First,
                                      playerID_Second,
                                      playerNumber,
                                      stage
                                      ];
        
        BOOL isCreated_t_match = [_database executeUpdate:sql_order_match];
        BOOL isCreated_t_team = [_database executeUpdate:sql_order_team];
        BOOL isCreated_t_player = [_database executeUpdate:sql_order_player];
        BOOL isCreated_t_statistics = [_database executeUpdate:sql_order_statistics];
        BOOL isCreated_t_voice = [_database executeUpdate:sql_order_voice];
        
        if (isCreated_t_match && isCreated_t_team && isCreated_t_player && isCreated_t_statistics && isCreated_t_voice) {
            NSLog(@" $$ create t_all success $$ ");
        } else {
            return -1;
            NSAssert(_database.lastErrorMessage, @" !! create t_diseases failed .. check the lastErrorMessage.. !!");
        }
        
    }
    
    return YES;
    
}
//存储比赛表
- (void) saveMatchInfo:(NSDictionary*) match_Dic {
    
    NSDate *startTime = [NSDate date];
    NSString * matchID = [NSString stringWithFormat:@"%@" , [match_Dic valueForKey:@"matchID"]];
    
    if ([_database open]) {
        
        [self.database beginTransaction];
        BOOL isRollBack = NO;
        @try{
            {
                BOOL insert = [_database executeUpdate:@"insert into t_match (matchID) values(?)",matchID];
                
                if (!insert) {
                    [_errorArray addObject:matchID];
                }
                
            }
            
            NSDate *endTime = [NSDate date];
            NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
            NSLog(@"使用事务处理了服务器的 %@ 条数据用时%.3f秒",@(1),a);
        }
        @catch (NSException *exception)
        {
            isRollBack = YES;
            [self.database rollback];
        }
        @finally
        {
            if (!isRollBack)
            {
                [self.database commit];
            }
        }
        
        //            [self.database close];
        
    }
    
}

//存储队伍表
- (void) saveTeamInfo:(NSDictionary *) Team_Info {
    
    if ([_database open]) {
        
        NSDate *startTime = [NSDate date];
        [self.database beginTransaction];
        BOOL isRollBack = NO;
        @try
        {
            
            NSString * matchID = [NSString stringWithFormat:@"%@" , [Team_Info objectForKey:@"matchID"]];
            NSString * teamID = [NSString stringWithFormat:@"%@" , [Team_Info objectForKey:@"teamID"]];
            NSString * teamType = [NSString stringWithFormat:@"%@" , [Team_Info objectForKey:@"teamType"]];
            
            BOOL insert = [_database executeUpdate:@"insert into t_team (matchID,teamID,teamType) values(?,?,?)",matchID,teamID,teamType];
            
            if (!insert) {
                [_errorArray addObject:Team_Info];
            }
            
            NSDate *endTime = [NSDate date];
            NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
            NSLog(@"使用事务处理了服务器的 %@ 条数据用时%.3f秒",@(1),a);
            
        }
        @catch (NSException *exception)
        {
            isRollBack = YES;
            [self.database rollback];
        }
        @finally
        {
            if (!isRollBack)
            {
                [self.database commit];
            }
        }
        
        //            [self.database close];
        
    }
    
}

//存储球员表
- (void) savePlayerInfoWithObject:(NSArray <YZPlayerModel *>*)playerList {
    
    if ([_database open]) {
        
        NSArray * array = [NSArray arrayWithArray:(NSArray *)playerList];
        NSDate *startTime = [NSDate date];
        [self.database beginTransaction];
        BOOL isRollBack = NO;
        @try
        {
            for (YZPlayerModel * item in array) {
                NSString * playerID = [NSString stringWithFormat:@"%@" , item.playerID ? item.playerID : @""];
                NSString * matchID = [NSString stringWithFormat:@"%@" , item.matchID ? item.matchID : @""];
                NSString * teamID = [NSString stringWithFormat:@"%@" , item.teamID ? item.teamID : @""];
                NSString * teamType = [NSString stringWithFormat:@"%@" , item.teamType ? item.teamType : @""];
                NSString * cardNo = [NSString stringWithFormat:@"%@" , item.cardNo ? item.cardNo : @""];
                
                NSString * name = [NSString stringWithFormat:@"%@" , item.name ? item.name : @""];
                NSString * playerNumber = [NSString stringWithFormat:@"%@" , item.playerNumber ? item.playerNumber : @""];
                
                NSString * isPlaying = [NSString stringWithFormat:@"%@" , item.isPlaying ? item.isPlaying : @""];
                NSString * isFirst = [NSString stringWithFormat:@"%@" , item.isFirst ? item.isFirst : @""];
                
                BOOL insert = [_database executeUpdate:@"insert into t_player (playerID,matchID,teamID,teamType,cardNo,name,playerNumber,isPlaying,isFirst) values(?,?,?,?,?,?,?,?,?)",playerID,matchID,teamID,teamType,cardNo,name,playerNumber,isPlaying,isFirst];
                
                if (!insert) {
                    [_errorArray addObject:item];
                }
                
            }
            
            NSDate *endTime = [NSDate date];
            NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
            NSLog(@"使用事务处理了服务器的 %@ 条数据用时%.3f秒",@(array.count),a);
            
        }
        @catch (NSException *exception)
        {
            isRollBack = YES;
            [self.database rollback];
        }
        @finally
        {
            if (!isRollBack)
            {
                [self.database commit];
            }
        }
        
        //            [self.database close];
        
    }
    
}

//初始化得分表
- (void) InitializeScoreinMatch:(NSArray <YZStatisticsModel *>*)scoreData {
    
    if ([_database open]) {
        
        NSDate *startTime = [NSDate date];
        [self.database beginTransaction];
        BOOL isRollBack = NO;
        @try
        {
            
            for (YZStatisticsModel * item in scoreData) {
                NSString * playerID = [NSString stringWithFormat:@"%@" , item.playerID ? item.playerID : @""];
                NSString * playerNumber = [NSString stringWithFormat:@"%@" , item.playerNumber ? item.playerNumber : @""];
                NSString * matchID = [NSString stringWithFormat:@"%@" , item.matchID ? item.matchID : @""];
                NSString * teamID = [NSString stringWithFormat:@"%@" , item.teamID ? item.teamID : @""];
                NSString * teamType = [NSString stringWithFormat:@"%@" , item.teamType ? item.teamType : @""];
                NSString * Timeout = [NSString stringWithFormat:@"%@" , item.Timeout ? item.Timeout : @""];
                
                //节次
                NSString * stage = [NSString stringWithFormat:@"%@" , item.stage ? item.stage : @""];//6
                
                NSString * OnePoints = [NSString stringWithFormat:@"%@" , item.OnePoints ? item.OnePoints : @""];
                NSString * OnePointsHit = [NSString stringWithFormat:@"%@" , item.OnePointsHit ? item.OnePointsHit : @""];
                
                NSString * TwoPoints = [NSString stringWithFormat:@"%@" , item.TwoPoints ? item.TwoPoints : @""];
                NSString * TwoPointsHit = [NSString stringWithFormat:@"%@" , item.TwoPointsHit ? item.TwoPointsHit : @""];
                
                NSString * ThreePoints = [NSString stringWithFormat:@"%@" , item.ThreePoints ? item.ThreePoints : @""];
                NSString * ThreePointsHit = [NSString stringWithFormat:@"%@" , item.ThreePointsHit ? item.ThreePointsHit : @""];
                
                NSString * FreeThrow = [NSString stringWithFormat:@"%@" , item.FreeThrow ? item.FreeThrow : @""];
                NSString * FreeThrowHit = [NSString stringWithFormat:@"%@" , item.FreeThrowHit ? item.FreeThrowHit : @""];//8
                
                NSString * OffensiveRebound = [NSString stringWithFormat:@"%@" , item.OffensiveRebound ? item.OffensiveRebound : @""];
                NSString * DefensiveRebound = [NSString stringWithFormat:@"%@" , item.DefensiveRebound ? item.DefensiveRebound : @""];
                
                NSString * Steals = [NSString stringWithFormat:@"%@" , item.Steals ? item.Steals : @""];
                NSString * Turnover = [NSString stringWithFormat:@"%@" , item.Turnover ? item.Turnover : @""];
                NSString * BlockShots = [NSString stringWithFormat:@"%@" , item.BlockShots ? item.BlockShots : @""];
                NSString * Assists = [NSString stringWithFormat:@"%@" , item.Assists ? item.Assists : @""];
                
                NSString * FoulsSum = [NSString stringWithFormat:@"%@" , item.FoulsSum ? item.FoulsSum : @""];
                NSString * Fouls = [NSString stringWithFormat:@"%@" , item.Fouls ? item.Fouls : @""];
                NSString * TechnologyFouls = [NSString stringWithFormat:@"%@" , item.TechnologyFouls ? item.TechnologyFouls : @""];
                NSString * AgainstBodyFouls = [NSString stringWithFormat:@"%@" , item.AgainstBodyFouls ? item.AgainstBodyFouls : @""];
                NSString * PowerFouls = [NSString stringWithFormat:@"%@" , item.PowerFouls ? item.PowerFouls : @""]; //11
                
                
                BOOL insert = [_database executeUpdate:@"insert into t_statistics (playerID,playerNumber,matchID,teamID,teamType,stage,Timeout,OnePoints,OnePointsHit,TwoPoints,TwoPointsHit,ThreePoints,ThreePointsHit,FreeThrow,FreeThrowHit,OffensiveRebound,DefensiveRebound,Steals,Turnover,BlockShots,Assists,FoulsSum,Fouls,TechnologyFouls,AgainstBodyFouls,PowerFouls) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",playerID,playerNumber,matchID,teamID,teamType,stage,Timeout,OnePoints,OnePointsHit,TwoPoints,TwoPointsHit,ThreePoints,ThreePointsHit,FreeThrow,FreeThrowHit,OffensiveRebound,DefensiveRebound,Steals,Turnover,BlockShots,Assists,FoulsSum,Fouls,TechnologyFouls,AgainstBodyFouls,PowerFouls];
                
                if (!insert) {
                    [_errorArray addObject:item];
                }
                
            }
            
            NSDate *endTime = [NSDate date];
            NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
            NSLog(@"使用事务处理了服务器的 %@ 条数据用时%.3f秒",@(1),a);
            
        }
        @catch (NSException *exception)
        {
            isRollBack = YES;
            [self.database rollback];
        }
        @finally
        {
            if (!isRollBack)
            {
                [self.database commit];
            }
        }
        
        //            [self.database close];
        
    }
    
}

/**
 更新比赛中的球员的上场数据
 
 @param playerModel 球员数据模型
 */
- (void) updatePlayerData:(YZPlayerModel *)playerModel {
    
    NSString * matchID = [NSString stringWithFormat:@"%@" , playerModel.matchID];
    NSString * playerID = [NSString stringWithFormat:@"%@" , playerModel.playerID];
    NSString * teamID = [NSString stringWithFormat:@"%@" , playerModel.teamID];
    NSString * isPlaying = [NSString stringWithFormat:@"%@" , playerModel.isPlaying];
    
    if ([self.database open]) {
        
        NSDate *startTime = [NSDate date];
        [self.database beginTransaction];
        BOOL isRollBack = NO;
        @try
        {
            
            BOOL update = [_database executeUpdate:@"update t_player set isPlaying = ? where matchID = ? and teamID = ? and playerID = ?",isPlaying,matchID,teamID,playerID];
            
            if (!update) {
                
                NSLog(@"dataError %s \n ! ----- \n matchID: %@ \n teamID: %@ \n playerID: %@ \n" ,__func__ ,playerModel.matchID, playerModel.teamID, playerModel.playerID);
                
                [_errorArray addObject:playerModel];
                
            }
            
            NSDate *endTime = [NSDate date];
            NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
            NSLog(@"使用事务处理了服务器的 %@ 条数据用时%.3f秒",@(1),a);
            
        }
        
        @catch (NSException *exception)
        {
            isRollBack = YES;
            [self.database rollback];
        }
        @finally
        {
            if (!isRollBack)
            {
                [self.database commit];
            }
        }
        
    }
    
    
}

/**
 更新比赛中的球员得分数据
 
 @param scoreData 一条球员得分数据模型
 */
- (void) updateScoreData:(YZStatisticsModel*)scoreData{
    
    NSDate *startTime = [NSDate date];
    [self.database beginTransaction];
    BOOL isRollBack = NO;
    @try
    {
        
        NSString * playerID = [NSString stringWithFormat:@"%@" , scoreData.playerID ? scoreData.playerID : @""];
        NSString * matchID = [NSString stringWithFormat:@"%@" , scoreData.matchID ? scoreData.matchID : @""];
        NSString * teamID = [NSString stringWithFormat:@"%@" , scoreData.teamID ? scoreData.teamID : @""];
        
        NSString * stage = [NSString stringWithFormat:@"%@" , scoreData.stage ? scoreData.stage : @""];//6
        
        NSString * OnePoints = [NSString stringWithFormat:@"%@" , scoreData.OnePoints ? scoreData.OnePoints : @""];
        NSString * OnePointsHit = [NSString stringWithFormat:@"%@" , scoreData.OnePointsHit ? scoreData.OnePointsHit : @""];
        
        NSString * TwoPoints = [NSString stringWithFormat:@"%@" , scoreData.TwoPoints ? scoreData.TwoPoints : @""];
        NSString * TwoPointsHit = [NSString stringWithFormat:@"%@" , scoreData.TwoPointsHit ? scoreData.TwoPointsHit : @""];
        
        NSString * ThreePoints = [NSString stringWithFormat:@"%@" , scoreData.ThreePoints ? scoreData.ThreePoints : @""];
        NSString * ThreePointsHit = [NSString stringWithFormat:@"%@" , scoreData.ThreePointsHit ? scoreData.ThreePointsHit : @""];
        
        NSString * FreeThrow = [NSString stringWithFormat:@"%@" , scoreData.FreeThrow ? scoreData.FreeThrow : @""];
        NSString * FreeThrowHit = [NSString stringWithFormat:@"%@" , scoreData.FreeThrowHit ? scoreData.FreeThrowHit : @""];//8
        
        NSString * OffensiveRebound = [NSString stringWithFormat:@"%@" , scoreData.OffensiveRebound ? scoreData.OffensiveRebound : @""];
        NSString * DefensiveRebound = [NSString stringWithFormat:@"%@" , scoreData.DefensiveRebound ? scoreData.DefensiveRebound : @""];
        
        NSString * Steals = [NSString stringWithFormat:@"%@" , scoreData.Steals ? scoreData.Steals : @""];
        NSString * Turnover = [NSString stringWithFormat:@"%@" , scoreData.Turnover ? scoreData.Turnover : @""];
        NSString * BlockShots = [NSString stringWithFormat:@"%@" , scoreData.BlockShots ? scoreData.BlockShots : @""];
        NSString * Assists = [NSString stringWithFormat:@"%@" , scoreData.Assists ? scoreData.Assists : @""];
        
        NSString * FoulsSum = [NSString stringWithFormat:@"%@" , scoreData.FoulsSum ? scoreData.FoulsSum : @""];
        NSString * Fouls = [NSString stringWithFormat:@"%@" , scoreData.Fouls ? scoreData.Fouls : @""];
        NSString * TechnologyFouls = [NSString stringWithFormat:@"%@" , scoreData.TechnologyFouls ? scoreData.TechnologyFouls : @""];
        NSString * AgainstBodyFouls = [NSString stringWithFormat:@"%@" , scoreData.AgainstBodyFouls ? scoreData.AgainstBodyFouls : @""];
        NSString * PowerFouls = [NSString stringWithFormat:@"%@" , scoreData.PowerFouls ? scoreData.PowerFouls : @""]; //11
        
        
        BOOL insert = [_database executeUpdate:@"update t_statistics set OnePoints = ?, OnePointsHit = ?, TwoPoints = ?, TwoPointsHit = ?, ThreePoints = ?, ThreePointsHit = ?, FreeThrow = ?, FreeThrowHit = ?, OffensiveRebound = ?, DefensiveRebound = ?, Steals = ?, Turnover = ?, BlockShots = ?, Assists = ?, FoulsSum = ?, Fouls = ?, TechnologyFouls = ?, AgainstBodyFouls = ?, PowerFouls = ? where matchID = ? and teamID = ? and playerID = ? and stage = ?",OnePoints,OnePointsHit,TwoPoints,TwoPointsHit,ThreePoints,ThreePointsHit,FreeThrow,FreeThrowHit,OffensiveRebound,DefensiveRebound,Steals,Turnover,BlockShots,Assists,FoulsSum,Fouls,TechnologyFouls,AgainstBodyFouls,PowerFouls,matchID,teamID,playerID,stage];
        
        if (!insert) {
            
            NSLog(@"dataError %s \n ! ----- \n matchID: %@ \n teamID: %@ \n playerID: %@ \n" ,__func__ ,scoreData.matchID, scoreData.teamID, scoreData.playerID);
            
            [_errorArray addObject:scoreData];
            
        }
        
        NSDate *endTime = [NSDate date];
        NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
        NSLog(@"使用事务处理了服务器的 %@ 条数据用时%.3f秒",@(1),a);
        
    }
    @catch (NSException *exception)
    {
        isRollBack = YES;
        [self.database rollback];
    }
    @finally
    {
        if (!isRollBack)
        {
            [self.database commit];
        }
    }
    
}

//插入语音数据表
- (void) updateVoiceList:(YZVoiceModel *)voiceModel {
    
    NSString * matchID = [NSString stringWithFormat:@"%@" , voiceModel.matchID];
    NSString * teamID = [NSString stringWithFormat:@"%@" , voiceModel.teamID];
    NSString * stage = [NSString stringWithFormat:@"%@" , voiceModel.stage];
    NSString * playerID = [NSString stringWithFormat:@"%@" , voiceModel.playerID];
    
    NSString * voiceContent = [NSString stringWithFormat:@"%@" , voiceModel.voiceContent];
    NSString * playerID_First = [NSString stringWithFormat:@"%@" , voiceModel.playerID_First];
    NSString * playerID_Second = [NSString stringWithFormat:@"%@" , voiceModel.playerID_Second];
    
    if ([self.database open]) {
        
        NSDate *startTime = [NSDate date];
        [self.database beginTransaction];
        BOOL isRollBack = NO;
        @try
        {
            
            if (!voiceModel.isDelete) {//插入语音
                
                BOOL insert = [_database executeUpdate:@"insert into t_voice (matchID,teamID,voiceContent,stage,playerID,playerID_First,playerID_Second,) values(?,?,?)",matchID,teamID,voiceContent,stage,playerID,playerID_First,playerID_Second];
                
                if (!insert) {
                    
                    NSLog(@"dataError %s \n ! ----- \n matchID: %@ \n teamID: %@ \n" ,__func__ ,voiceModel.matchID, voiceModel.teamID);
                    
                    [_errorArray addObject:voiceModel];
                    
                }
                
            } else {//删除语音
                
                BOOL delete = [_database executeUpdate:@"delete from t_voice where matchID = ? and teamID = ? and playerID = ? and stage = ? and voiceContent = ?" , matchID, teamID, playerID, stage, voiceContent];
                
                if (!delete) {
                    
                    NSLog(@"dataError %s \n ! ----- \n matchID: %@ \n teamID: %@ \n" ,__func__ ,voiceModel.matchID, voiceModel.teamID);
                    
                    [_errorArray addObject:voiceModel];
                    
                }
                
            }
            
            
            
            NSDate *endTime = [NSDate date];
            NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
            NSLog(@"使用事务处理了服务器的 %@ 条数据用时%.3f秒",@(1),a);
            
        }
        
        @catch (NSException *exception)
        {
            isRollBack = YES;
            [self.database rollback];
        }
        @finally
        {
            if (!isRollBack)
            {
                [self.database commit];
            }
        }
        
    }
    
}

/**
 获取整场比赛所有的球员信息
 
 @param matchID 比赛ID
 @return 返回球员模型列表
 */
- (NSArray <YZPlayerModel*>*) getPlayerWithMatchID:(NSString *)matchID {
    
    NSMutableArray * array = [NSMutableArray array];
    
    if ([self.database open]) {
        
        FMResultSet *set = [_database executeQuery:@"select * from t_player where matchID = ? ORDER BY playerNumber ASC",matchID];
        while ([set next]) {
            
            YZPlayerModel * model = [YZPlayerModel new];
            
            model.playerID = [set stringForColumn:playerID];
            model.playerNumber = [set stringForColumn:playerNumber];
            model.teamID = [set stringForColumn:teamID];
            model.teamType = [set stringForColumn:teamType];
            model.cardNo = [set stringForColumn:cardNo];
            model.name = [set stringForColumn:name];
            model.isPlaying = [set stringForColumn:isPlaying];
            model.isFirst = [set stringForColumn:isFirst];
            
            [array addObject:model];
            
        }
        
    }
    
    [self.database close];
    
    return array;
    
}

/**
 获取本场比赛所有球员所有节次的技统数据
 
 @param matchID 比赛ID
 @return 技统数据列表
 */
- (NSArray <YZStatisticsModel *>*) getScoreDataWithMatchID:(NSString *)matchID {
 
    NSMutableArray * array = [NSMutableArray array];
    
    if ([self.database open]) {
        
        FMResultSet *set = [_database executeQuery:@"select * from t_statistics where matchID = ?",matchID];
        while ([set next]) {
            
            YZStatisticsModel * model = [YZStatisticsModel new];
            
            model.playerID = [set stringForColumn:playerID];
            model.playerNumber = [set stringForColumn:playerNumber];
            model.teamID = [set stringForColumn:teamID];
            model.teamType = [set stringForColumn:teamType];
            model.matchID = [set stringForColumn:matchID];
            model.stage = [set stringForColumn:stage];
            
            model.Timeout = [set stringForColumn:Timeout];
            
            model.OnePoints = [set stringForColumn:OnePoints];
            model.OnePointsHit = [set stringForColumn:OnePointsHit];
            model.TwoPoints = [set stringForColumn:TwoPoints];
            model.TwoPointsHit = [set stringForColumn:TwoPointsHit];
            model.ThreePoints = [set stringForColumn:ThreePoints];
            model.ThreePointsHit = [set stringForColumn:ThreePointsHit];
            model.FreeThrow = [set stringForColumn:FreeThrow];
            model.FreeThrowHit = [set stringForColumn:FreeThrowHit];
            
            model.OffensiveRebound = [set stringForColumn:OffensiveRebound];
            model.DefensiveRebound = [set stringForColumn:DefensiveRebound];
            
            model.Steals = [set stringForColumn:Steals];
            model.Turnover = [set stringForColumn:Turnover];
            model.BlockShots = [set stringForColumn:BlockShots];
            model.Assists = [set stringForColumn:Assists];
            
            model.FoulsSum = [set stringForColumn:FoulsSum];
            model.Fouls = [set stringForColumn:Fouls];
            model.TechnologyFouls = [set stringForColumn:TechnologyFouls];
            model.AgainstBodyFouls = [set stringForColumn:AgainstBodyFouls];
            model.PowerFouls = [set stringForColumn:PowerFouls];
            
            [array addObject:model];
            
        }
        
    }
    
    [self.database close];
    
    return array;
    
}


/**
 获取本场比赛所有球员指定节次的技统数据
 
 @param matchID 比赛ID
 @param stage 节次标志
 @return 技统数据列表
 */
- (NSArray <YZStatisticsModel *>*) getScoreDataWithMatchID:(NSString *)matchID stage:(NSString *)stage {
    
    NSMutableArray * array = [NSMutableArray array];
    
    if ([self.database open]) {
        
        FMResultSet *set = [_database executeQuery:@"select * from t_statistics where matchID = ? and stage = ?",matchID, stage];
        while ([set next]) {
            
            YZStatisticsModel * model = [YZStatisticsModel new];
            
            model.playerID = [set stringForColumn:playerID];
            model.playerNumber = [set stringForColumn:playerNumber];
            model.teamID = [set stringForColumn:teamID];
            model.teamType = [set stringForColumn:teamType];
            model.matchID = [set stringForColumn:matchID];
            model.stage = [set stringForColumn:stage];
            
            model.Timeout = [set stringForColumn:Timeout];
            
            model.OnePoints = [set stringForColumn:OnePoints];
            model.OnePointsHit = [set stringForColumn:OnePointsHit];
            model.TwoPoints = [set stringForColumn:TwoPoints];
            model.TwoPointsHit = [set stringForColumn:TwoPointsHit];
            model.ThreePoints = [set stringForColumn:ThreePoints];
            model.ThreePointsHit = [set stringForColumn:ThreePointsHit];
            model.FreeThrow = [set stringForColumn:FreeThrow];
            model.FreeThrowHit = [set stringForColumn:FreeThrowHit];
            
            model.OffensiveRebound = [set stringForColumn:OffensiveRebound];
            model.DefensiveRebound = [set stringForColumn:DefensiveRebound];
            
            model.Steals = [set stringForColumn:Steals];
            model.Turnover = [set stringForColumn:Turnover];
            model.BlockShots = [set stringForColumn:BlockShots];
            model.Assists = [set stringForColumn:Assists];
            
            model.FoulsSum = [set stringForColumn:FoulsSum];
            model.Fouls = [set stringForColumn:Fouls];
            model.TechnologyFouls = [set stringForColumn:TechnologyFouls];
            model.AgainstBodyFouls = [set stringForColumn:AgainstBodyFouls];
            model.PowerFouls = [set stringForColumn:PowerFouls];
            
            [array addObject:model];
            
        }
        
    }
    
    [self.database close];
    
    return array;
    
}

- (void) checkErrorArray {
    
    _errorArray = [NSMutableArray array];
    
}

//获取需要的列表内容
- (NSArray *) getDiseasesList {
    
    NSMutableArray * array = [NSMutableArray array];
    
    if ([self.database open]) {
        
        NSString * ASC = @"SELECT * FROM t_diseases ORDER BY pinyin ASC";
        
        FMResultSet * result = [_database executeQuery:ASC];
        
        [_resultArray addObject:result];
        
        FMResultSet *set = [_database executeQuery:@"select * from t_diseases where enabled=1 ORDER BY pinyin ASC"];
        while ([set next]) {
            
            NSDictionary * dic = @{
                                   @"pinyin"    : [set stringForColumn:@"pinyin"],
                                   @"cn"        : [set stringForColumn:@"cn"],
                                   @"en"        : [set stringForColumn:@"en"],
                                   @"enabled"   : @([set boolForColumn:@"enabled"]),
                                   @"id"        : @([set longForColumn:@"id"])
                                   };
            
            [array addObject:dic];
            
        }
        
    }
    
    [self.database close];
    
    return array;
}

//更新数据库的列表
- (BOOL) uploadDiseasesList:(NSArray *)newDiseaseList {
    
    if ([self.database open])
    {
        NSDate *startTime = [NSDate date];
        [self.database beginTransaction];
        BOOL isRollBack = NO;
        @try
        {
            
            for (NSDictionary * item in newDiseaseList) {
                
                NSString * disease_id = [NSString stringWithFormat:@"%@" , [item objectForKey:@"id"]];
                
                NSString * pinyin = [NSString stringWithFormat:@"%@" , [item objectForKey:@"pinyin"]];
                
                NSString * cn = [NSString stringWithFormat:@"%@" , [item objectForKey:@"cn"]];
                
                NSString * en = [NSString stringWithFormat:@"%@" , [item objectForKey:@"en"]];
                
                NSNumber * enabled = [NSNumber numberWithInt:0];
                
                if ([[item objectForKey:@"enabled"] respondsToSelector:@selector(intValue)]) {
                    enabled = [NSNumber numberWithInt:[[item objectForKey:@"enabled"] intValue]];
                }
                
                BOOL insert = [_database executeUpdate:@"insert into t_diseases (id,pinyin,cn,en,enabled) values(?,?,?,?,?)",disease_id,pinyin,cn,en,enabled];
                
                if (!insert) {
                    
                    BOOL update = [_database executeUpdate:@"update t_diseases set enabled = ?,pinyin = ?,cn = ?,en = ? where id = ? ",enabled,pinyin,cn,en,disease_id];
                    
                    if (!update) {
                        
                        [_errorArray addObject:item];
                        
                    }
                    
                }
                
            }
            
            NSDate *endTime = [NSDate date];
            NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
            NSLog(@"使用事务插入 %@ 条数据用时%.3f秒",@(newDiseaseList.count),a);
            
        }
        @catch (NSException *exception)
        {
            isRollBack = YES;
            [self.database rollback];
        }
        @finally
        {
            if (!isRollBack)
            {
                [self.database commit];
            }
        }
        [self.database close];
    }
    
    return NO;
    
}

//

//删除数据库
- (BOOL) deleteDiseasesList {
    
    return NO;
    
}

- (int)open {
    
    if (_database) {
        
        [_database open];
        
        return 1;
    }
    
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:dataBaseFileName];
    
    ykDatabaseInstance.exist = [YKDataBase isFileExist:filePath];
    
    ykDatabaseInstance.databasePath = filePath;
    
    self.databasePath = filePath;
    
    self.database = [FMDatabase databaseWithPath:filePath];
    
    [self.database open];
    
    if (_database.lastErrorMessage) {
        
        return -1;
        
    } else {
        
        return 1;
        
    }
    
}

- (void)close {
    
    if (_database) {
        BOOL SQL_OK = [_database close];
        if (!SQL_OK) {
            NSAssert(_database.lastErrorMessage, @" SQL From FMDB Closed Failed ... Check the lastErrorMessage...");
        }
    }
}

+(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"is file exist? -> %@",result?@"yes":@"no");
    return result;
}

+ (YKDataBase *)sharedDBInstance {
    return [[self alloc]init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (ykDatabaseInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ykDatabaseInstance = [super allocWithZone:zone];
            
            //saveDataBaseDocument
            NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *filePath = [cacheDir stringByAppendingPathComponent:dataBaseFileName];
            
            ykDatabaseInstance.exist = [YKDataBase isFileExist:filePath];
            
            ykDatabaseInstance.databasePath = filePath;
            
            ykDatabaseInstance.database = [FMDatabase databaseWithPath:ykDatabaseInstance.databasePath];
            
            ykDatabaseInstance.errorArray = [NSMutableArray array];
            
            ykDatabaseInstance.resultArray = [NSMutableArray array];
        });
    }
    return ykDatabaseInstance;
}

- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ykDatabaseInstance = [super init];
    });
    return ykDatabaseInstance;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return ykDatabaseInstance;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return ykDatabaseInstance;
}


@end
