//
//  FindController.swift
//  XiMaLaYa
//
//  Created by 朱献国 on 2018/6/23.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class FindController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ClickMe", style: .plain, target: self, action: #selector(rightClicked))
    }
    
    @objc func rightClicked() {
        navigationController?.pushViewController(PlayController(), animated: true)
    }

}
