//
//  YZBlueToothServiceModel.h
//  Section
//
//  Created by QZL on 2017/4/26.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZBlueToothServiceModel : NSObject

@property (nonatomic, copy) NSString * serviceName;

@property (nonatomic, assign) CBPeripheralState serviceState;

@property (nonatomic, strong) NSNumber * RSSI_CL;

@end
