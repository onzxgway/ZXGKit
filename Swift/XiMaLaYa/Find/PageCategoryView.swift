//
//  PageCategoryView.swift
//  XiMaLaYa
//
//  Created by 朱献国 on 2018/9/3.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit
import Foundation

class PageCategoryView: UIView {
    
    var titles: [String]
    var selectedIndex: Int = 0
    var pageViewConfig: PageViewConfig
    
    private lazy var categoryLabels = [UILabel]()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    private lazy var indicatorLine: UIView = {
        let line = UIView()
        
        return line
    }()
    
    // 自定义初始化函数 没有返回值 不需要func, 确保实例在使用之前正确的给每个属性设置一个值。
    public init(frame: CGRect, config: PageViewConfig, titles: [String], selectedIndex: Int = 0) {
        
        self.titles = titles
        self.selectedIndex = selectedIndex
        self.pageViewConfig = config
        
        super.init(frame: frame)
        
        createSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutSubview()
    }
}

// MARK: - 设置UI界面
extension PageCategoryView {
    func createSubview() -> Void {
        backgroundColor = UIColor.red
        
        // 0.
        addSubview(scrollView)
        
        // 1. Label
        for (index, value) in titles.enumerated() {
            
            let lab = UILabel()
            lab.tag = index
            lab.text = value
            lab.textAlignment = .center
            lab.textColor = index == selectedIndex ? pageViewConfig.titleSelectedColor : pageViewConfig.titleColor
            lab.font = index == selectedIndex ? pageViewConfig.titleSelectedFont : pageViewConfig.titleFont
            
            addSubview(lab)
            categoryLabels.append(lab)
            
        }
        
        // 2.
        addSubview(indicatorLine)
        
    }
}

// MARK: - 布局UI界面
extension PageCategoryView {
    private func layoutSubview() {
        
        scrollView.frame = bounds
        
        layoutLables()
        
    }
    
    /**
     sizeThatFits:  会计算出最优的 size 但不会改变自己的 size
     sizeToFit:     会计算出最优的 size 而且会改变自己的 size
     */
    private func layoutLables() {
        
        var x = pageViewConfig.titleMargin * 0.5
        let y: CGFloat = 0, h = bounds.size.height
        
        for (index, lab) in categoryLabels.enumerated() {
            var labF = lab.frame
            labF.origin.x = x
            labF.origin.y = y
            labF.size.height = h
            let size = lab.sizeThatFits(CGSize(width: 0, height: 0))
            labF.size.width = size.width + pageViewConfig.titleMargin
            lab.frame = labF
            
            x += lab.frame.width //+  pageViewConfig.titleMargin
            
        }
        
    }
    
    private func layoutIndicatorLine() {
        
        
        
    }
}



