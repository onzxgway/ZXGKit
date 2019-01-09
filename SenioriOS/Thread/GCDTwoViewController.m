//
//  GCDTwoViewController.m
//  Thread
//
//  Created by 朱献国 on 2019/1/9.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "GCDTwoViewController.h"

@interface GCDTwoViewController ()

@end

static NSString * const URLPath = @"http://svr.tuliu.com/center/front/app/util/updateVersions";

@implementation GCDTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self group_Two];
}

// network
- (void)netLoadSync:(int)taskCount {
    
    NSString *urlstr = [NSString stringWithFormat:@"%@?versions_id=1&system_type=1", URLPath];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    /**
     信号量： 异步变同步。
     */
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSDictionary *infoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"Done taskcount:%d", taskCount);
        dispatch_semaphore_signal(sema);
    }];
    [task resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//    NSLog(@"finish 代码跑完了：%d",taskCount);
}

#pragma mark - =====================================barrier==============================================

#pragma mark - =====================================group==============================================
// Group使用场景：一个界面执行多个网络请求

- (void)group_One {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    /**
     使用注意事项：
        添加在队列中的任务，不能再开启新线程，否则group会失效。
     */
    dispatch_group_async(group, queue, ^{
        NSLog(@"1: %@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"2: %@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"3: %@", [NSThread currentThread]);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all task finished");
    });
    
}

- (void)group_Two {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    /**
     使用注意事项：
     添加在队列中的任务，不能再开启新线程，否则group会失效。
     如果要开启，必须搭配信号量使用。
     */
    dispatch_group_enter(group); // 任务数+1
    dispatch_async(queue, ^{
//        NSLog(@"1: %@", [NSThread currentThread]);
        [self netLoadSync:0];
        dispatch_group_leave(group); // 任务数-1
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
//        NSLog(@"2: %@", [NSThread currentThread]);
        [self netLoadSync:0];
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
//        NSLog(@"3: %@", [NSThread currentThread]);
        [self netLoadSync:0];
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all task finished");
    });
    
}

#pragma mark - =====================================队列==============================================

// 并行队列 + 同步
/**
 1: <NSThread: 0x1d4071f40>{number = 1, name = main}
 2: <NSThread: 0x1d4071f40>{number = 1, name = main}
 3: <NSThread: 0x1d4071f40>{number = 1, name = main}
 4: <NSThread: 0x1d4071f40>{number = 1, name = main}
 */
- (void)concurrentQueue_sync {
    
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        NSLog(@"1: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"2: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"3: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"4: %@", [NSThread currentThread]);
    });
    
}

// 并行队列 + 异步
- (void)concurrentQueue_async {
    
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"1: %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2: %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3: %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"4: %@", [NSThread currentThread]);
    });
    
}

// 主队列 + 同步
/**
 死锁
 */
- (void)mainQueue_sync {
    
    dispatch_queue_t serialQueue = dispatch_get_main_queue();
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"1: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"2: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"3: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"4: %@", [NSThread currentThread]);
    });
    
}

// 主队列 + 异步
/**
 1: <NSThread: 0x1d4071f40>{number = 1, name = main}
 2: <NSThread: 0x1d4071f40>{number = 1, name = main}
 3: <NSThread: 0x1d4071f40>{number = 1, name = main}
 4: <NSThread: 0x1d4071f40>{number = 1, name = main}
 */
- (void)mainQueue_async {
    
    dispatch_queue_t serialQueue = dispatch_get_main_queue();
    
    dispatch_async(serialQueue, ^{
        NSLog(@"1: %@", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"2: %@", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"3: %@", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"4: %@", [NSThread currentThread]);
    });
    
}

// 串行队列 + 同步
/**
 1: <NSThread: 0x1d4071f40>{number = 1, name = main}
 2: <NSThread: 0x1d4071f40>{number = 1, name = main}
 3: <NSThread: 0x1d4071f40>{number = 1, name = main}
 4: <NSThread: 0x1d4071f40>{number = 1, name = main}
 */
- (void)serialQueue_sync {
    
    dispatch_queue_t serialQueue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"1: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"2: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"3: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"4: %@", [NSThread currentThread]);
    });
    
}

// 串行队列 + 异步
- (void)serialQueue_async {
    
    dispatch_queue_t serialQueue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"1: %@", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"2: %@", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"3: %@", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"4: %@", [NSThread currentThread]);
    });
    
}

@end
