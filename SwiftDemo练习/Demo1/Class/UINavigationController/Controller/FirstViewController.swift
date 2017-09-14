//
//  FirstViewController.swift
//  TestSwiftDemo
//
//  Created by 智衡宋 on 2017/7/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension FirstViewController {
    
    
    func setupUI() {
        //左上角返回按钮
        let  item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(returnup))
        self.navigationItem.leftBarButtonItem = item
        
        
        let pushButton = UIButton(type: .system)
        pushButton.backgroundColor = .red
        pushButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        pushButton.addTarget(self, action: #selector(pushNextView), for: UIControlEvents.touchUpInside)
        view.addSubview(pushButton)
        
    }
    
    //跳转到下一个界面
    func pushNextView() {
        
        let second = SecondViewController()
        self.navigationController?.pushViewController(second, animated: true)
        
    }
    
    
    //返回上一个界面
    func returnup() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}


