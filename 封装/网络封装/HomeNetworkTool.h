//
//  HomeNetworkTool.h
//  网络封装
//
//  Created by 朱献国 on 2018/4/16.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGNetworkCenter.h"

@interface HomeNetworkTool : NSObject

+ (NSString *)reqEHeadlineMsgWithParams:(NSDictionary *)params
                       withSuccessBlock:(ZXGRequestSuccessBlock)successBlock
                       withFailureBlock:(ZXGRequestFailureBlock)failBlock;

@end
