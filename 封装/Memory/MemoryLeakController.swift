//
//  MemoryLeakController.swift
//  Memory
//
//  Created by 朱献国 on 2018/10/8.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

// 产生内存泄露的原因

/**
 一、三方框架使用不当
 
 二、Block循环引用
 
 三、delegate循环引用
 
 四、NSTimer循环引用
 
 五、非OC对象内存处理
 
 六、地图类处理
 
 七、大次数循环内存暴涨问题
 */

class MemoryLeakController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
