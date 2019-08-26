//
//  PasswordCell.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/2.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

typealias CellInputText = (String) -> Void
class PasswordCell: UITableViewCell {

    var backClosure: CellInputText?
    lazy var textField: UITextField = {
       let text = UITextField(type: .Password)
        text.addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
        return text
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PasswordCell{
    
    fileprivate func setupUI(){
        
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview()
        }
        let line = UIView()
        line.backgroundColor = kLineColor
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @objc fileprivate func textChanged(sender:UITextField){
        
        if backClosure != nil {
            backClosure!(sender.text!)
        }
    }
}


