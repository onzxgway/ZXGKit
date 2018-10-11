//
//  ZXGBubbleSort.m
//  Algorithm
//
//  Created by 朱献国 on 2018/10/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGBubbleSort.h"

@implementation ZXGBubbleSort

+ (void)sortCArray:(int [])array length:(int)length {
    
    const int len = length;
    int bubbleCount = 0;
    
    BOOL needSort = NO;
    
    // n个元素，需要进行 n - 1 趟排序
    for (int i = 0; i < len - 1; ++i) {
        needSort = NO;
        
        // 每一趟，进行n - 1次比较, 最后一个元素的下标是 len - 2
        for (int j = 0; j < len - 1 - i; ++j) {
            
            if (array[j] > array[j + 1]) {
                [ZXGSort swap:&array[j] with:&array[j + 1]];
                
                needSort = YES;
            }
            
            bubbleCount ++;
            
        }
        
        if (!needSort) {
            break;
        }
        
    }
    
    NSLog(@"比较次数%d", bubbleCount);
    
}

@end
