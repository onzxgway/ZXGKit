//
//  CopyonwriteController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/9/26.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

fileprivate struct Model {
    var name: String?
}

/**
 copy-on-write（写时复制）简称COW:
 
 当值类型 比如struct 在复制的时候，复制的新对象和原对象实际上在内存中指向同一个对象。当且仅当对复制后的对象进行修改操作时，才会在内存中重新创建一个新的对象。
 
 具体实现
 在结构体内部存储了一个指向实际数据的引用reference，在不进行修改操作的普通传递过程中，都是将内部的reference的应用计数+1，在进行修改时，对内部的reference做一次copy操作，再在这个复制出来的数据进行真正的修改，防止和之前的reference产生意外的数据共享
 
 优点：
 这样设计使得值类型可以多次复制而无需耗费多余内存，只有变化的时候才会增加开销。因此内存的使用更加高效。
 */
class CopyonwriteController: FatherController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let arrA: [Int] = [1, 2, 3]
//
//        var arrB = arrA
//
//        arrB.append(4)
        
        let arrA = Model(name: "test") // 赋值

        let arrB = arrA

        print("哈哈: \(arrB)")
//        withUnsafePointer(to: &arrA) {
//            print("arrA: \($0)")
//        }
//
//        withUnsafePointer(to: &arrB) {
//            print("arrB: \($0)")
//        }
        
//        print(String(format: "arrA: %p", arrA))
//        print(String(format: "arrB: %p", arrB))
        
        // 由于网上很多有关获取内存地址的方法打印出来有差异，在此，使用lldb命令fr v -R [object] 来查看对象内存结构。
    }
    
}
