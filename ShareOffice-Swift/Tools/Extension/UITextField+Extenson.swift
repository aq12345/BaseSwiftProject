//
//  UITextField+Extenson.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/29.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

enum textType {
    case Phone,
    Password,
    Email,
    VertifyCode
}

extension UITextField{
    
    
    convenience init(type:textType ) {
        
        self.init()
        textColor = UIColor.init(hex: "a8a8a8")
        font = UIFont(name: "PingFangSC-Medium", size: 11)
        clearButtonMode = .whileEditing
        
        switch type {
        case .Password:
            placeholder = "请输入密码"
            isSecureTextEntry = true
            break;
        case .Phone:
            placeholder = "请输入手机号"
            keyboardType = .numberPad
            break;
        case .VertifyCode:
            placeholder = "请输入验证码"
            keyboardType = .default
            break;
        default:
            break;
        }
        
    }
    
}
