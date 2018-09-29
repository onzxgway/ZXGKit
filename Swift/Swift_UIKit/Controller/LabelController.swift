//
//  LabelController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/9/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

/**
 UILable定义：
 
 A view that displays one or more lines of read-only text, often used in conjunction with controls to describe their intended purpose.
 
 显示一行或多行只读文本的视图，通常与控件一起使用，以描述其预期用途。
 */

class LabelController: BaseController {
    
    private lazy var lab: UILabel = {
        let lab = UILabel(frame: CGRect(x: 30, y: 80, width: 280, height: 62))
        lab.backgroundColor = .lightGray
        view.addSubview(lab)
        return lab
    }()

}

extension LabelController {
    override func setAttribute() -> Void {
        
        lab.text = "生活不止眼前的苟且 还有诗和远方的田野 你赤手空拳来到人世间 为找到那片海不顾一切"
        lab.textColor = .red
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textAlignment = .center
        lab.numberOfLines = 0
        lab.highlightedTextColor = .gray   // AAAAA
        lab.isEnabled = true // enabled决定了Label的绘制方式，将它设置为NO时文本变暗，表示没有激活，这时设置颜色值是无效的。 默认是yes 若改成NO字体的颜色会变暗 添加手势之后 把这个属性改为NO这个手势依然可以被触发 用处是单单的改变颜色
        
        
        lab.lineBreakMode = .byTruncatingTail
        
        // AAAAA
        lab.adjustsFontSizeToFitWidth = true    // 前提：numberOfLines 为 1 的时候才生效。 改变字体大小来适应Label大小 当文本宽度小于控件宽度的时候 这个属性没做什么事情
        lab.minimumScaleFactor = 0.5            // 前提：adjustsFontSizeToFitWidth 生效的时候才生效。 最小收缩比例，如果Label宽度小于文字长度时，文字进行收缩，收缩超过比例后，停止收缩。
        
        lab.baselineAdjustment = .alignCenters  // 前提：adjustsFontSizeToFitWidth 生效的时候才生效。
        /**
         alignBaselines 变小之后的字体和以前的字体 和label的y值的距离是不变的
         
         alignCenters 变小之后的字体和以前字体的中间center.y是不变的
         
         none 变小之后的字体和以前的字体距离label底部的距离是不变的
         */
//        lab.allowsDefaultTighteningForTruncation = true // 未知
        
        lab.shadowColor = .black
        lab.shadowOffset = CGSize(width: 1, height: 1)
    }
}

extension LabelController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lab.isHighlighted = !lab.isHighlighted
    }
}
