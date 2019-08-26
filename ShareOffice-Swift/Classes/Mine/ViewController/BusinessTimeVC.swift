//
//  BusinessTimeVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/2.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit



fileprivate let pickerHeight: CGFloat = 200

class BusinessTimeVC: UIViewController {
    
    
    var timeArray:Array = ["start","end"]
    var datePicker: DatePickerView?
    var selectTimeRow = 0
    lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.separatorStyle = .none
        tableview.isScrollEnabled = false
        tableview.register(MineCell.self, forCellReuseIdentifier: "TimeLabelCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .clear
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
}

extension BusinessTimeVC{
    
    fileprivate func setupUI(){
        
        view.backgroundColor = kBackgroundColor
        navigationController?.navigationBar.isHidden = false
        self.title = "营业时间"
        view.addSubview(tableview)
        
        let button = UIButton(type: .custom)
        button.setTitle("保存", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(saveBusinessTime), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        self.datePicker = DatePickerView(frame:  CGRect(x: 0, y: kScreenHeight, width: kScreentWidth, height: pickerHeight))
        self.datePicker?.delegate = self
        view.addSubview(self.datePicker!)
        
        tableview.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(kTopHeight+10)
        }
        
    }
    
    fileprivate func datePickerViewShow(){
        
        UIView.animate(withDuration: 0.3) {
            self.datePicker!.frame = CGRect(x: 0, y: kScreenHeight-pickerHeight, width: kScreentWidth, height: pickerHeight)
        }
    }
    fileprivate func datePickerViewHide(){
        
        UIView.animate(withDuration: 0.3) {
            self.datePicker!.frame = CGRect(x: 0, y: kScreenHeight, width: kScreentWidth, height: pickerHeight)
        }
    }
    @objc fileprivate func saveBusinessTime(){
        
        if (self.timeArray[0] == "start" || self.timeArray[1] == "end") {
            AQAlert.show(type: .info, text: "营业时间未设置完整")
        }else{
            let text = self.timeArray[0] + " - " + self.timeArray[1]
            AQAlert.show(type: .success, text: text)
            let url = BaseURL + APIMerchantBusinessTime + UserDefaults.UserInfo.string(forKey: .Id)!
            let params = ["BusinessStartTime":self.timeArray[0],
                          "BusinessEndTime":self.timeArray[1]]
            //修改营业时间网络请求
            NetworkTools.request(.put, url: url, params: params, success: { (json) in
                
                UserDefaults.UserInfo.set(value: self.timeArray[0], forKey: .BusinessStartTime)
                UserDefaults.UserInfo.set(value: self.timeArray[1], forKey: .BusinessEndTime)
                self.navigationController?.popViewController(animated: true)
                AQAlert.show(type: .success, text: "为您修改好啦~")
                
            }) { (code, message) in
                AQAlert.show(type: .error, text: message)
            }
        }
    }
    
}

extension BusinessTimeVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        datePickerViewShow()
        self.selectTimeRow = indexPath.row
        
    }
}
extension BusinessTimeVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MineCell = tableView.dequeueReusableCell(withIdentifier: "TimeLabelCell", for: indexPath) as! MineCell
        cell.arrowImg?.isHidden = true
        cell.titleLab.text = indexPath.row == 0 ? "请设置上班时间" : "请设置下班时间"
        return cell
    }
    
}
extension BusinessTimeVC:DatePickerViewDelegate {
    func getSelectedPickerBtn(sender: UIButton, str: String) {
        //tag == 1 点击确定按钮
        if sender.tag == 1 {
            let cell:MineCell = tableview.visibleCells[selectTimeRow] as! MineCell
            cell.titleLab.text = str
            timeArray[selectTimeRow] = str
        }
        datePickerViewHide()
    }
    
    
    
}
