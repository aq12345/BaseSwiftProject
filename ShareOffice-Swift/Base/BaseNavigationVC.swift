//
//  BaseNavigationVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/24.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class BaseNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font:UIFont(name: "PingFangSC-Regular", size: 16) as Any]
        navigationBar.backgroundColor = UIColor.white
        
    }
    //通过重写父类方法给所有navigation添加返回button
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0{
            
            let button = UIButton(type: .custom)
        //    button.setTitle("返回", for: .normal)
            button.setImage(UIImage(named: "ic_fanhui"), for: .normal)
            button.addTarget(self, action: #selector(back), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            viewController.hidesBottomBarWhenPushed = true
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    //设置默认barstyle
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    //如果改变想个别页面状态栏颜色使用
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    
}

extension BaseNavigationVC{
    
    @objc func back(){
        popViewController(animated: true)
    }
}

extension BaseNavigationVC{
    
    fileprivate func setUpPopGesture(){
        //使用运行时打印手势中所有属性
        guard let targets = interactivePopGestureRecognizer!.value(forKey: "_targets") as? [NSObject] else {return}
        let targetObjc = targets[0]
        let target = targetObjc.value(forKey: "target")
        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(panGes)
    }
    
    
}
