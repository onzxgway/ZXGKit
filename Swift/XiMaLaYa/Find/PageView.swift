//
//  PageView.swift
//  XiMaLaYa
//
//  Created by 朱献国 on 2018/9/3.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

/**
 所有常量在初始化之后，绝对不能改变。
 
 延迟存储属性必须是var,因为可能会在初始化之后调用它。
 
 */
class PageView: UIView {

    // 1.类或结构体 实例
    lazy var pageCategoryView = PageCategoryView(frame: .zero, config: pageViewConfig, titles: titles)
    
    // 2.闭包
    lazy var dict:[String: String] = {
        var dict:[String: String] = [:]
        dict["key"] = "test"
        return dict
    }()
    
    private var pageViewConfig: PageViewConfig
    private var titles: [String]
    
    public init(frame: CGRect, config: PageViewConfig, titles: [String]) {
        
        pageViewConfig = config
        self.titles = titles
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.blue
        clipsToBounds = true
        
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageView {
    private func createView() {
        addSubview(pageCategoryView)
        
        pageCategoryView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: pageViewConfig.categoryViewHeight)
        
        
    }
}






