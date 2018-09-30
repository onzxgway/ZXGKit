//
//  ViewController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/9/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 64
        return tableView
    }()
    
    lazy var dataSources: [[[String : String]]] = {
        
        let arr = [
            [
                [
                    "UILabel" : "A view that displays one or more lines of read-only text, often used in conjunction with controls to describe their intended purpose."
                ]
            ],
            [
                [
                    "UIImageView" : "An object that displays a single image or a sequence of animated images in your interface."
                ]
            ],
            [
                [
                    "UIScrollView" : "A view that allows the scrolling and zooming of its contained views."
                ],
                [
                    "UIStackView" : "A streamlined interface for laying out a collection of views in either a column or a row."
                ]
            ],
            [
                [
                    "UIControl" : "The base class for controls, which are visual elements that convey a specific action or intention in response to user interactions."
                ]
            ],
        ]
        
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        navigationItem.title = "UIView"
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let dic = dataSources[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = Array(dic.keys)[0]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.text = Array(dic.values)[0]
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 8)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .byCharWrapping
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dic = dataSources[indexPath.section][indexPath.row]
        
        let clas: AnyClass
        // 由字符串转为类型的时候  如果类型是自定义的 需要在类型字符串前边加上你的项目的名字！
        
        var name = Array(dic.keys)[0]
        name = String(name.suffix(name.count - 2))
        if let cla = NSClassFromString("Swift_UIKit." + name + "Controller") {
            clas = cla
        }
        else {
            clas = BaseController.self
        }
        
        let ctrl = clas.alloc() as! UIViewController
        ctrl.navigationItem.title = Array(dic.keys)[0]
        
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Text Views"
        }
        else if section == 1 {
            return "Content Views"
        }
        else if section == 2 {
            return "Container Views"
        }
        else if section == 3 {
            return "Controls"
        }
        
        
        return ""
    }
}
