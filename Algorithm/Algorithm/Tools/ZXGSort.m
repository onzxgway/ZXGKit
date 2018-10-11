//
//  ZXGSort.m
//  Algorithm
//
//  Created by 朱献国 on 2018/10/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGSort.h"

@implementation ZXGSort

+ (void)swap:(int *)one with:(int *)other {
    
    int temp = *one;
    
    *one = *other;
    
    *other = temp;
    
}

+ (void)logArray:(int [])array with:(int)length {
    for (int i = 0; i < length; ++i) {
        NSLog(@"%d", array[i]);
    }
}

@end
