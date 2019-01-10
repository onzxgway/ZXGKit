//
//  GCDTwoViewController.m
//  Thread
//
//  Created by 朱献国 on 2019/1/9.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "GCDTwoViewController.h"
#import "Person.h"

@interface GCDTwoViewController () {
    NSMutableArray *_safeAry;
    dispatch_queue_t rwQueue;
}
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

static NSString * const URLPath = @"http://svr.tuliu.com/center/front/app/util/updateVersions";

@implementation GCDTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _safeAry = [NSMutableArray array];
//    [_safeAry addObject:@"0"];
//    [_safeAry addObject:@"1"];
//    [_safeAry addObject:@"2"];
//    [_safeAry addObject:@"3"];
    rwQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    [self testRWAry];
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

/* 读写数组mutableAry,如果开几个线程来操作数组
 1 写数组（移除index=0对象）， 2 写数组（移除index=0的对象） ／／ 有问题
 1 读数组 ， 2 读数组 ／／ 没问题
 1 读数组    2写数组
 只要涉及到写操作（要做保护）
 */
- (void)testRWAry {
    
//    dispatch_queue_t queue = dispatch_queue_create("testRWAry", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 20; i++) {
//
//        // 写
//        dispatch_async(queue, ^{
////            [self addObject:[NSString stringWithFormat:@"%d", i + 4]];
//            [NSThread sleepForTimeInterval:0.05];
//            [self.dict setObject:@(i) forKey:[@(i) stringValue]];
//        });
//
////        // 读
////        dispatch_async(queue, ^{
////            NSLog(@"%d::%@", i, [self indexTo:i]);
////        });
//    }
//
//    dispatch_barrier_async(queue, ^{
////        for (int i = 0; i < self.dict.count; i++) {
////            NSLog(@"%d::%@", i, [self indexTo:i]);
////        }
//
//        NSLog(@"%@", self.dict);
//    });
    
    Person *p = [[Person alloc] init];
    [self updateContact:p contacts:self.dict];
    
}

- (void)updateContact:(Person *)person contacts:(NSDictionary *)contacts {
    
//    for (NSInteger i = 0; i < contacts.allKeys.count; ++i) {
//        NSString *key = [contacts.allKeys objectAtIndex:i];
//        NSString *value = [contacts objectForKey:key];
//        dispatch_async(rwQueue, ^{
//            [person setProperty:key email:value];
//            NSLog(@"%@", person);
//        });
//    }
//    dispatch_barrier_async(rwQueue, ^{
//        NSLog(@"==> Final %@",person);
//    });
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i = 0; i < contacts.allKeys.count; ++i) {
        NSString *key = [contacts.allKeys objectAtIndex:i];
        NSString *value = [contacts objectForKey:key];
        
        dispatch_group_async(group, rwQueue, ^{
            [person setProperty:key email:value];
            NSLog(@"%@", person);
        });
        
    }
    
    dispatch_group_notify(group, rwQueue, ^{
        NSLog(@"==> Final %@", person);
    });
}

// 写 保证只有一个在操作（避免了同时多个写操作导致的问题）
- (void)addObject:(NSString *)object {
    
//    dispatch_barrier_async(rwQueue, ^{
        if (object != nil) {
            [_safeAry addObject:object];
        }
//    });
    
}

// 主队列中的任务必须由主线程执行
// 注意同步，因为业务关系，必须马上数据
- (NSString *)indexTo:(NSInteger)index {
//    __block NSString *result = nil;
    NSString *result = nil;
//    dispatch_sync(rwQueue, ^{
        if (index < _safeAry.count) {
            result = _safeAry[index];
        }
//    });
    return result;
}

- (NSMutableDictionary *)dict {
    
    if (!_dict) {
        _dict = [@{@"Leijun" : @"leijun@mi.com",
                   @"Luoyonghao" : @"luoyonghao@smartisan.com",
                   @"Yuchengdong" : @"yuchengdong@huawei.com",
                   @"Goodguy" : @"crafttang@gmail.com"} mutableCopy];
    }
    return _dict;
    
}

#pragma mark - =====================================barrier==============================================
/**
 dispatch_barrier_async 与 dispatch_barrier_sync
 
 共同点：
 1、等待在它前面插入队列的任务先执行完
 2、等待他们自己的任务执行完再执行后面的任务
 不同点：
 1、dispatch_barrier_sync将自己的任务插入到队列的时候，需要等待自己的任务结束之后才会继续插入被写在它后面的任务，然后执行它们
 2、dispatch_barrier_async将自己的任务插入到队列之后，不会等待自己的任务结束，它会继续把后面的任务插入到队列，然后等待自己的任务结束后才执行后面任务。
 
 用途：
 在多个异步操作完成之后，统一的对非线程安全的对象进行更新操作
 */

// 栅栏
- (void)barrier_One {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskOne");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskTwo");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskThree");
    });
    
    dispatch_barrier_async(queue, ^{ // 分界线里面，queue可以看作是串行的，当前只能执行barrier里面的task
        NSLog(@"分界线里面的任务");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskFour");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskFive");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskSix");
    });
}

// 栅栏
- (void)barrier_Two {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskOne");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskTwo");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskThree");
    });
    
    dispatch_barrier_sync(queue, ^{ // 分界线里面，queue可以看作是串行的，当前只能执行barrier里面的task
        NSLog(@"分界线里面的任务");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskFour");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskFive");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskSix");
    });
}

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
