//
//  main.m
//  block循环引用
//
//  Created by san_xu on 2017/10/11.
//  Copyright © 2017年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>


void learn () {
    //2种解决方案
    //一，提前预防 局部变量weaSelf
    __weak typeof(self) weaSelf = self;//__weak修饰，self的引用计数不加一.
    //    __weak ViewController * weakSelf = self;
    [p setBblockb:^{ //不构成循环引用，不需要weakself和strongself.
        __strong typeof(weaSelf) strongSelf = weaSelf;
        strongSelf.view.backgroundColor = [UIColor purpleColor];
    }];
    
    //二，事后补救
    p.bblockb = nil;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
