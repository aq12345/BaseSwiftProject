//
//  UserDefault+Extension.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/6/1.
//  Copyright © 2018年 hcj. All rights reserved.
//

import Foundation

protocol UserDefaultsSettable {
    
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue == String{
    
    static func set(value: String?,forKey key: defaultKeys){
        
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    
    static func string(forKey key: defaultKeys) -> String?{
        
        let aKey = key.rawValue
        return UserDefaults.standard.string(forKey: aKey)
    }
    
}

extension UserDefaults{
    
    struct UserInfo: UserDefaultsSettable {
        
        enum  defaultKeys: String {
            case Name
            case Password
            case TIcon
            case BusinessStartTime
            case BusinessEndTime
            case MerchantAddress
            case PhoneNumber
            case Id
            case ShopLogoPath
            case QRCodePath
            
        }
        struct LoginInfo: UserDefaultsSettable {
            enum defaultKeys: String {
                case Ticket
                case UserId
            }
        }
    }
}
