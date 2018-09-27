//
//  PropertyObserverController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/9/27.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

/**
 属性观察是指 在当前的类型内部对特定的属性进行监视，并作出响应的行为。
 它是Swift的特性，有两种willSet{}和didSet{}
 */
class PropertyObserverController: FatherController {
    
    var content: String? = "Welcome to china!" {
        willSet {
            print("将标题从\(content ?? "default value")设置为\(newValue ?? "default value")")
        }
        
        didSet {
            print("已将标题从\(oldValue ?? "default value")设置为\(content ?? "default value")")
        }
    }
    /**
     上面这段代码对 content 做了监听。当 content 发生改变前，willSet 对应的作用域将被执行，新的值是 newValue；当 title 发生改变之后，didSet 对应的作用域将被执行，原来的值为 oldValue。这就是属性观察。
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        content = "Hello world!"
    }

}
/**
 注意：初始化方法对属性的设定，以及在 willSet 和 didSet 中对属性的再次设定都不会触发属性观察的调用。
 */
