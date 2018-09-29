
//
//  ImageViewController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/9/29.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

/**
 ImageView定义：
 
 An object that displays a single image or a sequence of animated images in your interface.
 
 在界面中显示单个图像或一系列动画图像的对象。
 */
class ImageViewController: BaseController {
    
    private lazy var img: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 52, y: 88, width: 210, height: 110))
        view.addSubview(img)
        return img
    }()
    
    private lazy var img1: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 52, y: 228, width: 210, height: 110))
        view.addSubview(img)
        return img
    }()
    
    private lazy var img2: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 52, y: 348, width: 210, height: 110))
        view.addSubview(img)
        return img
    }()
    
    private lazy var imgs: [UIImage] = {
        var imgs = [UIImage]()
        for index in 1...29 {
            
            if let img = UIImage(named: "Export1-1_0000\(index)") {
                imgs.append(img)
            }
            
        }
        return imgs
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        resizableImage()
    }
    
    /**
     Debugging Issues with Your Image View
     
     1.正确的方法加载图片。Use the imageNamed:inBundle:compatibleWithTraitCollection: method of UIImage to load images from asset catalogs or your app’s bundle. For images outside of your app’s bundle, use the imageWithContentsOfFile: method.
     2.UIImageView绘制内容的时候，不走drawRect: 方法, UIImageView仅仅用来呈现图片. 如果要自定义绘制图片的话，请直接使用 UIView。
     */
    
}

/**
 提升ImageView性能：
 
 1.Cache scaled versions of frequently used images.
 
 2.Use images whose size is close to the size of the image view. images的size 接近 UIImageView的size
 
 3.Make your image view opaque whenever possible. 不透明属性设置为YES
 */
extension ImageViewController {
    override func setAttribute() -> Void {
        img.image = UIImage(named: "nut")
        
        img.highlightedImage = UIImage(named: "nut_highlight")
        
        img.isUserInteractionEnabled = true
        
        /**
         scaleToFill
         
         scaleAspectFit // 原图比例不变显示，UIImageViewg会填充不全，不全的部分透明显示 contents scaled to fit with fixed aspect. remainder is transparent
         
         scaleAspectFill // 原图比例不变显示，UIImage会显示不全，不全的部分被剪裁 contents scaled to fill with fixed aspect. some portion of content may be clipped.
         
         redraw // redraw on bounds change (calls -setNeedsDisplay)
         
         center // 原图size不变 居中显示，显示不全的部分被剪裁，contents remain same size. positioned adjusted.
         
         top    // 原图size不变 居顶显示，显示不全的部分被剪裁，
         
         bottom // 原图size不变 居底显示，显示不全的部分被剪裁，
         
         left   // 原图size不变 居左显示，显示不全的部分被剪裁，
         
         right  // 原图size不变 居右显示，显示不全的部分被剪裁，
         
         // 原图size不变 居四个角显示，显示不全的部分被剪裁，
         topLeft
         
         topRight
         
         bottomLeft
         
         bottomRight
         */
        img.contentMode = .bottomRight
        img.clipsToBounds = true

        img.animationImages = imgs

//        open var highlightedAnimationImages: [UIImage]? // The array must contain UIImages. Setting hides the single image. default is nil

        img.animationDuration = Double(imgs.count) * 1/30
        img.animationRepeatCount = Int.max
        
//        img.tintColor = .red
    }
    
    @objc private func clicked(btn: UIButton) -> Void {
        print(btn.title(for: .normal) ?? "none")
    }
}

extension ImageViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        img.isHighlighted = !img.isHighlighted
        
        img.startAnimating()
    }
}


extension ImageViewController {
    // 图片拉伸
    private func resizableImage() {
        
        let image = UIImage(named: "bubble") // 气泡
        
        if let ima = image {
            
            let newImg = ima.resizableImage(withCapInsets: UIEdgeInsets(top: (ima.size.height) - 4, left: 2, bottom: 2, right: (ima.size.width) - 1), resizingMode: .stretch)
            
            img1.contentMode = .scaleToFill
            img1.image = newImg
        }
        
        if let ima = image {
            
            let newImg = ima.resizableImage(withCapInsets: UIEdgeInsets(top: 2, left: 2, bottom: (ima.size.height) - 1, right: (ima.size.width) - 1), resizingMode: .stretch)
            
            img.contentMode = .scaleToFill
            img.image = newImg
        }
        
        if let ima = image {
            
            let newImg = ima//.resizableImage(withCapInsets: UIEdgeInsets(top: 2, left: 2, bottom: (ima.size.height) - 1, right: (ima.size.width) - 1), resizingMode: .stretch)
            
            img2.contentMode = .center
            img2.image = newImg
        }
        
    }
}
