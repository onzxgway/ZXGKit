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
            ],
            [
                "Swift是面向对象还是函数式的编程语言？" : "OOOrFunctionController"
            ],
            [
                "Open, Public, Internal, File-private, Private" : "AuthorityController"
            ],
            [
                "在 Swift 中，怎样理解是 copy-on-write？" : "CopyonwriteController"
            ],
            [
                "什么是属性观察（Property Observer）？" : "PropertyObserverController"
            ],
            [
                "Swift 实战题" : "ReallyController"
            ]
        ]

        return arr
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clicked))
        
        navigationItem.title = "Swift"
    }

    @objc func clicked() {
        self.navigationController?.pushViewController(SonController(), animated: true)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
        if let cla = NSClassFromString("SwiftTour." + (dic[Array(dic.keys)[0]] ?? "")) {
            clas = cla
        }
        else {
            clas = ClassAndStructController.self
        }
        
//        let cla: AnyClass = NSClassFromString(dic.values.first ?? "") ?? ClassAndStructController.self
        
        self.navigationController?.pushViewController(clas.alloc() as! UIViewController, animated: true)
    }
}
