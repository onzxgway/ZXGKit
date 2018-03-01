//
//  Rectangle.m
//  DesignatedInitializer
//
//  Created by feizhu on 2018/2/27.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "Rectangle.h"


@implementation Rectangle

/**
//2.如果子类提供了指定初始化函数，那么一定要重写所有父类的指定初始化函数。
原因：
 当子类定义了自己的指定初始化函数之后，父类的指定初始化函数就必须“退化”为子类的便利初始化函数。这一条规范的目的是: “保证子类新增的变量能够被正确初始化。”

 因为我们没法限制使用者通过什么方式创建子类，例如我们在创建UIViewController的时候可以使用如下三种方式：
 UIViewController *vc = [[UIViewController alloc] init];
 UIViewController *vc = [[UIViewController alloc] initWithNibName:nil bundle:nil];
 UIViewController *vc = [[UIViewController alloc] initWithCoder:xxx];
 如果子类没有重写父类的所有指定初始化函数，而使用者恰好直接使用父类的初始化函数初始化对象，那么子类的成员变量就可能存在没有正确初始化的情况
 */
- (instancetype)init {
    return [self initWithWidth:5 Height:5];
}

- (instancetype)initWithWidth:(float)width Height:(float)height {
    //1.子类如果有指定初始化函数，那么指定初始化函数实现时必须调用它的直接父类的指定初始化函数。
    self = [super init];
    if (self) {
        _width = width;
        _height = height;
    }
    return self;

}

//3.如果子类有指定初始化函数，那么便利初始化函数必须调用自己的其它初始化函数(包括指定初始化函数以及其他的便利初始化函数)，不能调用super的初始化函数。
- (instancetype)initWithWidth:(float)width {
   return [self initWithWidth:width Height:5];
}

@end
