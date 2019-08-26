//
//  PayBillModel.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/17.
//  Copyright © 2018年 hcj. All rights reserved.
//

import Foundation

struct PayBillModel: Codable {
    let code: Int
    let count: Int?
    let data: PayModel
    let showData: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case count = "Count"
        case data = "Data"
        case showData = "ShowData"
    }
}

struct PayModel: Codable {
    let count: Int
    let list: [PaybillList]
    let expand: String?
    
    enum CodingKeys: String, CodingKey {
        case count = "Count"
        case list = "List"
        case expand = "Expand"
    }
}

struct PaybillList: Codable {
    let buyerName, buyerMobile, payStateName, orderStateName: String
    let payTypeName: String
    let totalAmount, rebate: Double
    let integralRabate: Double
    let orderTime, refundTime: String
    let realPayment: Double
    
    enum CodingKeys: String, CodingKey {
        case buyerName = "BuyerName"
        case buyerMobile = "BuyerMobile"
        case payStateName = "PayStateName"
        case orderStateName = "OrderStateName"
        case payTypeName = "PayTypeName"
        case totalAmount = "TotalAmount"
        case rebate = "Rebate"
        case integralRabate = "IntegralRabate"
        case orderTime = "OrderTime"
        case refundTime = "RefundTime"
        case realPayment = "RealPayment"
    }
}

