//
//  ZXGMomentsLayout.h
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXGDynamicModel;

@interface ZXGMomentsLayout : NSObject

/** model*/
@property (nonatomic, strong, readonly) ZXGDynamicModel *momentsModel;

- (instancetype)initWithMoments:(ZXGDynamicModel *)moments NS_DESIGNATED_INITIALIZER;

@end
