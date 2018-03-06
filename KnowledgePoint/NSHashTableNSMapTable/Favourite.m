//
//  Favourite.m
//  NSHashTableNSMapTable
//
//  Created by feizhu on 2018/3/6.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "Favourite.h"

@implementation Favourite

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

@end
