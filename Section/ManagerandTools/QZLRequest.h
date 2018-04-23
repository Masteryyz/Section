//
//  QZLRequest.h
//  跆拳道QZL
//
//  Created by QianZhengLong on 16/6/13.
//  Copyright © 2016年 QianZhengLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"
#import "YTKNetworkConfig.h"
@interface QZLRequest : YTKRequest

- (instancetype)initWithRUrl:(NSString *)url
                  andRMethod:(YTKRequestMethod)method
                andRArgument:(id)argument;

@end
