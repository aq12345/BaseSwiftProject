//
//  DatePickerView.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/3.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate: NSObjectProtocol {
    
    func getSelectedPickerBtn(sender:UIButton, str: String)
}
class DatePickerView: UIView {
    
    weak var delegate: DatePickerViewDelegate?
    var datePicker: UIPickerView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DatePickerView{
    
    fileprivate func setupUI(){
        
        self.backgroundColor = UIColor.white
        self.datePicker = UIPickerView()
        datePicker?.delegate = self
        datePicker?.dataSource = self
        addSubview(datePicker!)
        
        let cancleBtn = UIButton(type: .custom)
        cancleBtn.setTitle("取消", for: .normal)
        cancleBtn.setTitleColor(UIColor.black, for: .normal)
        cancleBtn.tag = 0
        cancleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        cancleBtn.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        addSubview(cancleBtn)
        
        let okBtn = UIButton(type: .custom)
        okBtn.setTitle("确定", for: .normal)
        okBtn.tag = 1
        okBtn.setTitleColor(kOrangeColor, for: .normal)
        okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        okBtn.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        addSubview(okBtn)
        
        datePicker?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        })
        cancleBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
        }
        okBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
    }
    
    @objc fileprivate func buttonClicked(_ sender :UIButton){
        
        let hours = datePicker!.selectedRow(inComponent: 0) > 9 ? String(datePicker!.selectedRow(inComponent: 0)) : "0\(datePicker!.selectedRow(inComponent: 0))"
        let minutes =  datePicker!.selectedRow(inComponent: 1) > 9 ? String(datePicker!.selectedRow(inComponent: 1)) : "0\(datePicker!.selectedRow(inComponent: 1))"
        let message: String =  hours + ":" + minutes
        if delegate != nil {
            delegate?.getSelectedPickerBtn(sender: sender, str: message)
        }
    }
    
}

extension DatePickerView:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let number:Int = component==0 ? 24 : 60
        return number
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let time: String = row > 9 ? "\(row)" : "0\(row)"
        return time
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
}
