//
//  AppDelegate.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/24.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        NotificationCenter.default.addObserver(self, selector: #selector(userInfoChange(notice:)), name: NSNotification.Name(rawValue: kNotificationUserChange), object: nil)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let rootVC = LoginVC()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        //设置全局键盘
        configIQKeyboardManager()
        setupBaseURL()
        return true
    }

}
//用户信息相关通知
extension AppDelegate{
    
    @objc func userInfoChange(notice: Notification){
        guard  let isLog = notice.object as? String else { return }
        
        if isLog == "1" {
            let rootVC = MainTabBarController()
            //动画效果
            let anima = CATransition()
            anima.type = "cube"
            anima.subtype = kCATransitionFromRight
            anima.duration = 0.3
            UIApplication.shared.keyWindow?.layer.add(anima, forKey: "revealAnimation")
            window?.rootViewController = rootVC

        }else{
            
            let rootVC = LoginVC()
            let anima = CATransition()
            anima.type = "cube"
            anima.subtype = kCATransitionFromLeft
            anima.duration = 0.3
            UIApplication.shared.keyWindow?.layer.add(anima, forKey: "revealAnimation")
            window?.rootViewController = rootVC
        }
        
        
    }
    
}

//键盘相关
extension AppDelegate {
    
    fileprivate func configIQKeyboardManager(){
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    func setupBaseURL(){
        
        switch environment{
        case .development:
            BaseURL = "http://192.168.2.253:4001"
            print("🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱this is development")
        case .debug:
            BaseURL = "http://114.80.200.60:7001"
            print("🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱this is debug")
        case .production:
            BaseURL = "https://plus.richbox.biz"
            print("🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱this is production")
        }
    }
    
    
}
