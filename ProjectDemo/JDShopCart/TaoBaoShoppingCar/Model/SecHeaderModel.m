//
//  SecHeaderModel.m
//  淘宝购物车
//
//  Created by 朱献国 on 24/09/2017.
//  Copyright © 2017 朱献国. All rights reserved.
//

#import "SecHeaderModel.h"

@implementation SecHeaderModel


#pragma mark - NSCoping
- (id)copyWithZone:(NSZone *)zone {
    SecHeaderModel *secHeaderModel = [[[self class] allocWithZone:zone] init];
    secHeaderModel.isSelected = self.isSelected;
    return secHeaderModel;
}

@end
