//
//  ChangePasswordVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/2.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {

    var oldStr = ""
    var newStr = ""
    var repeaStr = ""
    lazy var tableview:UITableView = {
       let table = UITableView()
        table.register(PasswordCell.self, forCellReuseIdentifier: "PasswordCell")
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = UIColor.clear
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

}


extension ChangePasswordVC{
    
    fileprivate func setupUI(){
        
        view.backgroundColor = kBackgroundColor
        navigationController?.navigationBar.isHidden = false
        title = "修改密码"
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(kTopHeight+10)
        }
        let button = UIButton(type: .custom)
        button.setTitle("保存", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(saveUserPassword), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
    }
    @objc fileprivate func saveUserPassword(){
        
        if self.newStr.count == 0 || self.repeaStr.count == 0 || self.oldStr.count == 0{
            AQAlert.show(type: .error, text: "密码不能为空")
        }else if self.newStr != self.repeaStr{
            AQAlert.show(type: .error, text: "密码输入不一致")
        }else if self.newStr == self.oldStr{
            AQAlert.show(type: .error, text: "新密码不能与旧密码一样")
        }else{
            let url = BaseURL + APIMerchantChangPassword + UserDefaults.UserInfo.string(forKey: .Id)!
            let params = ["Password": self.repeaStr.md5]
            NetworkTools.request(.put, url: url, params: params, success: { (json) in
                
                UserDefaults.UserInfo.set(value: self.repeaStr, forKey: .Password)
                self.navigationController?.popViewController(animated: true)
                AQAlert.show(type: .success, text: "修改密码成功")
            }) { (code, message) in
                AQAlert.show(type: .error, text: message)
                
            }
            
            
        }
       
    }
}

extension ChangePasswordVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension ChangePasswordVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PasswordCell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordCell
        switch indexPath.row {
        case 0:
            cell.textField.placeholder = "请输入旧密码"
            cell.backClosure = { (text) in
                print("第一行密码\(text)")
                self.oldStr = text
            }
            break
        case 1:
            cell.textField.placeholder = "请输入新密码"
            cell.backClosure = { (text) in
                print("第二行密码\(text)")
                self.newStr = text
            }
            break
        case 2:
            cell.textField.placeholder = "确认新密码"
            cell.backClosure = { (text) in
                print("第三行密码\(text)")
                self.repeaStr = text
            }
            break
        default:
            break
        }
        
        return cell
    }
    
}
