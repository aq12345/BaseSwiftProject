//
//  PayBillCell.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/7/31.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class PayBillCell: UITableViewCell {
    
    var model: PaybillList? {
         // 监听属性已经发生改变: 已经改变
        didSet{
            self.userNameLab.text = "用户: " + (model?.buyerMobile ?? "")
            self.indentStatusLab.text = model?.payStateName
            self.consumeLab.text = "消费: ￥" + String(model?.totalAmount ?? 0)
            //这里要用富文本了
            self.discountLab.isHidden = false
            if model?.rebate == 0 {
                self.discountLab.isHidden = true
            }
            let attributeStr:NSMutableAttributedString = NSMutableAttributedString(string:"折扣: ")
            let addStr = NSAttributedString(string: "-￥" + String(model?.rebate ?? 0), attributes: [NSAttributedStringKey.foregroundColor: kOrangeColor])
            attributeStr.append(addStr)
            self.discountLab.attributedText = attributeStr
            //
            self.sorceLab.isHidden = false
            if model?.integralRabate == 0 {
                self.sorceLab.isHidden = true
            }
            let attributeStr1:NSMutableAttributedString = NSMutableAttributedString(string:"积分: ")
            let addStr1 = NSAttributedString(string: "-￥" + String(model?.integralRabate ?? 0), attributes: [NSAttributedStringKey.foregroundColor: kOrangeColor])
            attributeStr1.append(addStr1)
            self.sorceLab.attributedText = attributeStr1
            //
            self.timeLab.text = model?.orderTime ?? ""
            self.payNumerLab.text = "实付: ￥" + String(model?.realPayment ?? 0)
        }
        
    }
    lazy var userNameLab: UILabel = {
        let label = UILabel.init(color: UIColor.init(hex: "4d4d4d"))
        label.text = "Archer_Q"
        return label
    }()
    lazy var indentStatusLab: UILabel = {
        let label = UILabel.init(color: UIColor.init(hex: "808080"))
        label.text = "已完成"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    lazy var consumeLab :UILabel = {//消费lab
        let label = UILabel.init(color: UIColor.init(hex: "808080"))
        label.text = "消费："
        return label
    }()
    lazy var discountLab : UILabel = {//折扣lab
        let label = UILabel.init(color: UIColor.init(hex: "808080"))
        let prefixStr = "折扣："
        label.text = prefixStr
        
        return label
    }()
    lazy var sorceLab : UILabel = {//积分lab
        let label = UILabel.init(color: UIColor.init(hex: "808080"))
        label.text = "积分："
        return label
    }()
    lazy var timeLab: UILabel = {//日期lab
        let label = UILabel.init(color: UIColor.init(hex: "999999"))
        label.text = "2018年06月1日 11：25🐱"
        return label
    }()
    lazy var payNumerLab: UILabel = {//实付金额lab
        let label = UILabel.init(color: UIColor.init(hex: "4d4d4d"))
        label.text = "实付：￥🐱"
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

extension PayBillCell{
    
    fileprivate func setupUI() {
        
        backgroundColor = UIColor.clear
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.cornerRadius = 5.0
        addSubview(backgroundView)
        backgroundView.addSubview(userNameLab)
        backgroundView.addSubview(indentStatusLab)
        backgroundView.addSubview(consumeLab)
        backgroundView.addSubview(discountLab)
        backgroundView.addSubview(sorceLab)
        backgroundView.addSubview(timeLab)
        backgroundView.addSubview(payNumerLab)
        
        let line = UIView()
        line.backgroundColor = kLineColor
        backgroundView.addSubview(line)
        
        backgroundView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        userNameLab.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView).offset(5)
            make.left.equalTo(backgroundView).offset(10)
        }
        indentStatusLab.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLab)
            make.right.equalTo(backgroundView).offset(-10)
        }
        consumeLab.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLab)
            make.top.equalTo(userNameLab.snp.bottom).offset(5)
        }
        discountLab.snp.makeConstraints { (make) in
            make.left.equalTo(consumeLab.snp.right).offset(15)
            make.top.equalTo(consumeLab)
        }
        sorceLab.snp.makeConstraints { (make) in
            make.top.equalTo(discountLab)
            make.left.equalTo(discountLab.snp.right).offset(15)
        }
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(consumeLab.snp.bottom).offset(5)
        }
        timeLab.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom).offset(5)
            make.left.equalTo(consumeLab)
            make.bottom.equalTo(backgroundView).offset(-5)
        }
        payNumerLab.snp.makeConstraints { (make) in
            make.top.equalTo(timeLab)
            make.right.equalTo(backgroundView).offset(-10)
        }
    }
    
}

