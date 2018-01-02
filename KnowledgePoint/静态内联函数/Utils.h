//
//  Utils.h
//  KnowledgePoint
//
//  Created by feizhu on 2017/10/26.
//  Copyright © 2017年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserDefaults [NSUserDefaults standardUserDefaults]
/**
 在iOS中的一些三方框架中,static inline是经常出现的关键字组合.
 static：修饰函数和修饰全局属性的作用是一样的，都是缩小作用域为当前文件的效果（可以在程序内有多个同名的定义，只要不位于同一个文件内即可）。
 inline：内联函数，作用是替代宏。
 
   优点相比于函数:
 
     1)inline函数避免了普通函数的,在汇编时必须调用call的缺点:取消了函数的参数压栈，减少了调用的开销,提高效率.所以执行速度确比一般函数的执行速度要快.
     
     2)集成了宏的优点,使用时直接用代码替换(像宏一样);
     
   优点相比于宏:
     
     1)避免了宏的缺点:需要预编译.因为inline内联函数也是函数,不需要预编译.
     
     2)编译器在调用一个内联函数时，会首先检查它的参数的类型，保证调用正确。然后进行一系列的相关检查，就像对待任何一个真正的函数一样。这样就消除了它的隐患和局限性。
     
     3)可以使用所在类的保护成员及私有成员。
 
 */

static inline NSString * getUserId()
{
    return [UserDefaults objectForKey:@"UId"];
}

static inline void setUserId(NSNumber *userId)
{
    [UserDefaults setObject:userId forKey:@"UId"];
    [UserDefaults synchronize];
}

/**
 inline内联函数的说明
 
 1.内联函数只是我们向编译器提供的申请,编译器不一定采取inline形式调用函数.
 2.内联函数不能承载大量的代码.如果内联函数的函数体过大,编译器会自动放弃内联.
 3.内联函数内不允许使用循环语句或开关语句.
 4.内联函数的定义须在调用之前.
 */

@interface Utils : NSObject

@end
