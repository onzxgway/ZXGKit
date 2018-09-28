//
//  ControlController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/9/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class ControlController: BaseController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    lazy var dataSources: [[String : String]] = {
        
        let arr = [
            [
                "UIButton" : "ButtonController"
            ],
            [
                "UIControl" : "ControlController"
            ]
        ]
        
        return arr
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        navigationItem.title = "UIControl"
    }
    

}

extension ControlController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let dic = dataSources[indexPath.row]
        cell.textLabel?.text = Array(dic.keys)[0]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = dataSources[indexPath.row]
        
        let clas: AnyClass
        // 由字符串转为类型的时候  如果类型是自定义的 需要在类型字符串前边加上你的项目的名字！
        if let cla = NSClassFromString("Swift_UIKit." + (dic[Array(dic.keys)[0]] ?? "")) {
            clas = cla
        }
        else {
            clas = BaseController.self
        }
        
        self.navigationController?.pushViewController(clas.alloc() as! UIViewController, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        if section == 0 {
    //            return
    //        }
    //    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "UIView"
//        }
//
//        return ""
//    }
}
