//
//  main.m
//  XibSBCode
//
//  Created by feizhu on 2018/2/26.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 使用 xib 和 storyboard 的缺点:

 1.xib 和 storyboard 不太方便做界面的迭代修改，比如我们想统一修改界面中所有按钮的字体大小，那么在 xib 和 storyboard 只能一个一个手工修改，而如果是代码编写的，则只需要改一个工厂方法的实现即可。
 2.xib 版本管理是比较麻烦。storyboard 实际上的多个 xib 的集合，所以更容易让多人编辑产生冲突。冲突解决起来比较麻烦。
 3.不同版本的 Xcode，每次打开xib 和 storyboard必定会修改这个文件。
 4.对于复杂的 App，storyboard 的性能会比较差。

 优点: 所见即所得
 */

/**
 如何选择:

 对于复杂的、动态生成的界面，使用手工编写界面。
 对于需要统一风格的按钮或UI控件，建议使用手工用代码来构造。方便之后的修改和复用。
 对于需要有继承或组合关系的 UIView 类或 UIViewController 类，建议用代码手工编写界面。
 对于那些简单的、静态的、非核心功能界面，可以考虑使用 xib 或 storyboard 来完成。

 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
