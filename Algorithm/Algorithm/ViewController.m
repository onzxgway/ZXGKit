//
//  ViewController.m
//  Algorithm
//
//  Created by 朱献国 on 2018/10/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "ZXGBubbleSort.h"
#import "ZXGBinarySearch.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 一.算法三原则：
    1.有穷性。
    2.确定性。
    3.可行性。
 
 二.算法分析：
    对算法在运行时间和存储空间这两种资源的利用效率进行研究。 即时间效率（时间复杂度）和空间效率（空间复杂度）。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self binarySearch];
}

// 冒泡排序
/**
 冒泡排序算法的原理如下：
 比较相邻的元素。如果第一个比第二个大，就交换他们两个。
 对每一对相邻元素做同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。
 针对所有的元素重复以上的步骤，除了最后一个。
 持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
 
 举例： 对 234，555，2，6，11，34，1，999，0 升序排列
 
 第一趟：234，2，6，11，34，1，555，0，999
 
 第二趟：2，6，11，34，1，234，0，555，999
 
 第三趟：2，6，11，1，34，0，234，555，999
 
 第四趟：2，6，1，11，0，34，234，555，999
 
 第五趟：2，1，6，0，11，34，234，555，999
 
 第六趟：1，2，0，6，11，34，234，555，999
 
 第七趟：1，0，2，6，11，34，234，555，999
 
 第八趟：0，1，2，6，11，34，234，555，999
 
 总共需要（n - 1）趟比较
 
 */
- (void)bubbleSort {
    
    const int maxCount = 1000;
    
    int a[maxCount] = {};
    
    for (int i = 0; i < maxCount; ++i) {
        a[i] = rand()%maxCount; // 生产 0 ~ yyy 的随机数,  rand()%yyy即可
    }
    
    [ZXGSort logArray:a with:maxCount];
    [ZXGBubbleSort sortCArray:a length:maxCount];
    [ZXGSort logArray:a with:maxCount];
    
    [ZXGBubbleSort sortCArray:a length:maxCount];
    [ZXGSort logArray:a with:maxCount];
}

// 二分查找
/**
 n个元素的有序集合，通过二分查找指定元素，最多需要
 
 */
- (void)binarySearch {
    
    const int maxCount = 1000;
    
    int a[maxCount] = {};
    
    for (int i = 0; i < maxCount; ++i) {
        a[i] = i;
    }
    
    NSLog(@"%d", [ZXGBinarySearch indexOf:-1 inCArray:a start:0 end:maxCount - 1]);
    NSLog(@"%d", [ZXGBinarySearch indexOf:0 inCArray:a start:0 end:maxCount - 1]);
    NSLog(@"%d", [ZXGBinarySearch indexOf:maxCount / 2 inCArray:a start:0 end:maxCount - 1]);
    NSLog(@"%d", [ZXGBinarySearch indexOf:maxCount - 1 inCArray:a start:0 end:maxCount - 1]);
    NSLog(@"%d", [ZXGBinarySearch indexOf:maxCount inCArray:a start:0 end:maxCount - 1]);
}

@end
