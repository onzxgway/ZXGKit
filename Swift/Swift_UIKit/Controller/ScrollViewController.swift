//
//  ScrollViewController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/9/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class ScrollViewController: ControlController {
    
    override lazy var dataSources: [[[String : String]]] = {
        
        let arr = [
            [
                [
                    "UIScrollVieww" : "通过使用 UIScrollView，用户可以滑动或是缩放屏幕，来看单个屏幕无法展示的内容。"
                ],
                [
                    "UITableView" : "Display data in a single column of customizable rows."
                ],
                [
                    "UICollectionView" : "Display nested views using a configurable and highly customizable layout."
                ],
                [
                    "UITextView" : "A scrollable, multiline text region."
                ]
            ],
            ]
        return arr
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "UIScrollView"
    }

}
