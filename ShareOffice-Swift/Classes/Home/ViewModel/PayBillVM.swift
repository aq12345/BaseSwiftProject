//
//  PayBillVM.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/17.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class PayBillVM: NSObject {
    
    var modelArray : [PaybillList] = [PaybillList]()
    var page: Int = 1
    
}


extension PayBillVM{
    
    func loadPayBillData(_ finishCallback : @escaping ()->()){
        
        if self.page == 1 {
            self.modelArray.removeAll()
        }
        let params:[String : Any] = ["MerchantId":UserDefaults.UserInfo.string(forKey: .Id) ?? "",
                                     "PageNo":self.page,
                                     "PageSize":20]
        let urlString = BaseURL + APIPayOrderGet
        NetworkTools.request(.get, url: urlString, params: params, success: { (json) in
            
            do{
                let model = try JSONDecoder().decode(PayBillModel.self, from: json)
                for item:PaybillList in model.data.list{
                    self.modelArray.append(item)
                }
            }catch{
                print("买单model无法解析")
            }
            finishCallback()
            
        }) { (code, message) in
            AQAlert.show(type: .error, text: message)
            finishCallback()
        }
        
    }
    
    
    
}
