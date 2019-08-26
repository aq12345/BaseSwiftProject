//
//  MainTabBarController.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/24.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .default
        let tabBar = UITabBarItem.appearance()
        let attrsNormal = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:UIColor.gray]
        let attrsSelect = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:UIColor.black]
        tabBar.setTitleTextAttributes(attrsNormal, for: .normal)
        tabBar.setTitleTextAttributes(attrsSelect, for: .selected)
        setupUI()
    }

    
}

extension MainTabBarController{
    
    fileprivate func setupUI(){
       //添加tabbar上面的vc
        let vcArray:[UIViewController] = [PayBillVC(),PayCountVC(),MineVC()]
        let titleArray = [("买单记录","maidanjilu"),("统计","tongji"),("设置","shezhi")]
        for (index,vc) in vcArray.enumerated() {
            vc.tabBarItem.title = titleArray[index].0
            vc.tabBarItem.image = UIImage(named: "\(titleArray[index].1)1")
            vc.tabBarItem.selectedImage = UIImage(named: "\(titleArray[index].1)")?.withRenderingMode(.alwaysOriginal)
            let nav = BaseNavigationVC(rootViewController: vc)
            addChildViewController(nav)
        }
        
    }
    
    
    
}
