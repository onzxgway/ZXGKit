//
//  ViewController.m
//  DesignatedInitializer
//
//  Created by feizhu on 2018/2/27.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "Rectangle.h"
#import "Square.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 Designated Initializer (指定初始化函数) 通常是参数最多的那个初始化函数。
 便利初始化函数 可以让我们比较的创建对象，同时又可以保证类的成员变量被设置为默认的值。

 所有对象都是要初始化的，而且很多情况下，对象在初始化时是需要接收额外的参数，这就可能会提供多个初始化方法。根据规范，通常选择一个接收参数最多的初始化方法作为指定初始化方法，真正的数据分配和其他相关初始化操作在这个方法中完成。而其他的初始化方法则作为便捷初始化方法去调用这个指定初始化方法。这样当实现改变时，只要修改指定初始化方法就可以了。便捷初始化方法接收的参数更少，它会在内部调用指定初始化方法时，直接设置未接收参数的默认值。便捷初始化方法也可以不直接调用指定初始化方法，它可以调用其他便捷初始化方法，但不管调用几层，最终是要调用到指定初始化方法的，因为真正的实现操作是在指定初始化方法中完成的

 不过需要注意，为了享受这些“便利”，我们需要遵守一些规范。

 1.声明指定初始化函数的后面加上宏 "NS_DESIGNATED_INITIALIZER",
 作用: 1.当在接口中指定初始化方法的后面加上该宏，编译器就会检查我们实现的初始化调用链是否符合规则，并提示相应的警告，增强代码的健壮性。2.起到了标明指定初始化方法的注释作用。
 说明: 在同一个类中，我们可以拥有多个Designated Initializer, 每一个Designated Initializer负责使用一种类型的数据源进行初始化。
 
 2.所有的便利初始化函数最终都会调到该类的指定初始化函数(唯一的初始化出口).

 总结
 其实可以归纳为两点：

 1.便利初始化函数只能调用自己类中的其他初始化方法
 2.指定初始化函数才有资格调用父类的指定初始化函数

 3.指定初始化函数规则只能用来保证对象的创建过程是从根类到子类依次初始化所有成员变量
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    Rectangle *rectangle = [[Rectangle alloc] initWithWidth:11 Height:22];
    NSLog(@"%.f",rectangle.width);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
