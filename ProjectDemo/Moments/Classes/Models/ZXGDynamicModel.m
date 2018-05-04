//
//  ZXGDynamicModel.m
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGDynamicModel.h"

@implementation ZXGDynamicCommentModel


@end

@implementation ZXGDynamicLocationModel

@end

@implementation ZXGDynamicModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"locaionMsg" : [ZXGDynamicLocationModel class],
             @"comments" : [ZXGDynamicCommentModel class]
             };
}


@end
