//
//  ViewController.m
//  零碎知识点
//
//  Created by feizhu on 2018/3/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "ZXGPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self two];
}

- (IBAction)myClicked:(id)sender {
}
/**
 属性 与 成员变量的区别？
 property修饰的属性，作用有：1.生产_成员变量。2.生产该_成员变量的setter/getter方法。
 成员变量才是真正保存数据的。
 */
- (void)one {
    ZXGPerson *p = [[ZXGPerson alloc] init];
    NSLog(@"%@", p.name);
}

/**
 作用： 为了解决32-bit迁移到64-bit的兼容问题。

 OC中 float 与 CGFloat 的区别？
 在32位系统中，CGFloat为float,在64位系统中，CGFloat为double,

 OC中 int 与 NSInteger 有何不同啊？
 在32位系统中,NSInteger 为 int 或者 unsigned int，
 在64位系统中,NSInteger 为 long 或者 unsigned long
 */
- (void)two {
    ZXGPerson *p = [[ZXGPerson alloc] init];
    NSLog(@"%@", p.name);
}


@end
