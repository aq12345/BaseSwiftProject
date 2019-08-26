//
//  ForgetPasswordVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/6/4.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit
class ForgetPasswordVC: UIViewController {
    
    fileprivate var okBtn : UIButton?
    fileprivate lazy var phoneTextfield :UITextField = {
        let textfiled = UITextField(type: .Phone)
        textfiled.addTarget(self, action: #selector(textFieldChange(text:)), for: .editingChanged)
        
        return textfiled
    }()
    fileprivate lazy var vertifyCodeTextfield : UITextField = {
        
        let texfield = UITextField(type: .VertifyCode)
        texfield.addTarget(self, action: #selector(textFieldChange(text:)), for: .editingChanged)
        return texfield
    }()
    
    fileprivate lazy var passwordTextfield : UITextField = {
        
        let texfield = UITextField(type: .Password)
        texfield.placeholder = "请输入新密码"
        texfield.addTarget(self, action: #selector(textFieldChange(text:)), for: .editingChanged)
        
        return texfield
    }()
    fileprivate lazy var vertifyCodeBtn: UIButton = {
        let btn  = UIButton(type: .custom)
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(kOrangeColor, for: .normal)
        btn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 11)
        btn.addTarget(self, action: #selector(getVertifyCode), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    
}

extension ForgetPasswordVC{
    
    
    fileprivate func setupUI(){
        
        view.backgroundColor = UIColor.white
        view.addSubview(phoneTextfield)
        view.addSubview(vertifyCodeTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(vertifyCodeBtn)
        
        okBtn = UIButton(type: .custom)
        okBtn?.setTitle("确定", for: .normal)
        okBtn?.setTitleColor(UIColor.white, for: .normal)
        okBtn?.backgroundColor = UIColor.lightGray
        okBtn?.isEnabled = false
        okBtn?.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 15)
        okBtn?.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        okBtn?.layer.cornerRadius = 5.0
        view.addSubview(okBtn!)
        
        let titleLab = UILabel()
        titleLab.text = "瑞铂汇"
        titleLab.textColor = UIColor(hex: "d6d6d6")
        titleLab.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(titleLab)
        
        let shanghuLab = UILabel()
        shanghuLab.text = "商户端"
        shanghuLab.textColor = UIColor(hex: "d6d6d6")
        shanghuLab.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(shanghuLab)
        
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "ic_fanhui")?.withRenderingMode(.alwaysOriginal), for: .normal)
        backBtn.contentHorizontalAlignment = .left
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(backBtn)
        
        let lineview1 = UIView()
        lineview1.backgroundColor = UIColor(red: 202 / 255.0, green: 202 / 255.0, blue: 202 / 255.0, alpha: 1.0)
        view.addSubview(lineview1)
        
        let lineview2 = UIView()
        lineview2.backgroundColor = UIColor(red: 202 / 255.0, green: 202 / 255.0, blue: 202 / 255.0, alpha: 1.0)
        view.addSubview(lineview2)
        
        let lineview3 = UIView()
        lineview3.backgroundColor = UIColor(red: 202 / 255.0, green: 202 / 255.0, blue: 202 / 255.0, alpha: 1.0)
        view.addSubview(lineview3)
        
        
       
        
        backBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarHeight)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        shanghuLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        }
        
        phoneTextfield.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(shanghuLab.snp.bottom).offset(40)
            make.height.equalTo(40)
        }
        
        lineview1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(1)
            make.bottom.equalTo(phoneTextfield)
        }
        vertifyCodeTextfield.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(200)
            make.left.equalTo(phoneTextfield)
            make.top.equalTo(phoneTextfield.snp.bottom).offset(20)
        }
        vertifyCodeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(vertifyCodeTextfield)
            make.right.equalTo(phoneTextfield)
        }
        lineview2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(1)
            make.bottom.equalTo(vertifyCodeBtn)
        }
        passwordTextfield.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
            make.top.equalTo(vertifyCodeTextfield.snp.bottom)
        }
        lineview3.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(1)
            make.bottom.equalTo(passwordTextfield)
        }
        okBtn?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(lineview3.snp.bottom).offset(30)
            make.height.equalTo(40)
        })
    }
}

//统一处理点击事件
extension ForgetPasswordVC{
    
    @objc fileprivate func back(){
        
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func getVertifyCode(){
       
        if phoneTextfield.text?.count == 11 {
            
            let url = BaseURL + APIMerchantVertifyCode + self.phoneTextfield.text!
            NetworkTools.request(.get, url: url, params: nil, success: { (json) in
                
                AQAlert.show(type: .success, text: "验证码稍后将会发送至您的手机")
                self.vertifyCodeBtn.countDown(count: 60)
            }) { (code, message) in
                AQAlert.show(type: .error, text: message)
            }
        }else{
            AQAlert.show(type: .error, text: "请填写正确手机号")
        }
        
    }
    @objc fileprivate func okButtonClicked(){
        let url = BaseURL + APIMerchantForgetPassword
        let params = ["Mobile":self.phoneTextfield.text!,
                      "Password":self.passwordTextfield.text!.md5,
                      "ValidateCode":self.vertifyCodeTextfield.text!]
        
        NetworkTools.request(.post, url: url, params: params, success: { (json) in
            self.back()
            AQAlert.show(type: .success, text: "找回密码成功")
        }) { (code, message) in
            
            AQAlert.show(type: .error, text: message)
        }
    }
    @objc fileprivate func textFieldChange(text: UITextField){
        
        if phoneTextfield.text!.count == 11 && passwordTextfield.text!.count > 0 && vertifyCodeTextfield.text!.count > 0{
            
            okBtn?.isEnabled = true
            okBtn?.backgroundColor = UIColor.black
        }else{
            okBtn?.isEnabled = false
            okBtn?.backgroundColor = UIColor.lightGray
        }
    }
}
