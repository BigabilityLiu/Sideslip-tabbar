//
//  MainTabbarController.swift
//  Sideslip&TabbarLikeQQDemo
//
//  Created by 刘旭东 on 15/12/26.
//  Copyright © 2015年 刘旭东. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    var lastSelectedItemTag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item.tag == lastSelectedItemTag{
            //如果点击已经选择不作操作
        }else{
            lastSelectedItemTag = item.tag
            switch item.tag{
            case 0:
                self.view.addSubview(self.viewControllers![0].view)
            case 1:
                self.view.addSubview(self.viewControllers![1].view)
            default:
                break
            }
//            self.view.bringSubviewToFront(self.tabBar)      
        }
    }
}
