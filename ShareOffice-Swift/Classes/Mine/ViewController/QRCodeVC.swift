//
//  QRCodeVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/1.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit
import Kingfisher
class QRCodeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
  

}

extension QRCodeVC{
    
    fileprivate func setupUI(){
        
        title = "店铺二维码"
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = false
        let QRImgView = UIImageView()
        let qrCode = UserDefaults.UserInfo.string(forKey: .QRCodePath) ?? "暂时没有"
        QRImgView.kf.setImage(with: URL(string: qrCode))
        view.addSubview(QRImgView)
        
        QRImgView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(200)
        }
    }
    
}
