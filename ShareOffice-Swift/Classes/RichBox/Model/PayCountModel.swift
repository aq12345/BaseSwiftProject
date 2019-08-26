//
//  PayCountModel.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/18.
//  Copyright © 2018年 hcj. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let payCountModel = try? newJSONDecoder().decode(PayCountModel.self, from: jsonData)

import Foundation

struct PayCountModel: Codable {
    let code: Int
    let count: Int?
    let data: payCountModel
    let showData: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case count = "Count"
        case data = "Data"
        case showData = "ShowData"
    }
}

struct payCountModel: Codable {
    let id: Int
    let lastWeek, thisMonth, lastMonth, thisYear, today, thisWeek, yesterday: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case today = "Today"
        case thisWeek = "ThisWeek"
        case yesterday = "Yesterday"
        case lastWeek = "LastWeek"
        case thisMonth = "ThisMonth"
        case lastMonth = "LastMonth"
        case thisYear = "ThisYear"
    }
}


