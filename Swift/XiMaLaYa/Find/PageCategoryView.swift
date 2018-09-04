//
//  PageCategoryView.swift
//  XiMaLaYa
//
//  Created by 朱献国 on 2018/9/3.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class PageCategoryView: UIView {
    
    var titles: [String]
    var currentIndex: Int
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var indicatorLine: UIView = {
        let line = UIView()
        
        return line
    }()
    
    // 初始化函数 没有返回值 不需要func, 确保实例在使用之前正确的给每个属性设置一个值。
    public init(frame: CGRect, titles: [String], currentIndex: Int = 0) {
        
        self.titles = titles
        self.currentIndex = currentIndex
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

// MARK: - 设置UI界面
extension PageCategoryView {
    func setupUI() -> Void {
        backgroundColor = UIColor.red
        
        // 0.
        addSubview(scrollView)
        
        // 1.
        
    }
}






