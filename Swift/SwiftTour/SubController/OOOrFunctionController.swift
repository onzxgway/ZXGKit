//
//  OOOrFunctionController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/9/18.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

/**
 Swift是面向对象还是函数式的编程语言？
 */
class OOOrFunctionController: FatherController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test()
    }

    /**
     Swift是函数式的编程语言。因为它支持高阶函数map,reduce,filter,filtermap这类去除中间状态和函数调用，更加强调运算结果，而不是中间过程。
     */
    private func test() {
        // 计算字符串的长度
        let stringArray = ["Objective-C", "Swift", "HTML", "CSS", "JavaScript"]
        
        func stringCount(string: String) -> Int {
            return string.count
        }
        
        // map：可以对数组中的每一个元素做一次处理
        print(stringArray.map(stringCount))
        
        print(stringArray.map({string -> Int in
            return string.count
        }))
        
        // $0代表数组中的每一个元素
        print(stringArray.map {
            return $0.count
        })
    }

}

/**
 Swift是面向对象的编程语言。因为它支持类的 封装、继承、多态，从这点上看它与Java这类纯面向对象的语言毫无差别。
 */

// 封装 类可以把属性和行为封装在内部，通过访问控制符设置访问权限。
open class SwPerson {
    public var age: Int = 18
    private func sayHello() -> Void {
        print("Hello world!")
    }
}

// 继承
class ChinaPerson: SwPerson {
    
}

// 多态 父类的指针可以指向子类的对象
let swP: SwPerson = ChinaPerson()

/**
 总结： Swift 既是面向对象的，又是函数式的编程语言。
 */
