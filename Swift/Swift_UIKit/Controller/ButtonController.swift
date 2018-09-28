
//
//  ButtonController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/9/28.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

/**
 Button定义：
 
 A control that executes your custom code in response to user interactions.
 
 响应用户交互而执行自定义代码的控件。
 */

class ButtonController: BaseController {
    
    private lazy var btn: UIButton = {
        let btn = UIButton(type: .detailDisclosure)
//        btn.backgroundColor = .lightGray
        btn.frame = CGRect(x: 32, y: 88, width: 210, height: 64)
        view.addSubview(btn)
        return btn
    }()
    
    private lazy var bt: UIButton = {
        let bt = UIButton(type: .contactAdd)
        //        btn.backgroundColor = .lightGray
        bt.frame = CGRect(x: 32, y: 148, width: 210, height: 64)
        view.addSubview(bt)
        return bt
    }()
    
    private lazy var b: UIButton = {
        let b = UIButton(type: .custom)
        //        btn.backgroundColor = .lightGray
        b.frame = CGRect(x: 32, y: 228, width: 298, height: 64)
        view.addSubview(b)
        return b
    }()

    private lazy var bn: UIButton = {
        let bn = UIButton(type: .custom)
        //        btn.backgroundColor = .lightGray
//        bn.frame = CGRect(x: 32, y: 328, width: 298, height: 64)
//        bn.center = CGPoint(x: view.center.x, y: view.center.y + 66)
        view.addSubview(bn)
        return bn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        setAttribute()
    }

}

extension ButtonController {
    private func setAttribute() -> Void {
        
        // 1
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        
        // 2
        bt.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        
        // 3
        b.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        b.setTitle("生活不止眼前的苟且 还有诗和远方的田野 你赤手空拳来到人世间 为找到那片海不顾一切", for: .normal)
        b.setImage(UIImage(named: "img"), for: .normal)                 // 如果图片的size < button的size，不会被拉伸，原比例显示， 如果图片的size > button的size，会被压缩
        b.setBackgroundImage(UIImage(named: "bg_Img"), for: .normal)    // 默认会被拉伸，充满整个button
        b.setTitleColor(.black, for: .normal)
        b.setTitleShadowColor(.lightGray, for: .normal)
        // 把 b.setTitleShadowColor(.lightGray, for: .normal) 替换成 b.titleLabel?.shadowColor = .lightGray 阴影效果实现不了
        b.titleLabel?.shadowOffset = CGSize(width: 1, height: 1)
        b.titleLabel?.lineBreakMode = .byTruncatingTail
        b.showsTouchWhenHighlighted = true
        
        b.setTitle("我独自渐行渐远 膝下多了个少年", for: .highlighted)
        b.setTitleColor(.blue, for: .highlighted)
        b.setTitleShadowColor(.black, for: .highlighted)
        b.reversesTitleShadowWhenHighlighted = true // 高亮状态 是否改变阴影位置
        
        b.setTitle("少年一天天长大 有一天要离开家", for: .selected)
        b.setTitleColor(.red, for: .selected)
        
        b.setTitle("看他背影的成长 看他坚持与回望", for: .disabled)
        b.setTitleColor(.gray, for: .disabled)
        
        b.setTitleColor(.orange, for: .focused) // 聚焦状态（3D Touch有关）
        
        // 4
        bn.setTitle("生活不止眼前的苟且", for: .normal)
        bn.backgroundColor = .gray
        bn.setImage(UIImage(named: "img"), for: .normal)
//        bn.setImage(UIImage(named: "img"), for: .highlighted)
        bn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        bn.showsTouchWhenHighlighted = false  // 用户手指接触的部分会发亮，就是变成白色。按钮有图片的话，只有图片发亮，只有文字的话，也发亮，但是只有中间一块区域发亮
        bn.adjustsImageWhenDisabled = true    // default is YES. if YES, image is drawn lighter when disabled
        bn.adjustsImageWhenHighlighted = true // 前提：showsTouchWhenHighlighted 为 false 的时候才生效。 default is YES. if YES, image is drawn darker when highlighted(pressed)
        /**
         默认全是 UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
         */
        
        /**
         
         前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
         如果只有title，那它上下左右都是相对于button的，image也是一样,
         如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；label的上下右是相对于button，左边是相对于image的。
         
         默认情况下，button的image和label是紧贴着居中的
         如果想要image在右边，label在左边应该怎么办呢？ 答案就是：
         
             bn.imageEdgeInsets = UIEdgeInsets(top: 0, left: (bn.titleLabel?.bounds.size.width)!, bottom: 0, right: -(bn.titleLabel?.bounds.size.width)!)
             bn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(bn.imageView?.bounds.size.width)!, bottom: 0, right: (bn.imageView?.bounds.size.width)!)
         
         来解释一下为什么：
             其实就是这一句：This property is used only for positioning the image during layout
             其实titleEdgeInsets属性和imageEdgeInsets属性只是在画这个button出来的时候用来调整image和label位置的属性，并不影响button本身的大小，
             它们只是image和label相较于原来位置的偏移量，那什么是原来的位置呢？就是这个没有设置edgeInset时候的位置了。
         
             如要要image在右边，label在左边，那image的左边相对于button的左边右移了labelWidth的距离，image的右边相对于label的左边右移了labelWidth的距离
             所以，bn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);为什么是负值呢？因为这是contentInset，是偏移量，不是距离
             同样的，label的右边相对于button的右边左移了imageWith的距离，label的左边相对于image的右边左移了imageWith的距离
             所以bn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
             这样就完成image在右边，label在左边的效果了。
         */
        bn.sizeToFit()                        // 给完具体内容之后，再调用此方法
        bn.center = CGPoint(x: view.center.x, y: view.center.y + 66)
        
        
        bn.imageEdgeInsets = UIEdgeInsets(top: 0, left: (bn.titleLabel?.sizeThatFits(.zero).width)!, bottom: 0, right: -(bn.titleLabel?.sizeThatFits(.zero).width)!)
        bn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(bn.imageView?.bounds.size.width)!, bottom: 0, right: (bn.imageView?.bounds.size.width)!)
//        bn.contentEdgeInsets = UIEdgeInsets(top: 6, left: 20, bottom: 6, right: 20) // btn整体内容距离四周的间距
        
        print(bn.imageEdgeInsets)
        print(bn.titleEdgeInsets)
        print(bn.contentEdgeInsets)
    }
    
    @objc private func clicked(btn: UIButton) -> Void {
        print(btn.title(for: .normal) ?? "none")
    }
}

extension ButtonController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        b.isEnabled = !b.isEnabled
        bn.isEnabled = !bn.isEnabled
    }
}
