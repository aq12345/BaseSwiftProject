//
//  RichBoxListCell.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/28.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class RichBoxListCell: UITableViewCell {
    
    //懒加载UI
    lazy var  titleImage : UIImageView = {
        
       let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 10
        imageview.image = UIImage(named: "ic_shouyeguanggao")?.withRenderingMode(.alwaysOriginal)
        
        return imageview
    }()
    lazy var titleLab : UILabel = {
        
        let lablel = UILabel()
        lablel.textColor = UIColor.init(hex: "000000")
        lablel.font = UIFont(name: "PingFangSC-Medium", size: 13)
        lablel.text = "这里是标题文本"
        return lablel
    }()
    lazy var addressLab :UILabel = {
       
        let label = UILabel()
        label.textColor = UIColor.init(hex: "808080")
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
        label.text = "地址文本"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension RichBoxListCell{
    
     fileprivate func setupUI(){
        
        addSubview(titleImage)
        addSubview(titleLab)
        addSubview(addressLab)
        titleImage.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(170)
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(titleImage.snp.bottom).offset(5)
            
        }
        addressLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(5)
        }
    }
}
//对外暴露的方法
extension RichBoxListCell{
    
    
    
}
