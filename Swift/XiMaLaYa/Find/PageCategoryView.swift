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
    private var selectedLab: UILabel?
    
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
        line.isHidden = !pageViewConfig.showIndicatorLine
        line.backgroundColor = pageViewConfig.indicatorLineColor
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
            if index == selectedIndex {
                selectedLab = lab
            }
            
            scrollView.addSubview(lab)
            categoryLabels.append(lab)
            
            lab.isUserInteractionEnabled = true
            lab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labTap(ges:))))
            
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
        
        layoutIndicatorLine()
    }
    
    /**
     sizeThatFits:  会计算出最优的 size 但不会改变自己的 size
     sizeToFit:     会计算出最优的 size 而且会改变自己的 size
     */
    private func layoutLables() {
        
        var x: CGFloat = 0
        let y: CGFloat = 0, h = scrollView.bounds.size.height, w = scrollView.bounds.width / CGFloat(categoryLabels.count)
        
        for (index, lab) in categoryLabels.enumerated() {
            var labF = lab.frame
            
            if pageViewConfig.categoryViewScrollEnable {
                if index == 0 {
                    x = pageViewConfig.titleMargin * 0.5
                }
                labF.origin.x = x
                labF.origin.y = y
                labF.size.height = h
                let size = lab.sizeThatFits(CGSize(width: 0, height: 0))
                labF.size.width = size.width + pageViewConfig.titleMargin
                
                x += labF.size.width
            }
            else {
                labF.origin.x = CGFloat(index) * lab.frame.width
                labF.origin.y = y
                labF.size.width = w
                labF.size.height = h
            }
            
            lab.frame = labF
        }
        
        if pageViewConfig.categoryViewScrollEnable {
            guard let lab = categoryLabels.last else { return }
            let w = lab.frame.maxX + pageViewConfig.titleMargin * 0.5
            scrollView.contentSize.width = w
        }
        
    }
    
    private func layoutIndicatorLine() {
        
        let lab = categoryLabels[selectedIndex]
        let x: CGFloat = lab.frame.origin.x + (lab.frame.size.width - pageViewConfig.indicatorLineWidth) * 0.5
        let y: CGFloat = bounds.size.height - pageViewConfig.indicatorLineHeight
        let w: CGFloat = pageViewConfig.indicatorLineWidth
        let h: CGFloat = pageViewConfig.indicatorLineHeight
        
        indicatorLine.frame = CGRect(x: x, y: y, width: w, height: h)
        
    }
}

// MARK: - Eevet
extension PageCategoryView {
    
    @objc private func labTap(ges: UITapGestureRecognizer) {
       guard let tapTag = ges.view?.tag else { return }
        
        setupLabel(atIndex: tapTag)
    }
    
    private func setupLabel(atIndex: Int) {
        
        // 切换颜色和字体
        let lab = categoryLabels[atIndex]
        
        if let selectedLabel = selectedLab {
            if selectedLabel != lab {
                
                selectedLabel.textColor = pageViewConfig.titleColor
                selectedLabel.font = pageViewConfig.titleFont
                
                lab.textColor = pageViewConfig.titleSelectedColor
                lab.font = pageViewConfig.titleSelectedFont
                
                selectedLab = lab
            }
        }
        else {
            lab.textColor = pageViewConfig.titleSelectedColor
            lab.font = pageViewConfig.titleSelectedFont
            
            selectedLab = lab
        }
        
        
    }
    
}

