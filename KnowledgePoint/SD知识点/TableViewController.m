//
//  ViewController.m
//  SD知识点
//
//  Created by feizhu on 2018/3/7.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "TableViewController.h"
#import "Test.h"

/**
 dispatch_queue_async_safe 异步向指定队列添加指定任务
 */
#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {\
        block();\
    } else {\
        dispatch_async(queue, block);\
    }
#endif

/**
 dispatch_main_async_safe 异步向主队列添加任务

 我们来看看这个宏，按理说我使用dispatch_main_async就可以了，为什么要加入safe呢？那么这个safe主要是解决哪些不安全的问题呢？
 1.在定义宏的时候如果想换行，需要添加 \ 操作符。
 2.如果当前线程已经是主线程了，那么再调用dispatch_async(dispatch_get_main_queue(), block)有可能会出现crash。所以，必须加判断，如果当前线程是主线程，直接调用，如果不是，调用dispatch_async(dispatch_get_main_queue(), block)。
 */
#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *s1 = @"6bcde";
    NSString *s2 = @"924fab";

    /**
     strcmp(<#const char *__s1#>, <#const char *__s2#>)
     功能：比较字符串s1和s2的大小
     说明：当s1  < s2，返回为负数
          当s1 == s2，返回值0
          当s1  > s2，返回正数
     */
    int res = strcmp(s1.UTF8String, s2.UTF8String);
    //    NSLog(@"%d", res);

    /**
     断言
     NSAssert()是一个宏，用于开发阶段调试程序中的Bug，通过为NSAssert()传递条件表达式来断定是否属于Bug，满足条件返回真值，程序继续运行，如果返回假值，则抛出异常，并且可以自定义异常描述。
     NSAssert()是这样定义的：
     #define NSAssert(condition, desc)
     condition是条件表达式，值为YES或NO；desc为异常描述，通常为NSString。当conditon为YES时程序继续运行，为NO时，则抛出带有desc描述的异常信息。NSAssert()可以出现在程序的任何一个位置。
     */
    NSAssert(res < 0, @"res 必须要大于零");

    /**
     dispatch_queue_get_label(<#dispatch_queue_t  _Nullable queue#>)
     功能：获取队列的名称

     dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)
     功能：获取当前所在队列的名称
     */
    /**
    const char * aName = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
    const char * bName = dispatch_queue_get_label(dispatch_get_main_queue());
    const char * cName = dispatch_queue_get_label(dispatch_get_global_queue(0, 0));
    NSLog(@"%s__%s__%s", aName, bName, cName);
     */

    /**
    [self aaa:dispatch_get_main_queue() :^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
     */
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_main_async_safe(^{
//            NSLog(@"bottom:**%@**", [NSThread currentThread]);
        });
    });

    dispatch_main_async_safe(^{
//        NSLog(@"top:**%@**", [NSThread currentThread]);
    });

//    NSLog(@"-------");

    /**
     iOS dispatch_semaphore（信号量）的理解及使用
     1、信号量：就是一种可用来控制访问资源的数量的标识，设定了一个信号量，在线程访问之前，加上信号量的处理，则可告知系统按照我们指定的信号量数量来执行多个线程。

     其实，这有点类似锁机制了，只不过信号量都是系统帮助我们处理了，我们只需要在执行线程之前，设定一个信号量值，并且在使用时，加上信号量处理方法就行了。
     */
//    [self dispatch_semaphore];


    [self urlsession];
}

- (void)dispatch_semaphore {

    // 总结：由于设定的信号值为2，先执行两个线程，等执行完一个，才会继续执行下一个，保证同一时间执行的线程数不超过2
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建信号量，参数：信号量的初值，如果小于0则会返回NULL
    dispatch_semaphore_t signalCount = dispatch_semaphore_create(1);
    //任务1
    dispatch_async(queue, ^{
        //等待降低信号量    (,等待时间)
        dispatch_semaphore_wait(signalCount, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        //提高信号量
        dispatch_semaphore_signal(signalCount);
    });
    //任务2
    dispatch_async(queue, ^{
        //等待降低信号量    (,等待时间)
        dispatch_semaphore_wait(signalCount, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        //提高信号量
        dispatch_semaphore_signal(signalCount);
    });
    //任务3
    dispatch_async(queue, ^{
        //等待降低信号量    (,等待时间)
        dispatch_semaphore_wait(signalCount, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        //提高信号量
        dispatch_semaphore_signal(signalCount);
    });
}

/**
    respondsToSelector:
    注意点：
    类和对象 都可以调用。
    1，对象调用，功能：判断对象是否有 以某个名字命名的 方法体（方法实现）
    不管.h文件中有没有方法的声明，只要.m文件中没有方法实现，则返回NO。有方法实现或则私有方法，则返回YES。
    2，类调用，功能：判断类是否有 以某个名字命名的 方法声明
    不管.m文件中有没有方法实现或者私有方法，只要.h文件中没有声明该方法，就返回NO,
    只要.h文件中声明了该方法，就返回YES,

    instancesRespondToSelector:
    判断的是该类的实例是否包含某方法的实现（不管声明与否），等效于：[对象 respondsToSelector:]。

    isKindOfClass:  用来判断是否是该类或其子类的实例
    isMemberOfClass:用来判断是否是该类的实例

    conformsToProtocol: 用来检查对象是否遵守了指定的协议
    注意点：
    1.在.h文件或则.m文件中的extension遵守都可以检测到
    2.结果与 是否实现了 代理方法无关。


 结论: conformsToProtocol:检查其代理对象是否遵守了协议，或者使用respondsToSelector:检查对象能否响应指定的消息，是避免代理在回调时因为没有实现代理函数而程序崩溃的一个有效的方式。
 */
- (void)test {
    Test *p = [[Test alloc] init];

    NSString *priStr = nil;
//    BOOL res = [p respondsToSelector:@selector(cancel)];
//    BOOL res = [Test respondsToSelector:@selector(cancel)];
//    BOOL res = [Test instancesRespondToSelector:@selector(cancel)];

    BOOL res = [p conformsToProtocol:@protocol(TestDelegate)];

    if (res) {
        priStr = @"YES";
    }
    else {
        priStr = @"NO";
    }

    NSLog(@"__%@__", priStr);
}

- (void)NSOperation {
    /**
     怎样使用NSOperation?

     NSOperation本身是一个抽象类,要使用可以通过以下几个办法:
     1.使用NSInvocationOperation
     2.使用NSBlockOperation
     3.自定义NSOperation的子类
     */

//    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task) object:nil];
//    // 直接调用start方法时,系统并不会开辟一个新的线程去执行任务,任务会在当前线程同步执行.
//    [op start];

    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task0---%@", [NSThread currentThread]);
    }];

    //当NSBlockOperation封装的操作数大于1的时候,就会执行异步操作.
    [op addExecutionBlock:^{
        NSLog(@"task1---%@", [NSThread currentThread]);
    }];

    [op addExecutionBlock:^{
        NSLog(@"task2---%@", [NSThread currentThread]);
    }];

    [op start];

    /**
     怎样使用NSOperationQueue?

     NSOperation的start方法默认是同步执行任务,这样的使用并不多见,只有将NSOperation与NSOperationQueue进行结合,才会发挥出这种多线程技术的最大功效.当NSOperation被添加到NSOperationQueue中后,就会全自动地执行异步操作.

     NSOperationQueue的种类:  操作一但被到添加到队列中,就会自动异步执行
     1.自带主队列 [NSOperationQueue mainQueue] 添加到主队列中的任务都会在主线程中执行

     2.自己创建队列(非主队列)NSOperationQueue *queue = [[NSOperationQueue alloc] init]; 这种队列同时包含串行、并发的功能, 添加到非主队列的任务会自动放到子线程中执行
     */
}

- (void)task {
    NSLog(@"*%@*",[NSThread currentThread]);
}

- (void)bitCalculate {
//    int res = 3 & 5;
    int res = 1 << 2;
    /**
     位运算:
     3     0000 0011
     5     0000 0101

     &     0000 0001
     |     0000 0111
     ^     0000 0110

     位移运算:
     1     0000 0001 = 1
     << 1  0000 0010 = 2
     << 2  0000 0100 = 4
     << 3  0000 1000 = 8
     << 4  0001 0000 = 16
     */
    NSLog(@"%d", res);
}

- (void)urlsession {

//    NSURLSessionDelegate
//    NSURLSessionTaskDelegate
//    NSURLSessionDataDelegate
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@""]];
    [dataTask resume];
}

@end
