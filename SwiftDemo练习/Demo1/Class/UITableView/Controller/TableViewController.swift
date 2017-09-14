//
//  TableViewController.swift
//  TestSwiftDemo
//
//  Created by 智衡宋 on 2017/7/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    
    lazy var tableView : UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK:- 加载页面

extension TableViewController {
    
    func setupUI()  {
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = UIColor.red
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }
    
}

// MARK:- 代理方法

extension TableViewController: UITableViewDataSource,UITableViewDelegate {
    
    
    //数据源代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = "数据格式 ： \(indexPath.row)"
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    //交互代理方法
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("数据格式 ： \(indexPath.row)")
    }
    
}
