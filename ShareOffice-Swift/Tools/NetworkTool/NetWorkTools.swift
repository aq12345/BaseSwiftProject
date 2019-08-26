//
//  NetWorkTools.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/16.
//  Copyright © 2018年 hcj. All rights reserved.
//

import Foundation
import Alamofire
import MBProgressHUD

enum MethodType{
    case get
    case post
    case put
    case delete
}
struct BaseModel: Codable {
    let Code: Int
    let ShowData: String?
    
}

class NetworkTools {
    
    
    /// 请求方法 返回值JSON
    ///
    /// - Parameters:
    ///   - type: 请求类型
    ///   - URLString: 链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    class func request(_ type : MethodType, url : String, params : [String : Any]?, success : @escaping (_ data : Data)->(), failure : ((Int?, String) ->Void)?) {
        // 1.获取类型
        var  encode:ParameterEncoding = JSONEncoding.default //Get请求需要URLEncode
        let method: HTTPMethod
        switch (type){
        case .get:
            method = HTTPMethod.get
            encode =  URLEncoding.default
        case .post:
            method = HTTPMethod.post
        case .delete:
            method = HTTPMethod.delete
        case .put:
            method = HTTPMethod.put
        }
        // 2.发送网络请求
        AQProgressHUD.show()
        Alamofire.request(url, method: method, parameters: params,encoding: encode ).responseJSON{ (response) in
            AQProgressHUD.hide()
            guard let json = response.data else {
                return
            }
            
            debugPrint(response)
            switch response.result {
            case let .success(response):
                do {
                    // ***********这里可以统一处理错误码，统一弹出错误 ****
                    do{
                        let model = try JSONDecoder().decode(BaseModel.self, from: json)
                        switch (model.Code) {
                        case 200 :
                            //数据返回正确
                            success(json)
                            break
                        case 202:
                            //登录错误
                            if let failureBlack = failure {
                                failureBlack(model.Code ,model.ShowData!)
                            }
                            break
                        default:
                            //其他错误
                            failureHandle(failure: failure, stateCode: model.Code, message: model.ShowData!)
                            break
                        }
                    }catch{
                        
                        if let failureBack = failure{
                            failureBack(nil, "解析失败")
                        }
                    }
            }//do{}
            case let .failure(error):
                failureHandle(failure: failure, stateCode: nil, message: error.localizedDescription)
            }
        }
        //错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            
            if let failureBlack = failure {
                failureBlack(stateCode ,message)
            }
        }

        //登录弹窗 - 弹出是否需要登录的窗口
        func alertLogin(_ title: String?) {
            //TODO: 跳转到登录页的操作：
        }
    }
    
    
}

