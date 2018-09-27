
//
//  ReallyController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/9/27.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class ReallyController: FatherController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        modifyStruct()
//
//        let res = add(888)(4)
//        print(res)
//
        print(evenSquareNums(from: 0, to: 100))
        
//        useMap()
        
//        useFiler()
    }


}

// MARK: - 高阶函数map和flatMap的使用

/**
 点在：
 
 关键词：#函数式编程
 */
extension ReallyController {
    private func useMap() {
        let numbers = [1, 2, 3, 4]
        let result = numbers.map { $0 + 2 }
        /**
         大家可以看一下，map方法接受的是一个闭包参数，然后它会遍历整个numbers数组，并对数组中每一个元素执行闭包中定义的操作。相当于对数组中的所有元素做了一个映射。
         */
        print(result)
        
        let array1 = ["a", "b", "c", "d"]
        let array2 = array1.map { "NO.\($0)" }
        print(array2)
    }
}

// MARK: - 高阶函数filer和的使用

/**
 点在：
 filer：过滤，可以对数组中的元素按照某种规则进行一次过滤
 关键词：#函数式编程
 */
extension ReallyController {
    private func useFiler() {
        let numbers = [1, 2, 3, 4]
        let result = numbers.filter {
            $0 % 2 == 0
        }
        print(numbers)
        print(result)
    }
}

// MARK: - 实现一个函数。求 0 到 100（包括0和100）以内是偶数并且恰好是其他数字平方的数。

/**
 点在：
 Swift 有函数式编程的思想。其中 flatMap, map, reduce, filter 是其代表的方法。本题中考察了 map
 和 filter 的组合使用。相比于一般的 for 循环，这样的写法要更加得简洁漂亮。
 关键词：#函数式编程
 */
extension ReallyController {
    private func evenSquareNums(from: Int, to: Int) -> [Int] {
//        var res = [Int]()
        
//        for num in from...to where num % 2 == 0 {
//            if (from...to).contains(num * num) {
//                res.append(num * num)
//            }
//        }
        
//        return res
        
        return (from...to).map { $0 * $0 }.filter { $0 % 2 == 0 }
        
    }
}

// MARK: - 实现一个函数。输入是任一整数，输出要返回输入的整数 + 2

/**
 点在：
 Swift 中的Currying（柯里化） 特性是函数式编程思想的体现。
 它将接受多个参数的方法进行变形，并用高阶函数的方式进行处理，使整个代码更加灵活。
 关键词：#柯里化
 */
extension ReallyController {
    private func add(_ num: Int) -> (Int) -> Int {
        return { val in
            return num + val
        }
    }
}

// MARK: - 用 Swift 实现 或（||）操作
extension ReallyController {
    
    
    
}

// MARK: - 结构体中修改成员变量的方法
extension ReallyController {
    private func modifyStruct() -> Void {
        
        var dog = Dog(name: "Little Yellow")
        dog.log()
        
        dog.addName("Little Blue")
        dog.log()
    }
}

// 注意，在设计协议的时候，由于protocol 可以被 class 和 struct 或者 enum 实现，故而要考虑是否用 mutating 来修饰方法。
protocol Pet {
    var name: String { set get }
}

/**
 结构体中的函数 不能修改自己的成员变量。 除非在函数的定义中加上 mutating 修饰符。
 */
fileprivate struct Dog: Pet {
    var name: String
    
    mutating fileprivate func addName(_ newName: String) {
        name = newName;
    }
    
    fileprivate func log() {
        print(name)
    }
}
