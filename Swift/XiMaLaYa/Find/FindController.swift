//
//  FindController.swift
//  XiMaLaYa
//
//  Created by 朱献国 on 2018/6/23.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class FindController: BaseViewController {

    // MARK: - LiftCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ClickMe", style: .plain, target: self, action: #selector(rightClicked))
    }
    
    @objc func rightClicked() {
        navigationController?.pushViewController(PlayController(), animated: true)
    }
    
}


extension FindController {
    
    func createView() -> Void {
        navigationItem.title = "发现";
        
        let controllers = [RecommendController(), CategoryController(), BroadcastController(), LiveController(), VipController()];
        
        for controller in controllers {
            self.addChildViewController(controller)
        }
    }
    
}
