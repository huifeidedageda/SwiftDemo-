//
//  OperationViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/2.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class OperationViewController: UIViewController {

    //tableView
    @IBOutlet weak var tableView: UITableView!
    //数据源
    lazy var dataSource : [Any] = ["Basic","Priority","Dependency","CollectionDemo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView注册
        tableViewRegiester()
        
    }

    
}


//OperationViewController控制器方法

extension OperationViewController {
    
    //注册
    func tableViewRegiester() {
        
        tableView.register(UINib.init(nibName: "OperationTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "OperationTableViewCell")
        
    }
    
}

//tableView 代理方法
extension OperationViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OperationTableViewCell", for: indexPath) as! OperationTableViewCell
        cell.title.text = dataSource[indexPath.row] as? String
        return cell
        
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc  =  OperationDetailViewController()
        let nav = UINavigationController.init(rootViewController: vc)
        vc.title = dataSource[indexPath.row] as? String
        
        switch indexPath.row {
        case 0:
            vc.demoType = DemoType.basic
            break
        case 1:
            vc.demoType = DemoType.priority
            break
        case 2:
            vc.demoType = DemoType.dependency
            break
        case 3:
            vc.demoType = DemoType.collection
            break
        default:
            break
        }
        self.present(nav, animated: true, completion: nil)
        
    }
    
}
    

//基础使用
extension OperationViewController {
    
    //基础使用
    func basicOperation(){
        
        let op = Operation.init()
        op.completionBlock = {
            
            print(#function,#line,Thread.current)
        }
        
        let opQueue = OperationQueue.init()
        opQueue.addOperation(op)
        
    }
    //BlockOperation
    func CreateBasicBlockOperation(){
        //使用BlockOperation创建operation
        let operation = BlockOperation.init {
            
            print(#function,#line,Thread.current)
        }
        //直接运行operation，看看运行在哪个线程中
        operation.start()
        
    }
    
    
}


