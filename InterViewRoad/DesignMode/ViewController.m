//
//  ViewController.m
//  DesignMode
//
//  Created by onzxgway on 2019/3/20.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 
 设计模式：前人总结的、面对开发中常见问题的解决方案。简单说设计模式就是开发中的模板和套路。
 
         熟练掌握设计模式，可以提高开发效率，节省开发时间。这样，我们就可以站在前人的肩膀上，去研究解决那些具有挑战性和未曾解决过的问题。
 
 
 说说你平常开发中用到的设计模式？
 
 iOS 开发中的设计模式有很多，一般最常见的有这 7 种：
 
    1.MVC：是应用的一种基本架构，主要目的是将不同的代码归于不同的模块，做到低耦合、代码分配合理、易于扩展维护的目的。
 
        MVC是 model-view-controller 的简称。是苹果官方推荐的App的架构模式，最早接触最经典的设计模式。他把App分割为三个部分，model层负责处理数据模型，view层负责UI,controller层负责其他两个模块的桥梁作用。它将数据从model层传递到view层展示，同时将view层的交互传递到model层去修改数据。苹果的 MVC 的特点是 Model 和 View 层是相互独立的。
        缺点是：由于controller承担的任务较重，实际开发中很多开发者直接将 View 和 model 部分的代码全部塞到了 ViewController 类中，造成了它们的高度耦合。
 
    2.装饰模式（Decorator）：它可以在不修改原代码的基础上进行拓展。注意它与继承最大的区别是：继承时，子类可以修改父类的行为，而装饰模式不希望如此。
 
     装饰模式是在不改变原封装的前提下，为对象动态添加新功能的模式。在 Objective-C 中，它的实现形式为 Category 和 Delegation。
 
     Category 的好处之一是可以给类增加新的方法，它也可以利用动态特性增加新的变量。同时，Category的出现也减轻了类的负担，我们可以利用它将代码分散开来。它的文件名一般为“类名+扩展名”
     Delegation 是程序中一个对象代表另一个对象，或者一个对象与另外一个对象协同工作的模式。一般配合 protocol 使用，例如 tableView 的 UITableViewDataSource 和 UITableViewDelegate 就是典型的 Delegation 模式。注意，delegate 一般声明为 weak 以防止循环引用。
 
    3.适配器模式（Adapter）：将一个类的接口转化为另一个类的接口，使得原本互不兼容的类可以通过接口一起工作。
 
      外观模式（Façade）：用一个公共接口来连接多个类或其他数据类型。公共接口让多个类互相之间保持独立，解耦性良好。同时使用接口时，外部无需理解其背后复杂的逻辑。另外就算接口背后的逻辑改变也不影响接口的使用。
 
    4.单例模式（Singleton）：单例模式保证对于一个特有的类，只有一个公共的实例存在。它一般与懒加载一起出现，只有被需要时才会创建。单例模式的例子有 UserDefaults.standard，UIApplication.shared，UIScreen.main。
 
         单例模式在创建过程中，要保证实例变量只被创建一次。整个开发中需要特别注意线程安全，即使在多线程情况下，依然只初始化一次变量。
 
         Objective-C 中，是用 GCD 来保证这一点的。示例代码如下：
 
         + (instanceType)sharedManager {
            static Manager *sharedManager = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                sharedManager = [[Manager alloc] init];
            });
            return sharedManager;
         }
 
    5.观察者模式（Observer）定义对象间的一种一对多依赖关系，使得每当一个对象状态发生改变时，其相关依赖对象皆得到通知并被自动更新。在 iOS 中的典型实现是 NotificationCenter 和 KVO。
        添加的都要移除。
 
    6.备忘录模式（Memento）：在不破坏封装性的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。这样以后就可以将该对象回复到保存之前的状态。
 
        备忘录模式是一种保存对象当前的状态，并在日后可以回复的模式。注意，它不会破坏对象的封装；也就是说，私有数据也能被保存下来。
 
        其最经典的使用方法就是用 UserDefaults 来读写，同时配合栈可以存储一系列状态。它经常用于初始化、重启、App 前后台状态改变等地方。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
