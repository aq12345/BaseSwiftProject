//
//  Common.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/25.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

let kCellTextMargin: CGFloat = 10
let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
let iPhoneXHeight: CGFloat = 812
let kNavibarHeight: CGFloat = 44.0

let kTabBarHeight: CGFloat = (UIApplication.shared.statusBarFrame.size.height > 20.0 ? 83.0:49.0)
let kTopHeight = kStatusBarHeight + kNavibarHeight
let kScreenHeight = UIScreen.main.bounds.height
let kScreentWidth = UIScreen.main.bounds.width

func AQScreenWidth(width: CGFloat) ->CGFloat{
    
    return (kScreentWidth / 375) * width
}

func AQScreenHeight(height: CGFloat) ->CGFloat{
    
    return (kScreenHeight / 667) * height
}
//通知
let kNotificationUserChange = "UserChange"
//通用颜色
let kOrangeColor = UIColor.init(hex: "d58f51")

let kLineColor =  UIColor(red: 202 / 255.0, green: 202 / 255.0, blue: 202 / 255.0, alpha: 1.0)


let kBackgroundColor =  UIColor(red: 224 / 255.0, green: 224 / 255.0, blue: 224 / 255.0, alpha: 1.0)
