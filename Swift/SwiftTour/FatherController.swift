//
//  FatherController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/7/20.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class FatherController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackButton()
    }

    func setBackButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
    }
    
 
}


extension FatherController {
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
