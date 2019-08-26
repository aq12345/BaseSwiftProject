//
//  UILabel+Extension.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/7/31.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

extension UILabel{
    
    convenience init(color:UIColor) {
        
        self.init()
        textColor = color
        textAlignment = .center
        font = UIFont(name: "PingFangSC-Medium", size: 13)
    }
    
}
