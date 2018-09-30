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
                    "UIScrollView" : "The base class for controls, which are visual elements that convey a specific action or intention in response to user interactions."
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
