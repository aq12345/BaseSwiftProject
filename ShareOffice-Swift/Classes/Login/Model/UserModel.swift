//
//  UserModel.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/16.
//  Copyright © 2018年 hcj. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let userModel = try? newJSONDecoder().decode(UserModel.self, from: jsonData)

import Foundation

struct UserModel: Codable {
    let code: Int
    let count: Int?
    let data: UserInfo
    let showData: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case count = "Count"
        case data = "Data"
        case showData = "ShowData"
    }
}

struct UserInfo: Codable {
    let corporateName: String
  //  let provincial, urban, area: Int
    let  account, password, name: String
    let address,merchantAddress, merchantNumber: String?
    let businessCircle, phoneNumber: String
    let businessStartTime, businessEndTime: String
 //   let discountRate: Double
    let shopIntroduction: String
  //  let isOnlinePay: Bool
    let shopLogoPath, shopCoverPath, shopBackgroundPath: String?
  //  let isDiscard: Bool
    let creatorTime: String
  //  let creatorID: String?
    let code: String
  //  let isDelete: Bool
    let qrCodePath: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case corporateName = "CorporateName"
      //  case provincial = "Provincial"
      //  case urban = "Urban"
      //  case area = "Area"
        case address = "Address"
        case account = "Account"
        case password = "Password"
        case name = "Name"
        case businessCircle = "BusinessCircle"
        case merchantAddress = "MerchantAddress"
        case merchantNumber = "MerchantNumber"
        case phoneNumber = "PhoneNumber"
        case businessStartTime = "BusinessStartTime"
        case businessEndTime = "BusinessEndTime"
     //   case discountRate = "DiscountRate"
        case shopIntroduction = "ShopIntroduction"
      //  case isOnlinePay = "IsOnlinePay"
        case shopLogoPath = "ShopLogoPath"
        case shopCoverPath = "ShopCoverPath"
        case shopBackgroundPath = "ShopBackgroundPath"
       // case isDiscard = "IsDiscard"
        case creatorTime = "CreatorTime"
     //   case creatorID = "CreatorId"
        case code = "Code"
      //  case isDelete = "IsDelete"
        case qrCodePath = "QRCodePath"
        case id = "Id"
    }
}


