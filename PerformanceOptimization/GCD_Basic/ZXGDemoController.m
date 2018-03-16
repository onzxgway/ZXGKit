//
//  ZXGDemoController.m
//  GCD_Basic
//
//  Created by feizhu on 2018/3/15.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGDemoController.h"

//ignore selector unknown warning
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface ZXGDemoController ()
@end

@implementation ZXGDemoController

- (IBAction)runBtnClicked:(id)sender {
    SEL selector = NSSelectorFromString(self.selectorStr);
    if([self respondsToSelector:selector]) {
        SuppressPerformSelectorLeakWarning([self performSelector:selector withObject:nil]);
    }
}

//串行队列
- (void)serialQueue {
    //系统提供  And  手动创建
    dispatch_queue_t queue1 = dispatch_get_main_queue();

    //(队列的名称, 用来识别是串行队列还是并发队列)
    dispatch_queue_t queue2 = dispatch_queue_create("com.app.serial", DISPATCH_QUEUE_SERIAL);

    //dispatch_queue_get_label 获取队列的名称
    NSLog(@"%s__%s", dispatch_queue_get_label(queue1), dispatch_queue_get_label(queue2));
}

//并发队列
- (void)concurrentQueue {
    //系统提供  And  手动创建

    // (队列优先级, 第二个参数flags作为保留字段备用,一般都直接填0)
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_queue_t queue2 = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);

    NSLog(@"%s__%s", dispatch_queue_get_label(queue1), dispatch_queue_get_label(queue2));
}

//主队列
- (void)mainQueue {
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSLog(@"__%s__", dispatch_queue_get_label(queue));
}

//同步执行  它和异步执行本质区别是：是否创建新线程对象。
- (void)sync {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    //队列
    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);
    //任务
    dispatch_block_t block = ^ {
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"%@", [NSThread currentThread]);
    };

    dispatch_sync(queue, block);

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

//异步执行
- (void)async {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    //队列
    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);
    //任务
    dispatch_block_t block = ^ {
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"%@", [NSThread currentThread]);
    };

    dispatch_async(queue, block);

    NSLog(@"__END:%@__", [NSThread currentThread]);
}


//同步执行 ➕ 并发队列
//总结: 不开启新线程，在当前线程中依次执行。
- (void)syncAndConcurrent {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);

    dispatch_sync(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });

    dispatch_sync(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });


    dispatch_sync(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

//异步执行 ➕ 并发队列
//总结: 开启若干新线程，任务并发执行。
- (void)asyncAndConcurrent {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);

    // 第一个任务
    dispatch_async(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第二个任务
    dispatch_async(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第三个任务
    dispatch_async(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

//同步执行 ➕ 串行队列
//总结: 不开启新线程，在当前线程中依次执行。 = 同步执行 ➕ 并发队列
- (void)syncAndSerial {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_SERIAL);

    // 第一个任务
    dispatch_sync(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第二个任务
    dispatch_sync(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第三个任务
    dispatch_sync(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

//异步执行 ➕ 串行队列
//总结: 开启一个新线程，任务依次执行。
- (void)asyncAndSerial {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_SERIAL);

    // 第一个任务
    dispatch_async(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第二个任务
    dispatch_async(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第三个任务
    dispatch_async(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

//同步执行 ➕ 主队列 （在主线程会死锁导致应用crash)
- (void)syncAndMain {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t queue = dispatch_get_main_queue();

    // 第一个任务
    dispatch_sync(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第二个任务
    dispatch_sync(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第三个任务
    dispatch_sync(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

//同步执行 ➕ 主队列（在其它线程中）
- (void)othersyncAndMain {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue = dispatch_get_main_queue();

    dispatch_async(concurrentQueue, ^{
        // 第一个任务
        dispatch_sync(queue, ^{

            //这里线程暂停2秒,模拟一般的任务的耗时操作
            [NSThread sleepForTimeInterval:2];

            NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
        });

        // 第二个任务
        dispatch_sync(queue, ^{

            //这里线程暂停2秒,模拟一般的任务的耗时操作
            [NSThread sleepForTimeInterval:2];

            NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
        });

        // 第三个任务
        dispatch_sync(queue, ^{

            //这里线程暂停2秒,模拟一般的任务的耗时操作
            [NSThread sleepForTimeInterval:2];

            NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
        });
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

//异步执行 ➕ 主队列
- (void)asyncAndMain {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t queue = dispatch_get_main_queue();

    // 第一个任务
    dispatch_async(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第二个任务
    dispatch_async(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });

    // 第三个任务
    dispatch_async(queue, ^{

        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];

        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}


- (void)dispatch_set_target_queue {

}

// 延时执行
// 需要注意的是: dispatch_after函数并不是在指定时间之后才开始执行处理，而是在指定时间之后任务追加到主队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务dispatch_after函数是很有效的。
- (void)dispatch_after {

    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步追加任务到主队列等待执行
        NSLog(@"----执行延时任务---当前线程%@",[NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

// 可以用来初始化一些全局的数据，它能够确保block代码在app的生命周期内仅被运行一次，而且还是线程安全的，不需要额外加锁

/**
    static修饰的 long 类型变量onceToken 初始化的时候为0，线程A 执行block前，先判断onceToken 是否等于0 ?
    1.是就执行Block,并且把变量onceToken的值修改为非0，此时线程B想要执行block的话，也去判断onceToken的值是否等于0 ？
    2.否的话，线程就执行不了block
 */
- (void)dispatchOnce {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    static dispatch_once_t onceToken;
    NSLog(@"%ld", onceToken);
    dispatch_once(&onceToken, ^{
        NSLog(@"----执行单例任务---当前线程%@",[NSThread currentThread]);
        NSLog(@"%ld", onceToken);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

// dispatch_apply按照指定的次数将指定的任务追加到指定的队列中，并等待全部队列任务执行结束。
// 并发队列 异步添加 会创建新的线程，串行队列， 同步添加
- (void)dispatch_apply {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_apply(999, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"执行第%zd次的任务---%@",index, [NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}


- (void)dispatch_group_more {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t queue1 = dispatch_queue_create("com.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("com.abc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue3 = dispatch_queue_create("com.abcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue4 = dispatch_get_main_queue();

    dispatch_block_t block1 = ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    };

    dispatch_block_t block2 = ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    };

    dispatch_block_t block3 = ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    };

    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, queue1, block1);
    dispatch_group_async(group, queue2, block2);
    dispatch_group_async(group, queue3, block3);
    dispatch_group_notify(group, queue4, ^{
        NSLog(@"----执行最后的汇总任务---当前线程%@",[NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

/**
 dispatch_group_enter 标志着一个任务追加到 group，执行一次，相当于 group 中未执行完毕任务数+1
 dispatch_group_leave 标志着一个任务离开了 group，执行一次，相当于 group 中未执行完毕任务数-1。
 当 group 中未执行完毕任务数为0的时候，才会使dispatch_group_wait解除阻塞，以及执行追加到dispatch_group_notify中的任务。

 个人理解：和内存管理的引用计数类似，我们可以假设group也持有一个整形变量，当调用enter时计数加1，调用leave时计数减1，当计数为0时会调用dispatch_group_notify
 */
- (void)dispatch_group {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行最后的汇总任务---当前线程%@",[NSThread currentThread]);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

/**
 dispatch_semaphore:信号量，相当于NSOperationQueue中最大并发数的功能，用来控制线程的数量。

 dispatch_release() 该函数在ARC环境中不可以使用。
 */
- (void)dispatch_semaphore {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"----开始执行第一个任务---当前线程%@",[NSThread currentThread]);

        [NSThread sleepForTimeInterval:2];

        NSLog(@"----结束执行第一个任务---当前线程%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });

    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"----开始执行第二个任务---当前线程%@",[NSThread currentThread]);

        [NSThread sleepForTimeInterval:2];

        NSLog(@"----结束执行第二个任务---当前线程%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });

    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"----开始执行第三个任务---当前线程%@",[NSThread currentThread]);

        [NSThread sleepForTimeInterval:1];

        NSLog(@"----结束执行第三个任务---当前线程%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);
}

// 隔断方法：当前面的写入操作全部完成之后，再执行后面的读取任务。当然也可以用Dispatch Group和dispatch_set_target_queue,只是比较而言 dispatch_barrier_async 会更加顺滑
- (void)dispatch_barrier_async {

    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];

        NSLog(@"----执行第一个写入任务---当前线程%@",[NSThread currentThread]);

    });

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];

        NSLog(@"----执行第二个写入任务---当前线程%@",[NSThread currentThread]);

    });

    dispatch_barrier_async(queue, ^{
        // 等待处理
        [NSThread sleepForTimeInterval:1];

        NSLog(@"----等待前面的任务完成---当前线程%@",[NSThread currentThread]);

    });

    dispatch_async(queue, ^{
        // 第一个读取任务
        [NSThread sleepForTimeInterval:1];

        NSLog(@"----执行第一个读取任务---当前线程%@",[NSThread currentThread]);

    });

    dispatch_async(queue, ^{
        // 第二个读取任务
        [NSThread sleepForTimeInterval:3];

        NSLog(@"----执行第二个读取任务---当前线程%@",[NSThread currentThread]);

    });

    NSLog(@"__END:%@__", [NSThread currentThread]);

}


// 场景：当追加大量处理到Dispatch Queue时，在追加处理的过程中，有时希望不执行已追加的处理。例如演算结果被Block截获时，一些处理会对这个演算结果造成影响。在这种情况下，只要挂起Dispatch Queue即可。当可以执行时再恢复。
// 总结:dispatch_suspend，dispatch_resume 提供了“挂起、恢复”队列的功能，简单来说，就是可以暂停、恢复队列上的任务。但是这里的“挂起”，并不能停止队列上正在运行的任务，也就是如果挂起之前已经有队列中的任务在进行中，那么该任务依然会被执行完毕
- (void)dispatch_suspend {

    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);

    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_SERIAL);

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@", [NSThread currentThread]);
    });

    //此时发现意外情况，挂起队列
    NSLog(@"suspend");
    dispatch_suspend(queue);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //恢复队列
        NSLog(@"resume");
        dispatch_resume(queue);
    });

    NSLog(@"__END:%@__", [NSThread currentThread]);

}

@end
