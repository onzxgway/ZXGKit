//
//  GCDOneViewController.m
//  Thread
//
//  Created by onzxgway on 2019/1/16.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "GCDOneViewController.h"

@interface GCDOneViewController ()

@end

@implementation GCDOneViewController {
    NSThread *_theard;
}

/**
 pthread 和 NSThread有个问题，假如当前移动设备是4核的，同一时刻执行8条线程是性能最优的方案。（少于8条线程不能发挥最佳性能，多于8条的话，由于资源竞争和线程切换反而使性能下降），你在项目中同一时刻创建了8条线程执行任务，但是项目中会用到三方啊等等，可能三方在这个时刻也创建了若干条线程，那此刻总线程数是未知的，所以pthread 和 NSThread不能很好的使用多核发挥最佳性能。
 
 GCD 多核优化技术，应运而生。你只需要关注队列和任务，不用直接操作线程对象本身，系统底层维护了一个线程池（移动设备是几核的，同一时刻执行几条线程是性能最优的方案，GCD会去判断）。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"NSThread";
    
    [self theard];
}

- (void)theard {
    
    _theard = [[NSThread alloc] initWithTarget:self selector:@selector(taskOne) object:nil];
    
}

- (void)taskOne {
    NSLog(@"%@", [NSThread currentThread]);
}

@end
