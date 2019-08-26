//
//  MineVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/24.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class MineVC: UIViewController {
    
    let dataArray = ["营业时间：","店铺二维码：","修改密码：","清除缓存："]
    lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.separatorStyle = .none
        tableview.isScrollEnabled = false
        tableview.register(MineCell.self, forCellReuseIdentifier: "MineCell")
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()
    lazy var userHeaderImg : UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = 25
        imageview.clipsToBounds = true
        imageview.image = UIImage(named: "ic_xiaotouxiang")
        return imageview
    }()
    lazy var userNameLab : UILabel = {
        let label = UILabel()
        label.text = "Archer_Q的小店"
        label.font = UIFont(name: "PingFangSC-Regular", size: 16)
        label.textColor = UIColor.init(hex: "000000")
        return label
    }()
    lazy var userAddress : UILabel = {
        let label = UILabel()
        label.text = "浦东新区高东镇新园路168号"
        label.font =  UIFont(name: "PingFangSC-Regular", size: 13)
        label.textColor = kLineColor
        return label
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
    

        
    }
    override func viewWillAppear(_ animated: Bool) {
        //本页面不显示导航栏
        navigationController?.navigationBar.isHidden = true
       
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let cell:MineCell = tableview.visibleCells[0] as! MineCell
        let time =  (UserDefaults.UserInfo.string(forKey: .BusinessStartTime) ?? "") + " - " + (UserDefaults.UserInfo.string(forKey: .BusinessEndTime) ?? "")
        cell.descLabel.text = time
    }
    
    
}

extension MineVC{
    
    fileprivate func setupUI(){

        view.addSubview(userNameLab)
        view.addSubview(userHeaderImg)
        view.addSubview(tableview)
        view.addSubview(userAddress)
        
        
        let lineview = UIView()
        lineview.backgroundColor = kLineColor
        view.addSubview(lineview)
        let logOutBtn = UIButton(type: .custom)
        logOutBtn.setTitleColor(.white, for: .normal)
        logOutBtn.setTitle("退出当前账号", for: .normal)
        logOutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        logOutBtn.addTarget(self, action: #selector(logOutClicked), for: .touchUpInside)
        logOutBtn.backgroundColor = .black
        view.addSubview(logOutBtn)
       
        userHeaderImg.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(kTopHeight)
            make.height.width.equalTo(50)
        }
        
        userNameLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalTo(userHeaderImg).offset(-10)
        }
        userAddress.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLab)
            make.top.equalTo(userNameLab.snp.bottom).offset(5)
        }
        
        lineview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(1)
            make.top.equalTo(userHeaderImg.snp.bottom).offset(20)
        }
        tableview.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
            make.top.equalTo(lineview.snp.bottom).offset(60)
        }
        logOutBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(tableview).offset(80)
            make.height.equalTo(50)
        }
        loadLocalUserInfo()
        
    }
    fileprivate func loadLocalUserInfo(){
        
        self.userNameLab.text = UserDefaults.UserInfo.string(forKey: .Name)
        self.userAddress.text = UserDefaults.UserInfo.string(forKey: .MerchantAddress) //ic_xiaotouxiang
    //    self.userHeaderImg.kf.setImage(with: URL(string: UserDefaults.UserInfo.string(forKey: .TIcon)!))
    }
    @objc func logOutClicked(){
        
        UserDefaults.UserInfo.set(value: nil, forKey: .Password)
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: kNotificationUserChange), object: "0")
    }
   
}

extension MineVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //tableview
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = BusinessTimeVC()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = QRCodeVC()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = ChangePasswordVC()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            Tool.clearCache()
            AQAlert.show(type: .success, text: "清除缓存成功")
            self.tableview.reloadData()
            break
        default: break
            
        }
    }
}

extension MineVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "MineCell", for: indexPath) as! MineCell
        cell.titleLab.text = dataArray[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.descLabel.isHidden = false
           
        case 3:
            cell.descLabel.isHidden = false
            cell.descLabel.text = Tool.fileSizeOfCache()
        default:
            break
        }
        return cell
    }
    
    
}
