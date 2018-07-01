//
//  ViewController.swift
//  XiMaLaYa
//
//  Created by 朱献国 on 2018/6/23.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

let kCustomTabBar : CGFloat = 49
let kTagPlus : NSInteger = 100

class MainTabBarController: UITabBarController {
    
    // MARK: - lazy load
    lazy var customTabBar : UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: 0, y: SCREEN_HEIGHT - kCustomTabBar, width: SCREEN_WIDTH, height: kCustomTabBar)
        img.image = UIImage(named: "tabbar_bg")
        img.isUserInteractionEnabled = true
        return img
    }()
    
    lazy var normalItemImages: [UIImage] = {
        var tempArr : [UIImage] = [UIImage]()
        tempArr.append(UIImage(named: "tabbar_find_n")!)
        tempArr.append(UIImage(named: "tabbar_sound_n")!)
        tempArr.append(UIImage(named: "tabbar_np_playnon")!)
        tempArr.append(UIImage(named: "tabbar_download_n")!)
        tempArr.append(UIImage(named: "tabbar_me_n")!)
        return tempArr
    }()
    
    lazy var selectedItemImages: [UIImage] = {
        var tempArr : [UIImage] = [UIImage]()
        tempArr.append(UIImage(named: "tabbar_find_h")!)
        tempArr.append(UIImage(named: "tabbar_sound_h")!)
        tempArr.append(UIImage(named: "tabbar_np_playnon")!)
        tempArr.append(UIImage(named: "tabbar_download_h")!)
        tempArr.append(UIImage(named: "tabbar_me_h")!)
        return tempArr
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCustomTabBar()
        
        configSubController()
    }

}

extension MainTabBarController {
    
    func createCustomTabBar() {
        tabBar.isHidden = true
        
        // 自定义tabBar
        view.addSubview(customTabBar)
        
        let w = SCREEN_WIDTH * 0.2
        // tabBar上面的item
        for index in 0...(normalItemImages.count - 1) {
            let btn = UIButton(type: .custom)
            
            btn.setImage(normalItemImages[index], for: .normal)
            btn.setImage(selectedItemImages[index], for: .selected)
            btn.tag = kTagPlus + index
            if index == normalItemImages.count / 2 {
                btn.frame = CGRect(x: CGFloat(index) * w, y: -10, width: w, height: customTabBar.bounds.size.height + 10)
            }
            else {
                btn.frame = CGRect(x: CGFloat(index) * w, y: 0, width: w, height: customTabBar.bounds.size.height)
            }
            btn.addTarget(self, action:#selector(tarBarItemSelected(_ :)) , for: .touchUpInside)
            
            customTabBar.addSubview(btn)
        }
        
        // 中间item的阴影
        let playBtn = customTabBar.viewWithTag(kTagPlus + normalItemImages.count / 2)
        let shadowImg = UIImageView(image: UIImage(named: "tabbar_np_shadow"))
        playBtn?.addSubview(shadowImg)
        shadowImg.frame = CGRect(x: -3, y: -3, width: (playBtn?.bounds.size.width)! + 6, height: (playBtn?.bounds.size.height)! + 6)
        
        // 默认选中发现
        tarBarItemSelected(customTabBar.viewWithTag(kTagPlus) as! UIButton)
    }
    
    
    func configSubController() {
        var tempArr : [CustomNavigationController] = [CustomNavigationController]()
        tempArr.append(navigationControllerWith(FindController()))
        tempArr.append(navigationControllerWith(SubscribeController()))
        tempArr.append(navigationControllerWith(PlayController()))
        tempArr.append(navigationControllerWith(DownloadController()))
        tempArr.append(navigationControllerWith(MineController()))
        viewControllers = tempArr
    }
    
    func navigationControllerWith(_ vc:UIViewController) -> CustomNavigationController {
        let navCtrl = CustomNavigationController(rootViewController: vc)
        navCtrl.delegate = self
        return navCtrl
    }
}

// MARK: - Event
extension MainTabBarController {
    @objc func tarBarItemSelected(_ btn:UIButton) {
        btn.isSelected = true
        btn.isUserInteractionEnabled = false
        
        for button in customTabBar.subviews {
            guard let xbtn = button as? UIButton else {
                continue
            }
            if xbtn == btn {
                continue
            }
            
            xbtn.isSelected = false
            xbtn.isUserInteractionEnabled = true
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension MainTabBarController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("willShow")
        if viewController.hidesBottomBarWhenPushed {
            customTabBar.isHidden = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("didShow")
        if viewController.hidesBottomBarWhenPushed {
            customTabBar.isHidden = true
        }
    }
}
