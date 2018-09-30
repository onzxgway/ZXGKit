//
//  ControllController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/9/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

/**
 是所有默认可以与用户交互类的 基类
 */
class ControllController: BaseController {
    
    private lazy var control: UIControl = {
        let img = UIControl(frame: CGRect(x: 52, y: 88, width: 210, height: 66))
        img.backgroundColor = .white
        view.addSubview(img)
        return img
    }()

    override func setAttribute() {
        control.addTarget(self, action: #selector(clicked), for: .touchDown)
        
//        let names = control.actions(forTarget: self, forControlEvent: .touchDown)
//        print(names!)
        
        control.removeTarget(self, action: #selector(clicked), for: .touchDown)
        
        control.sendAction(#selector(clicked), to: self, for: nil)
    }
    
    @objc private func clicked() {
        print("clicked")
    }
}
