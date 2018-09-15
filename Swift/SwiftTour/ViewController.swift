//
//  ViewController.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/7/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var dataSources: [[String : String]] = {
        
        let arr = [
            [
                "类（class）和结构体（struct）有什么区别？" : "ClassAndStructController"
            ]
        ]

        return arr
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clicked))
    }

    @objc func clicked() {
        self.navigationController?.pushViewController(SonController(), animated: true)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let dic = dataSources[indexPath.row]
        cell.textLabel?.text = Array(dic.keys)[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = dataSources[indexPath.row]
        
        let cla: AnyClass = NSClassFromString(dic.values.first ?? "") ?? ClassAndStructController.self
        
        self.navigationController?.pushViewController(cla.alloc() as! UIViewController, animated: true)
    }
}
