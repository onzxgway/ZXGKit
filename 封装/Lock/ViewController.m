//
//  ViewController.m
//  Lock
//
//  Created by 朱献国 on 2018/10/10.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *saleBtn;

@property (nonatomic) NSLock *nslock;

@property (nonatomic) NSCondition *nsCondition;

@property (nonatomic) NSConditionLock *nsConditionLock;

@end

/**
 
 iOS 中的八大锁
 
 */

/**
 窗口卖票经典实例

 需求：四个窗口同时卖票。票数100张
 
 分析：一共有100张票，卖票的动作是四个窗口所使用的，并且是同时进行的，那么就要使用多线程技术。

 */

@implementation ViewController

pthread_mutex_t lock;
dispatch_semaphore_t singal;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.saleBtn addTarget:self action:@selector(beginSale:) forControlEvents:UIControlEventTouchUpInside];
    singal = dispatch_semaphore_create(1);
    pthread_mutex_init(&lock, NULL);
}

- (void)beginSale:(UIButton *)btn {
    [self saleTickets];
}

- (void)saleTickets {

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self publicTask];
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self publicTask];
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self publicTask];
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self publicTask];
    });
}

// 六. NSConditionLock
- (void)publicTask {
    
    static NSInteger _count = 100;
    
    while(true) {
        
        [self.nsConditionLock lock];
        
        if (_count > 0) {
            NSLog(@"%@...sale %zd", [NSThread currentThread], _count--);
        }
        else {
            NSLog(@"抱歉 票卖完了。。。");
            break;
        }
        
        [self.nsConditionLock unlock];
    }
    
}

// 五. NSCondition
- (void)publicTask5 {
    
    static NSInteger _count = 100;
    
    while(true) {
        
        [self.nsCondition lock];
        
        if (_count > 0) {
            NSLog(@"%@...sale %zd", [NSThread currentThread], _count--);
        }
        else {
            NSLog(@"抱歉 票卖完了。。。");
            break;
        }
        
        [self.nsCondition unlock];
    }
    
}

// 四. dispatch_semaphore
- (void)publicTask4 {
    
    static NSInteger _count = 100;
    
    while(true) {
        
        // 这个函数的作用是这样的，如果dsema信号量的值大于0，该函数所处线程就继续执行下面的语句，并且将信号量的值减1；如果desema的值为0，那么这个函数就阻塞当前线程等待timeout.
        
        // 如果等待的期间desema的值被dispatch_semaphore_signal函数加1了，且该函数（即dispatch_semaphore_wait）所处线程获得了信号量，那么就继续向下执行并将信号量减1。如果等待期间没有获取到信号量或者信号量的值一直为0，那么等到timeout时，其所处线程自动执行其后语句。
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
        dispatch_semaphore_wait(singal, time);
        
        if (_count > 0) {
            NSLog(@"%@...sale %zd", [NSThread currentThread], _count--);
        }
        else {
            NSLog(@"抱歉 票卖完了。。。");
            break;
        }
        
        dispatch_semaphore_signal(singal);
    }
    
}

// 三. pthread_mutex
- (void)publicTask3 {
    
    static NSInteger _count = 100;
    
    while(true) {
        
        pthread_mutex_lock(&lock);
        
            if (_count > 0) {
                NSLog(@"%@...sale %zd", [NSThread currentThread], _count--);
            }
            else {
                NSLog(@"抱歉 票卖完了。。。");
                break;
            }
        
        pthread_mutex_unlock(&lock);
    }
    
}

// 二. @synchronized
- (void)publicTask2 {
    
    static NSInteger _count = 100;
    
    while(true) {
        
        @synchronized (self) {
            if (_count > 0) {
                NSLog(@"%@...sale %zd", [NSThread currentThread], _count--);
            }
            else {
                NSLog(@"抱歉 票卖完了。。。");
                break;
            }
        }
    }
    
}

// 一. NSLock
- (void)publicTask1 {
    
    static NSInteger _count = 100;
    
    while(true) {
        [self.nslock lock];

            if (_count > 0) {
                NSLog(@"%@...sale %zd", [NSThread currentThread], _count--);
            }
            else {
                NSLog(@"抱歉 票卖完了。。。");
                break;
            }
        
        [self.nslock unlock];
    }
    
}

#pragma mark - Lazy Load
- (NSLock *)nslock {
    if (!_nslock) {
        _nslock = [[NSLock alloc] init];
    }
    return _nslock;
}

- (NSCondition *)nsCondition {
    if (!_nsCondition) {
        _nsCondition = [[NSCondition alloc] init];
    }
    return _nsCondition;
}

- (NSConditionLock *)nsConditionLock {
    if (!_nsConditionLock) {
        _nsConditionLock = [[NSConditionLock alloc] init];
    }
    return _nsConditionLock;
}

@end
