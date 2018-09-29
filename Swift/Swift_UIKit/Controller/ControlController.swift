//
//  ControlController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/9/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class ControlController: ViewController {

    override lazy var dataSources: [[[String : String]]] = {

        let arr = [
            [
                [
                    "UIButton" : "A control that executes your custom code in response to user interactions."
                ]
            ],
            ]

        return arr
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Controls"
    }

}

extension ControlController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
}
