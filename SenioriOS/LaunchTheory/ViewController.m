//
//  ViewController.m
//  LaunchTheory
//
//  Created by 朱献国 on 2018/10/15.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CFRunLoopObserverRef ref = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        if (activity == kCFRunLoopEntry) {
            NSLog(@"kCFRunLoopEntry");
        }
        if (activity == kCFRunLoopBeforeTimers) {
            NSLog(@"kCFRunLoopBeforeTimers");
        }
        if (activity == kCFRunLoopBeforeSources) {
            NSLog(@"kCFRunLoopBeforeSources");
        }
        if (activity == kCFRunLoopBeforeWaiting) {
            NSLog(@"kCFRunLoopBeforeWaiting");
        }
        if (activity == kCFRunLoopAfterWaiting) {
            NSLog(@"kCFRunLoopAfterWaiting");
        }
        if (activity == kCFRunLoopExit) {
            NSLog(@"kCFRunLoopExit");
        }
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), ref, kCFRunLoopCommonModes);
}


@end
