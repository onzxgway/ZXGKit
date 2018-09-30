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
                    "UIControll" : "The base class for controls, which are visual elements that convey a specific action or intention in response to user interactions."
                ],
                [
                    "UIButton" : "A control that executes your custom code in response to user interactions."
                ],
                [
                    "UITextField" : "An object that displays an editable text area in your interface."
                ],
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
