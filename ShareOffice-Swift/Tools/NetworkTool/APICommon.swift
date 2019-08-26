//
//  APICommon.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/16.
//  Copyright © 2018年 hcj. All rights reserved.
//

import Foundation

enum Environment{
    case development
    case debug
    case production
}
//配置服务器环境
let environment:Environment = .production

var BaseURL = "http://192.168.2.253:4001"

let APIMerchantLogin = "/api/MerchantLogin" //

let APIPayOrderGet = "/api/PayOrder/Get" //买单接口

let APIMerchantProfit = "/api/MerchantProfit/"//统计接口 直接拼接URL

let APIMerchantBusinessTime = "/api/MerchantBusinessTime/"

let APIMerchantChangPassword = "/api/Merchant/"

let APIMerchantVertifyCode = "/api/MerchantForgetPass/"

let APIMerchantForgetPassword = "/api/MerchantForgetPass" //找回密码



