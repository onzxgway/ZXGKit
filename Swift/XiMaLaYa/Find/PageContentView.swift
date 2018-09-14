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
        scrollView.backgroundColor = .red
        scrollView.contentSize = CGSize(width: CGFloat(viewControllers.count) * bounds.size.width, height: 0)
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
    }
}






