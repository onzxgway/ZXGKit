//
//  ZXGMomentsLayout.m
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsLayout.h"

@implementation ZXGMomentsLayout

- (instancetype)init {
    return [self initWithMoments:nil];
}

- (instancetype)initWithMoments:(ZXGDynamicModel *)moments {
    self = [super init];
    if (self) {
        _momentsModel = moments;
    }
    return self;
}



@end
