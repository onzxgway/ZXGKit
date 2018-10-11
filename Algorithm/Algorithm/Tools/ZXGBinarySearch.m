//
//  ZXGBinarySearch.m
//  Algorithm
//
//  Created by 朱献国 on 2018/10/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGBinarySearch.h"

@implementation ZXGBinarySearch

+ (int)indexOf:(int)value inCArray:(int [])array start:(int)startIndex end:(int)endIndex {
    
    static int binaryCount = 0;
    binaryCount ++;
    
    // 递归出口
    if (startIndex == endIndex) {
        if (array[startIndex] != value) {
            NSLog(@"递归了：%d次", binaryCount);
            binaryCount = 0;
            return -1;
        }
    }
    else if (startIndex > endIndex) {
        NSLog(@"递归了：%d次", binaryCount);
        binaryCount = 0;
        return -1;
    }
    
    int middle = startIndex + (endIndex - startIndex) / 2;
    
    if (array[middle] == value) {
        NSLog(@"递归了：%d次", binaryCount);
        return middle;
    }
    else if (array[middle] > value) {
        return [self indexOf:value inCArray:array start:startIndex end:middle - 1]; // 递归的时候一定要有出口。
    }
    else {
        return [self indexOf:value inCArray:array start:middle + 1 end:endIndex];
    }
    
    return -1;
}

@end
