//
//  SonController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/7/20.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class SonController: FatherController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        
        
    }

    override func back() {
        super.back()
    }

}

/**
 子类重写父类的方法注意:
 
 1.子类的extension中只能重写父类extension中的方法
 2.子类中能重写父类中, 父类extension中的方法
 3.子类 和 子类extension 同时重写父类extension中的方法,,,子类中生效
 */

extension SonController {
    
//    override func back() {
//        super.back()
//    }
    
}


extension SonController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}







