//
//  ViewController.m
//  SD知识点
//
//  Created by feizhu on 2018/3/7.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"

#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {\
        block();\
    } else {\
        dispatch_async(queue, block);\
    }
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

@interface ViewController ()

@end

@implementation ViewController

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
    NSLog(@"%d", res);

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
            NSLog(@"bottom:**%@**", [NSThread currentThread]);
        });
    });

    dispatch_main_async_safe(^{
        NSLog(@"top:**%@**", [NSThread currentThread]);
    });

    NSLog(@"-------");


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
