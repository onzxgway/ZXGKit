//
//  ZXGDynamicModel.m
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentModel.h"

@implementation ZXGMomentsLikeModel

@end

@implementation ZXGMomentsCommentModel

@end

@implementation ZXGMomentsLocationModel

@end

@implementation ZXGMomentModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _isExpand = NO;
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"locaionMsg" : [ZXGMomentsLocationModel class],
             @"comments" : [ZXGMomentsCommentModel class],
             @"likes" : [ZXGMomentsLikeModel class]
             };
}

@end
