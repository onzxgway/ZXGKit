//
//  ViewController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/7/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clicked))
    }

    @objc func clicked() {
        self.navigationController?.pushViewController(SonController(), animated: true)
    }


}

