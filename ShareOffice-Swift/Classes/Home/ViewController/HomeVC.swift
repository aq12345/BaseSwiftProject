//
//  HomeVC.swift
//  ShareOffice-Swift
//
//  Created by apple-mini on 2018/5/24.
//  Copyright © 2018年 hcj. All rights reserved.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    //轮播图
    var cylecleScrollview: WRCycleScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "买单"
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    
}

extension HomeVC{
    
    fileprivate func setupUI(){
        
        let imageArr = ["ic_shouyeguanggao","ic_shouyeguanggao1"]
        let scrollFrame = CGRect(x: 0, y: -10, width: kScreentWidth, height: 315)
        cylecleScrollview = WRCycleScrollView(frame: scrollFrame, type: .LOCAL, imgs: imageArr)
        cylecleScrollview?.showPageControl = false
        view.addSubview(cylecleScrollview!)
        
        //下方按钮布局
        let bookBtn = UIButton(type: .custom)
        buttonCommonSet(button: bookBtn, tag: 0)
        bookBtn.snp.makeConstraints { (make) in
            make.top.equalTo((cylecleScrollview?.snp.bottom)!).offset(50)
            make.left.equalToSuperview().offset(50)
        }
        bookBtn.set(image: UIImage(named: "ic_dinghuiyishi"), title: "订会议室", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        
        //开锁按钮
        let unlockBtn = UIButton(type: .custom)
        buttonCommonSet(button: unlockBtn ,tag: 1)
        
        unlockBtn.snp.makeConstraints { (make) in
            make.top.equalTo((cylecleScrollview?.snp.bottom)!).offset(50)
            make.right.equalToSuperview().offset(-50)
        }
        unlockBtn.set(image: UIImage(named: "ic_kaisuo3"), title: "开锁", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
       
        
    }
    
    //button统一的设置样式
    private func buttonCommonSet(button: UIButton ,tag: NSInteger){
        
        button.setTitleColor(UIColor.init(hex:"666666"), for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFangSC-regular", size: 13)
        button.tag = tag
        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        view.addSubview(button)
       
    }
    
}


extension HomeVC{
    
    @objc func buttonClicked(sender: UIButton){
        
        switch sender.tag {
        case 0:
          print("点击了订会议室--buttonIndex=0")
          let vc = PayBillVC()
          navigationController?.pushViewController(vc, animated: true)
        break
        case 1:
            print("点击了开锁--buttonIndex=1")
        break
        default:
            print("什么也不做哦--buttonIndex=2")
            break
        }
    }
}

