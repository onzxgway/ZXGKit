//
//  ClassAndStructController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/9/14.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class Temperature {
    var value: CGFloat = 36.0
}

class Person {
    var temp: Temperature?
    
    func sick() {
        temp?.value = 41.0
    }
}

/**
 类和结构体的区别？
 
 类是引用类型。 结构体是值类型。引用类型在赋值或者传递的时候是实体指针的传递。值类型是实体复制的方式传递。
 */
class ClassAndStructController: FatherController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let a = Person()
        let b = Person()
        let t = Temperature()
        
        a.temp = t
        b.temp = t

        a.sick()
        
        print(b.temp?.value ?? "000")
        /**
         由于 Temperature 是 class ，为引用类型，故 a 的 temp 和 b 的 temp指向同一个对象。a 的 temp修改了，b 的 temp 也随之修改。这样 A 和 B 的 temp 的值都被改成了 41.0。如果将 Temperature 改为 struct，为值类型，则 A 的 temp 修改不影响 B 的 temp。
         */
    }

}
/**
 内存中，引用类型诸如类实例是在heap内存中的，而值类型诸如结构体是在stack中进行存储和操作的。相比于栈上的操作，堆中的操作更加复杂耗时，所以苹果官方推荐使用结构体，提高app运行的性能。
 
 class优势：
 1.class 可以继承，子类可以得到父类的所有成员。
 2.可以被多个指针引用。
 3.可以用 deinit 来释放资源
 
 struct优势：
 1.结构较小，适用于复制操作，相比于一个 class 的实例被多次引用更加安全。
 2.无须担心内存 memory leak 或者多线程冲突问题
 */

