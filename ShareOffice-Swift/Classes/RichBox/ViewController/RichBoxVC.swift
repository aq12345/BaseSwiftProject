//
//  RichBoxVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/24.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit

class RichBoxVC: UIViewController {

    lazy var tableview : UITableView = {
        let tableView = UITableView()
        tableView.register(RichBoxListCell.self, forCellReuseIdentifier: "RichBoxCell")
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
    
        return tableView
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
    }



}

extension RichBoxVC{
    
    fileprivate func setupUI(){
        //隐藏导航栏下面的线
        navigationController?.navigationBar.clipsToBounds = true
        self.title = "统计"
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(kTopHeight)
        }
    }
}

extension RichBoxVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension RichBoxVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :RichBoxListCell = self.tableview.dequeueReusableCell(withIdentifier: "RichBoxCell", for: indexPath) as! RichBoxListCell
        return cell
    }
    
    
    
}
