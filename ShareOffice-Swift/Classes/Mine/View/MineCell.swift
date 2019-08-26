//
//  MineCell.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/29.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {
    
    var arrowImg : UIImageView?
    var lineView : UIView?
    lazy var  titleLab: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "333333")
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
        label.textAlignment = .center
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: "33333")
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
        label.textAlignment = .right
        label.isHidden = true
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


extension MineCell{
    
    fileprivate func setupUI(){
        
        addSubview(titleLab)
        
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        lineView = UIView()
        lineView!.backgroundColor = kLineColor
        addSubview(lineView!)
        
        lineView!.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        self.arrowImg = UIImageView(image: UIImage(named: "ic_youjiantou")?.withRenderingMode(.alwaysOriginal))
        addSubview(self.arrowImg!)
        self.arrowImg!.snp.makeConstraints { (make) in
            make.height.equalTo(10)
            make.width.equalTo(5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.arrowImg!.snp.left).offset(-20)
        }
        
    }
    
}
