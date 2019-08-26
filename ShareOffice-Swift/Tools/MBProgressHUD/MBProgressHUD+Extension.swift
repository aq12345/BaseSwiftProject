//
//  MBProgressHUD+Extension.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/18.
//  Copyright © 2018年 hcj. All rights reserved.
//

import Foundation
import MBProgressHUD
//提示框
class AQAlert: NSObject {
    enum AlertType {
        case success
        case info
        case error
        case warning
    }
    
    class func show(type: AlertType, text:String) {
        
        if let window = UIApplication.shared.delegate?.window{
            var image: UIImage
            
            switch type{
            case .success:
                image = #imageLiteral(resourceName: "success.png")
            case .info:
                image = #imageLiteral(resourceName: "info.png")
            case .warning:
                image = #imageLiteral(resourceName: "warning.png")
            case .error:
                image = #imageLiteral(resourceName: "error.png")
            }
            let hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            hud.mode = .customView
            hud.customView = UIImageView(image: image)
            hud.label.text = text
            hud.hide(animated: true, afterDelay: 1.2)
        }
    }
    
}
//小菊花
class AQProgressHUD{
    class func show(){
        
        if let window = UIApplication.shared.delegate?.window{
            MBProgressHUD.showAdded(to: window!, animated: true)
        }
    }
    class func hide(){
        if let window = UIApplication.shared.delegate?.window{
            MBProgressHUD.hide(for: window!, animated: true)
        }
    }
}
