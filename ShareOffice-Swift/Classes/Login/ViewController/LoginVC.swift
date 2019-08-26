//
//  LoginVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/29.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit
import Kingfisher
class LoginVC: UIViewController {
    
    
    lazy var phoneText: UITextField = {
        let text = UITextField.init(type: .Phone)
        text.placeholder = "请输入账号"
        text.keyboardType = .default
        return text
    }()
    lazy var passwordText: UITextField  = {
        let pass = UITextField.init(type: .Password)
        
        return pass
    }()
    lazy var okBtn: UIButton = {
        let okbutton = UIButton(type: .custom)
        okbutton.setTitle("登录", for: .normal)
        okbutton.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        okbutton.setTitleColor(UIColor.white, for: .normal)
        okbutton.isEnabled = false;
        okbutton.backgroundColor = UIColor.gray
        okbutton.layer.cornerRadius = 5.0
        return okbutton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bidingControll()
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: kNotificationUserChange), object: "1")
    }
    override func viewDidAppear(_ animated: Bool) {
        let userLengh = UserDefaults.UserInfo.string(forKey: .PhoneNumber)?.count ?? 0
        if   userLengh > 0 {
            self.phoneText.text = UserDefaults.UserInfo.string(forKey: .PhoneNumber)
            self.passwordText.text = UserDefaults.UserInfo.string(forKey: .Password)
            self.okBtn.isEnabled = true;
            self.okBtn.backgroundColor = UIColor.black
        }
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.navigationController?.topViewController
    }
   
}


extension LoginVC{
    
    fileprivate func setupUI(){
        
        view.addSubview(phoneText)
        view.addSubview(passwordText)
        view.addSubview(okBtn)
        
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
        
        let forgetBtn = UIButton(type: .custom)
        forgetBtn.setTitle("忘记密码", for: .normal)
        forgetBtn.setTitleColor(kOrangeColor, for: .normal)
        forgetBtn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 11)
        forgetBtn.addTarget(self, action:#selector(forgetButtonClick(sender:)), for: .touchUpInside)
        view.addSubview(forgetBtn)
        
        let lineview1 = UIView()
        lineview1.backgroundColor = kLineColor
        view.addSubview(lineview1)
        
        
        let lineview2 = UIView()
        lineview2.backgroundColor = kLineColor
        view.addSubview(lineview2)
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        shanghuLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        }
        
        phoneText.snp.makeConstraints { (make) in
            make.top.equalTo(shanghuLab.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        lineview1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(1)
            make.top.equalTo(phoneText.snp.bottom)
        }
        passwordText.snp.makeConstraints { (make) in
            make.top.equalTo(phoneText.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        lineview2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(1)
            make.bottom.equalTo(passwordText)
        }
        forgetBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(lineview2).offset(40)
            make.right.equalToSuperview().offset(-30)
            
        }
        okBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordText.snp.bottom).offset(AQScreenWidth(width: 100))
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(45)
        }
        
    }
    fileprivate func  bidingControll(){
        
        okBtn.addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
        phoneText.addTarget(self, action: #selector(textFieldChange(textField:)), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(textFieldChange(textField:)), for: .editingChanged)
        
        
    }
    
    
    
}

extension LoginVC{
    
    @objc fileprivate func forgetButtonClick(sender:UIButton){
        
        let vc = ForgetPasswordVC()
        present(vc, animated: true, completion: nil)
    }
    
    @objc fileprivate func buttonClicked(sender: UIButton){
        
        guard let account = self.phoneText.text else { return }
        if account.count == 0 {
             AQAlert.show(type: .error, text: "账号不能为空")
             return
        }
        guard let password = self.passwordText.text else { return }
        if password.count == 0 {
             AQAlert.show(type: .error, text: "密码不能为空")
            return
        }
        let params = ["account":account,
                      "password":password.md5]
        let urlString = BaseURL + APIMerchantLogin
        print("login-------",params)
        NetworkTools.request(.post, url: urlString, params: params, success: { (json) in

            do{
                let model = try JSONDecoder().decode(UserModel.self, from: json)
                self.saveUserInfo(model.data)
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: kNotificationUserChange), object: "1")

            }catch{
                 print("用户model无法解析")
            }
        }) { (code, message) in
             AQAlert.show(type: .error, text: message)
        }
        
    }
    @objc fileprivate func textFieldChange(textField: UITextField){
        
        if phoneText.text!.count > 0 && passwordText.text!.count > 0 {
            okBtn.isEnabled = true
            okBtn.backgroundColor = UIColor.init(hex:"282828")
            
        }else{
            
            okBtn.isEnabled = false
            okBtn.backgroundColor = UIColor.lightGray
            
        }
    }
}

extension LoginVC{
    
    private func saveUserInfo(_ model : UserInfo){
        //成功登陆保存用户数据
        UserDefaults.UserInfo.set(value: self.phoneText.text, forKey: .PhoneNumber)
        UserDefaults.UserInfo.set(value: self.passwordText.text, forKey: .Password)
        UserDefaults.UserInfo.set(value: model.businessStartTime, forKey: .BusinessStartTime)
        UserDefaults.UserInfo.set(value: model.businessEndTime, forKey: .BusinessEndTime)
        UserDefaults.UserInfo.set(value: model.name, forKey: .Name)
        UserDefaults.UserInfo.set(value: String(model.id), forKey: .Id)
        UserDefaults.UserInfo.set(value: model.merchantAddress, forKey: .MerchantAddress)
        UserDefaults.UserInfo.set(value: model.qrCodePath, forKey: .QRCodePath)
        UserDefaults.UserInfo.set(value: model.shopLogoPath, forKey: .TIcon)
    }
}
