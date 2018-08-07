//
//  YZTeamModel.h
//  Section
//
//  Created by QZL on 2018/6/14.
//  Copyright © 2018年 WTF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YZPlayerModel;
@interface YZTeamModel : NSObject

@property (nonatomic, strong) NSArray <YZPlayerModel *>* playInfos ;

@property (nonatomic, copy) NSString * teamCoach;
@property (nonatomic, copy) NSString * teamName;
@property (nonatomic, copy) NSString * token;

@end
