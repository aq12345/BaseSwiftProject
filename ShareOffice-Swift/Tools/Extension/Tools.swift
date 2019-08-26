//
//  Tools+Extension.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/1.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class Tool:NSObject {
    
   class func fileSizeOfCache() -> String {
        // 取出cache文件夹目录 缓存文件都在这个目录下
    let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        //缓存目录路径
    print("🐱🐱🐱\(cachePath!)")
        
        // 取出文件夹下所有文件数组
    let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        var size: Float = 0
        for file in fileArr! {
            
            // 把文件名拼接到路径中
            let path = cachePath?.appendingFormat("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path!)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += bcd as! Float
                }
            }
        }
        let mm = String(format: "%.1f MB", size / 1024.0 / 1024.0 )
        
        return mm
    }
    
    class func clearCache(){
       // var result = true
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            // 拼接文件路径
            let path = cachePath?.appending("/\(file)")
            if FileManager.default.fileExists(atPath: path!) {
                // 循环删除
                do {
                    try FileManager.default.removeItem(atPath: path!)
                } catch {
                    // 删除失败
                  //  result = false
                }
            }
        }
        
    }
    //二维码生成
    class func generateQRCode(messgae:String,width:CGFloat,height:CGFloat) -> UIImage {
        var returnImage:UIImage?
        if (messgae.count > 0 && width > 0 && height > 0){
            let inputData = messgae.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as NSData
            // CIQRCodeGenerator
            let filter = CIFilter.init(name: "CIQRCodeGenerator")!
            filter.setValue(inputData, forKey: "inputMessage")
            var ciImage = filter.outputImage!
            let min = width > height ? height :width;
            let scaleX = min/ciImage.extent.size.width
            let scaleY = min/ciImage.extent.size.height
            ciImage = ciImage.transformed(by: CGAffineTransform.init(scaleX: scaleX, y: scaleY))
            returnImage = UIImage.init(ciImage: ciImage)
        }else {
            returnImage = nil;
        }
        return returnImage!
    }
    
}

