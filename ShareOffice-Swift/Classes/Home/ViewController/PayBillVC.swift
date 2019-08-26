//
//  PayBillVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/8/1.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class PayBillVC: UIViewController {
    
    var emptyLab = UILabel()
    var paybillVM = PayBillVM()
    lazy var tableview: UITableView = {
        let table = UITableView()
        table.register(PayBillCell.self, forCellReuseIdentifier: "PayBillCell")
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 44.0
        table.rowHeight = UITableViewAutomaticDimension
        table.separatorStyle = .none
        table.backgroundColor = kBackgroundColor
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = false
    }

}


extension PayBillVC{
    
    fileprivate func setupUI(){
        
        self.navigationItem.title = "买单"
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(kTopHeight)
        }
        tableview.mj_header = MJRefreshNormalHeader()
        tableview.mj_header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableview.mj_footer = MJRefreshBackNormalFooter()
        tableview.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        tableview.mj_header.beginRefreshing()
        
    }
    @objc fileprivate func headerRefresh(){
        //上拉刷新
        self.paybillVM.page = 1
        self.paybillVM.loadPayBillData {
            
            self.paybillVM.modelArray.count == 0 ? self.showEmptyLabel():self.hideLabel()
            self.tableview.reloadData()
            self.tableview.mj_header.endRefreshing()
        }
     
    }
    @objc fileprivate func footerRefresh(){
        //下拉加载更多
        self.paybillVM.page += 1
        self.paybillVM.loadPayBillData {
            self.tableview.reloadData()
            self.tableview.mj_footer.endRefreshing()
            
        }
    }
    fileprivate func showEmptyLabel(){
    
        emptyLab.text = "暂时没有买单数据~"
        emptyLab.font = UIFont.systemFont(ofSize: 15)
        emptyLab.textColor = kOrangeColor
        self.tableview.addSubview(emptyLab)
        emptyLab.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    fileprivate func hideLabel(){
        
        self.emptyLab.removeFromSuperview()
    }
}


extension PayBillVC: UITableViewDelegate{
    
  
    
}
extension PayBillVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paybillVM.modelArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PayBillCell = tableView.dequeueReusableCell(withIdentifier: "PayBillCell", for: indexPath) as! PayBillCell
        cell.model = self.paybillVM.modelArray[indexPath.row]
        return cell
    }
    
    
    
}
