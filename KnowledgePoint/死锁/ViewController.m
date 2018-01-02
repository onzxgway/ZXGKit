//
//  ViewController.m
//  死锁
//
//  Created by 朱献国 on 19/10/2017.
//  Copyright © 2017 朱献国. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self deadLockTest];
}

/**
 关于Dispatch对象内存管理问题
 
 根据上面的代码，可以看出有关dispatch的对象并不是OC对象，那么，用不用像对待Core Foundation框架的对象一样，使用retain/release来管理呢？答案是不用的！
 
 如果是ARC环境，我们无需管理，会像对待OC对象一样自动内存管理。
 如果是MRC环境，不是使用retain/release，而是使用dispatch_retain/dispatch_release来管理。

 */

//主队列死锁
- (void)mainThreadDeadLockTest {
    NSLog(@"begin");
    dispatch_sync(dispatch_get_main_queue(), ^{
        // 发生死锁下面的代码不会执行
        NSLog(@"middle");
    });
    // 发生死锁下面的代码不会执行，当然函数也不会返回，后果也最为严重
    NSLog(@"end");
}

//在其它线程死锁
- (void)deadLockTest {
    // 其它线程的死锁
    dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        // 串行队列block1
        NSLog(@"begin");
        dispatch_sync(serialQueue, ^{
            // 串行队列block2 发生死锁，下面的代码不会执行
            NSLog(@"middle");
        });
        // 不会打印
        NSLog(@"end");
    });
    // 函数会返回，不影响主线程
    NSLog(@"return");
}


@end
