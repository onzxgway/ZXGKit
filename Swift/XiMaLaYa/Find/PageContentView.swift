//
//  PageContentView.swift
//  XiMaLaYa
//
//  Created by 朱献国 on 2018/9/8.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    
    private let pageViewConfig: PageViewConfig
    private let viewControllers: [UIViewController]

    private (set) public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .gray
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    public init(frame: CGRect, config: PageViewConfig, viewControllers: [UIViewController]) {
        
        pageViewConfig = config
        self.viewControllers = viewControllers
        
        super.init(frame: frame)
        
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutSubview()
    }
    
}


extension PageContentView {
    private func createView() {
        addSubview(scrollView)
    }
}

extension PageContentView {
    private func layoutSubview() {
        scrollView.frame = bounds
        
        var x: CGFloat = 0
        let y: CGFloat = 0
        let w: CGFloat = self.bounds.size.width
        let h: CGFloat = self.bounds.size.height
        
        for (index, ctrl) in viewControllers.enumerated() {
            x = CGFloat(index) * w
            scrollView.addSubview(ctrl.view)
            ctrl.view.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(viewControllers.count) * bounds.size.width, height: 0)
    }
}

extension PageContentView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}




