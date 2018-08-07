//
//  YZCheckinPageController.m
//  Section
//
//  Created by QZL on 2018/6/12.
//  Copyright © 2018年 WTF. All rights reserved.
//

#import "YZCheckinPageController.h"
#import "YZTeamModel.h"
#import "YZPlayerModel.h"
#import "YZCheckinCell.h"
#import "YZStatisticsModel.h"
#import "YZTeamModel.h"


@interface YZCheckinPageController ()

@property (nonatomic, strong) NSString * userToken ;

@property (nonatomic, strong) NSMutableArray * dataArray ;
@property (nonatomic, strong) NSMutableArray * homeTeamArray ;
@property (nonatomic, strong) NSMutableArray * guestTeamArray ;

@property (nonatomic, strong) NSMutableArray * playerScoreArray ;

@property (nonatomic, copy) NSString * homeTeamID;
@property (nonatomic, copy) NSString * guestTeamID;
@property (nonatomic, copy) NSString * matchID;

@property (nonatomic, strong) YKDataBase * database ;

@end

@implementation YZCheckinPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"沙盒路径:%@", NSHomeDirectory());
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray arrayWithCapacity:2];
    
    _homeTeamID = @"bb6e072d42c24df0b253660def26644d";
    _guestTeamID = @"aede4b7fa9dd4fde9885a0b53baa12e5";
    _matchID = @"djioj4b7faa2wai20285a0b53baa12dwu";
    
    _homeTeamArray = [NSMutableArray array];
    _guestTeamArray = [NSMutableArray array];
    _playerScoreArray = [NSMutableArray array];
    
    YKDataBase * database= [YKDataBase sharedDBInstance];
    
    _database = database;
    
    [_database create_DatabaseAndTable];
    
    [self p_startLoginCBO];
    
}

- (void)p_startLoginCBO {
    NSMutableDictionary *userInfoDict = [NSMutableDictionary dictionary];
    userInfoDict[@"loginname"] = @"wsy";
    userInfoDict[@"password"] = @"123456";
    
    userInfoDict[@"type"] = @"11";
    userInfoDict[@"EventName"] = @"SCBO官方赛事";
    userInfoDict[@"rememberPD"] = @"1";
    
    [QZLNetworkManger startLoginBCBC:userInfoDict responseSuccess:^(id responseObject) {
        
        NSLog(@"%@" , responseObject);
        _userToken = [NSString stringWithFormat:@"%@" , responseObject[@"entity"][@"token"]];
        
        [self getPlayerWithTeamID:_homeTeamID andTeam:YES];
        [self getPlayerWithTeamID:_guestTeamID andTeam:NO];
        
    } responseFailed:^(NSError *error) {
        
        NSLog(@"%@" , error);
        
    }];
    
}

- (void) getPlayerWithTeamID:(NSString *) teamId andTeam:(BOOL)Hteam{
    
    [QZLNetworkManger cbo_queryPlayByTeam:@{@"teamId" : teamId} responseSuccess:^(id responseObject) {
        
        NSLog(@"%@" , responseObject);
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)[responseObject valueForKey:@"entity"]];
        
        NSArray * tempInfos = [NSArray arrayWithArray:(NSArray *)[dic valueForKey:@"playInfos"]];
        
        NSMutableArray * playerInfos = [NSMutableArray array];
        
        //存储数据库
        [tempInfos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
            
            if (Hteam) {
                [dic setValue:_homeTeamID forKey:teamID];
                [dic setValue:@"1" forKey:teamType];
            } else {
                [dic setValue:_guestTeamID forKey:teamID];
                [dic setValue:@"2" forKey:teamType];
            }
            
            [dic setValue:_matchID forKey:matchID];
            
            [playerInfos addObject:dic];
            
        }];
        
        [dic setValue:playerInfos forKey:@"playInfos"];
        
        YZTeamModel * model = [YZTeamModel mj_objectWithKeyValues:dic];
        
        if (Hteam) {
            _homeTeamArray = [NSMutableArray arrayWithArray:model.playInfos];
        } else {
            _guestTeamArray = [NSMutableArray arrayWithArray:model.playInfos];
        }
        
        if (_homeTeamArray.count && _guestTeamArray.count) {
            [self checkIn];
        }
        
    } responseFailed:^(NSError *error) {
        
        NSLog(@"%@" , error);
        
    } token:_userToken];
    
}

- (void) checkIn {
    
    NSLog(@"开始载入数据库");
    
    if (!_homeTeamArray.count && _guestTeamArray.count) {
        _playerScoreArray = [NSMutableArray array];
        //检录完毕
        //需要更新比赛表
        [_database saveMatchInfo:@{matchID : _matchID}];
        //需要更新队伍表
        [_database saveTeamInfo:@{matchID : _matchID, teamID : _homeTeamID , teamType : @"1"}];
        [_database saveTeamInfo:@{matchID : _matchID, teamID : _guestTeamID , teamType : @"2"}];
        
        //需要更新球员表
        [_database savePlayerInfoWithObject:_homeTeamArray];
        [_database savePlayerInfoWithObject:_guestTeamArray];
        
        //初始化球员得分表
        [_homeTeamArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            YZPlayerModel * playerModel = obj;
            
            YZStatisticsModel * statisticModel = [YZStatisticsModel new];
            
            statisticModel.playerID = playerModel.playerID;
            statisticModel.playerNumber = playerModel.playerNumber;
            statisticModel.teamID = playerModel.teamID;
            statisticModel.matchID = playerModel.matchID;
            statisticModel.teamType = playerModel.teamType;
            
            statisticModel.stage = StageOne;
            
            statisticModel.OnePointsHit = @"3";
            
            [_playerScoreArray addObject:statisticModel];
            
        }];
        
        [_guestTeamArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            YZPlayerModel * playerModel = obj;
            
            YZStatisticsModel * statisticModel = [YZStatisticsModel new];
            
            statisticModel.playerID = playerModel.playerID;
            statisticModel.playerNumber = playerModel.playerNumber;
            statisticModel.teamID = playerModel.teamID;
            statisticModel.matchID = playerModel.matchID;
            statisticModel.teamType = playerModel.teamType;
            
            statisticModel.stage = StageOne;
            
            statisticModel.TwoPointsHit = @"10";
            
            [_playerScoreArray addObject:statisticModel];
            
        }];
        
        [_database InitializeScoreinMatch:_playerScoreArray];
        
    }
    
    NSString * playerID = @"3d799442488040708ce9140f350fedc4";
    
    YZStatisticsModel * model = [YZStatisticsModel new];
    
    model.playerID = playerID;
    model.teamID = _homeTeamID;
    model.matchID = _matchID;
    
    model.stage = StageOne;
    
    model.FreeThrow = @"10";
    
    [_database updateScoreData:model];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
