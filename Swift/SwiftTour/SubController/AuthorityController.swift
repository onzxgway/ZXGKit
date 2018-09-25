

//
//  AuthorityController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/9/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

/**
 请说明并比较以下关键词：Open, Public, Internal, fileprivate, Private
 
 swift的五个级别的访问控制权限，从高到底依次为 Open, Public, Internal, fileprivate, Private。
 */
class AuthorityController: FatherController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

/**
 遵循的基本原则: 高级别的变量 不容许被定义为 低级别的变量 的成员变量。比如一个 private 的 class 中不能含有 public 的 String。反之，低级别的变量 却可以定义在 高级别的变量中。比如 public 的 class 中可以含有 private 的 Int。
 
 open 具备最高的访问权限。其修饰的类和方法可以在任意 Module 中被访问和重写；它是 Swift 3 中新添加的访问权限。
 public 的权限仅次于 Open。与 Open 唯一的区别在于它修饰的对象可以在任意 Module 中被访问，但不能重写。
 Internal 是默认的权限。它表示只能在当前定义的 Module 中访问和重写。
 fileprivate 也是 Swift 3 新添加的权限。其被修饰的对象只能在当前文件中被使用。例如它可以被一个文件中的不同 class，extension，struct 共同使用。
 private 是最低的访问权限。它的对象只能在定义的作用域内及其对应的扩展内使用。离开了这个对象，即使是同一个文件中的其他对象，也无法访问。
 */
