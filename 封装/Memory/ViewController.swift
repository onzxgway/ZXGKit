//
//  ViewController.swift
//  Memory
//
//  Created by 朱献国 on 2018/10/8.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

let global: String = "abc" // 初始化之后的 全局变量 data段

class ViewController: UIViewController {
    
    static var temp: Int?  // 未初始化的 静态变量 bss段

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "内存管理"
    }


}

// --------- 理解内存管理的第一步   内存区域的划分 --------- //

// MARK: - 内存区域划分
/**
 1.栈区 stack 存放的是局部变量或者实参 由系统进行管理的包括分配和回收等。（出作用域后系统释放）
 
 2.堆区 heap 存放的是 alloc + init 创建的对象 由程序员手动管理，精确的申请内存，释放内存匹配是良好程序的基本要素。
 
  比较：栈是系统数据结构，对应线程也是唯一的，优点是安全高效，缺点是使用数据不灵活必须［先进后出］
       堆优点是使用数据灵活方便，适应面广泛，但是效率有一定降低。
 
 3.全局区\静态区 存放的是未初始化的全局变量和静态变量，由系统进行管理。（程序结束后系统释放）
 
 4.常量区 存放的是已初始化的全局变量、静态变量和常量，由系统进行管理。（程序结束后系统释放）
 
 5.代码区 存放代码的二进制文件，由系统进行管理。（程序结束后系统释放）
 */
extension ViewController {
    
    private func learn(para: String) {
        // 实参 栈区
        
        let a: Int  // 局部变量 栈区
        let b: Int = 2
        
        let v = UIView(frame: .zero) // 局部变量v在栈区  UIView(frame: .zero)在堆区
        
    }
    
}


// --------- 理解内存管理的第二步  内存管理的原理  --------- //

/**
 不管是OC还是Swift,其内存管理方式都是基于引用计数的。
 
 引用计数是一个简单有效的管理对象生命周期的方式。它的原理是 当新建一个对象的时候，它的引用计数为1，当有一个新的指针指向这个对象的时候，其引用计数加一，当某个指针不再指向这个对象的时候，其引用计数减一，当对象的引用计数变为0的时候，表示该对象不再被任何指针指向了，这个时候该对象将被销毁，回收内存。
 
 引用计数的最大的瑕疵就是他不能很好地解决循环引用的问题。
 */





