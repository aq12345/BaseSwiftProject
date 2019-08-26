//
//  PayCountVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/9.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class PayCountVC: UIViewController {
    
    var paycountModel: payCountModel?
    lazy var todayLab: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "PingFangSC-Semibold", size: 42)
        label.textAlignment = .center
         label.text = "0"
        return label
    }()
    lazy var yesterdayLab: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "4d4d4d")
        label.font = UIFont(name: "PingFangSC-Medium", size: 22)
        label.textAlignment = .center
         label.text = "0"
        return label
    }()
    lazy var thisWeekLab: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "4d4d4d")
        label.font = UIFont(name: "PingFangSC-Medium", size: 22)
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    lazy var tableview : UITableView = {
        let tableView = UITableView()
        tableView.register(MineCell.self, forCellReuseIdentifier: "PayCountCell")
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = false
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 5
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        //隐藏导航栏下面的线
        navigationController?.navigationBar.clipsToBounds = true
    }
    
    
}

extension PayCountVC{
    
    func setupUI(){
        
        view.backgroundColor = kBackgroundColor
        //头部imageview部分
        let headerBackgroundImg = UIImageView(image: UIImage(named: "tongjibeijing"))
        view.addSubview(headerBackgroundImg)
        let maidanLab = UILabel()
        maidanLab.text = "买单统计(元)"
        maidanLab.textColor = .white
        maidanLab.font = UIFont(name: "PingFangSC-Medium", size: 16)
        headerBackgroundImg.addSubview(maidanLab)
        headerBackgroundImg.addSubview(todayLab)
        let todayIncomeLab = UILabel()
        todayIncomeLab.text = "今日收益"
        todayIncomeLab.textColor = .white
        todayIncomeLab.font = UIFont(name: "PingFangSC-Medium", size: 13)
        headerBackgroundImg.addSubview(todayIncomeLab)
        
        headerBackgroundImg.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(AQScreenHeight(height: 200))
        }
        maidanLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarHeight + 10)
            make.centerX.equalToSuperview()
        }
        todayLab.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        todayIncomeLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(todayLab.snp.bottom).offset(5)
        }
        //中间view
        let centerView = UIView()
        centerView.layer.cornerRadius = 5
        centerView.backgroundColor = .white
        view.addSubview(centerView)
        
        let yesterdayIncomeLab = UILabel()
        yesterdayIncomeLab.text = "昨日收益"
        yesterdayIncomeLab.textColor = UIColor(hex: "666666")
        yesterdayIncomeLab.font = UIFont(name: "PingFangSC-Medium", size: 13)
        centerView.addSubview(yesterdayIncomeLab)
        let thisWeekIncomeLab = UILabel()
        thisWeekIncomeLab.text = "本周收益"
        thisWeekIncomeLab.textColor = UIColor(hex: "666666")
        thisWeekIncomeLab.font = UIFont(name: "PingFangSC-Medium", size: 13)
        centerView.addSubview(thisWeekIncomeLab)
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = kLineColor
        centerView.addSubview(separatorLine)
        centerView.addSubview(yesterdayLab)
        centerView.addSubview(thisWeekLab)
        
        centerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(headerBackgroundImg.snp.bottom).offset(10)
            make.height.equalTo(80)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(1)
        }
        yesterdayIncomeLab.snp.makeConstraints { (make) in
            make.right.equalTo(separatorLine).offset(AQScreenWidth(width: -50))
            make.top.equalToSuperview().offset(20)
        }
        yesterdayLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(yesterdayIncomeLab)
            make.top.equalTo(yesterdayIncomeLab.snp.bottom).offset(AQScreenHeight(height: 10))
        }
        thisWeekIncomeLab.snp.makeConstraints { (make) in
            make.left.equalTo(separatorLine).offset(AQScreenWidth(width: 50))
            make.top.equalToSuperview().offset(20)
        }
        thisWeekLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(thisWeekIncomeLab)
            make.top.equalTo(yesterdayLab)
        }
        //底层tableview
        view.addSubview(self.tableview)
        self.tableview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(centerView.snp.bottom).offset(20)
            make.height.equalTo(AQScreenHeight(height: 250))
        }
        loadData()
    }
    
    fileprivate func loadData(){
        let url = BaseURL + APIMerchantProfit + UserDefaults.UserInfo.string(forKey: .Id)!
        NetworkTools.request(.get, url: url, params: nil, success: { (json) in
            
            do{
                let model = try JSONDecoder().decode(PayCountModel.self, from: json)
                self.paycountModel = model.data
                DispatchQueue.main.async {
                    self.todayLab.text =  String(model.data.today)
                    self.yesterdayLab.text = String(model.data.yesterday)
                    self.thisWeekLab.text = String(model.data.thisWeek)
                    self.tableview.reloadData()
                }
            }catch{
                print("账单model无法解析")
            }
            //            let decoder = JSONDecoder()
            //            let model = try? decoder.decode(PayCountModel.self, from: json)
            //            guard let model1 = model?.data else {
            //                print("账单model无法解析")
            //                return
            //            }
            //            self.paycountModel = model1
            //            DispatchQueue.main.async {
            //                self.todayLab.text =  String(model1.today)
            //                self.yesterdayLab.text = String(model1.yesterday)
            //                self.thisWeekLab.text = String(model1.thisWeek)
            //                self.tableview.reloadData()
            //            }
        }) { (code, message) in
            
        }
    }
    
}

extension PayCountVC: UITableViewDelegate{
    
}

extension PayCountVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MineCell = tableView.dequeueReusableCell(withIdentifier: "PayCountCell", for: indexPath) as! MineCell
        cell.arrowImg?.isHidden = true
        cell.descLabel.textColor = kOrangeColor
        cell.descLabel.isHidden = false
        
        guard let model = self.paycountModel else {
            return cell
        }
        switch indexPath.row {
        case 0:
            cell.titleLab.text = "上周"
            cell.descLabel.text = String(model.lastWeek)
        case 1:
            cell.titleLab.text = "本月"
            cell.descLabel.text = String(model.thisMonth)
        case 2:
            cell.titleLab.text = "上月"
            cell.descLabel.text = String(model.lastMonth)
        case 3:
            cell.titleLab.text = "今年"
            cell.descLabel.text = String(model.thisMonth)
        default:
            cell.titleLab.text = ""
        }
        return cell
    }
    
    
}
