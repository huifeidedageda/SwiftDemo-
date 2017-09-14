//
//  OperationDetailViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/2.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit
import Masonry
//设置枚举值
enum DemoType : Int{
    case basic
    case priority
    case dependency
    case collection
}

class OperationDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    var demoType:DemoType?
    var imageViews:[UIImageView]?
    let operationQueue = OperationQueue.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //布局
        setupMasonryUI()
        //设置导航控制器按钮
        setupNavigationItem()
        //存储图片
        imageViews = [imageView1,imageView2,imageView3,imageView4]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



extension OperationDetailViewController {
    
    //布局
    func setupMasonryUI(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        view.backgroundColor = .white
        imageView1.backgroundColor = .red
        imageView2.backgroundColor = .yellow
        imageView3.backgroundColor = .blue
        imageView4.backgroundColor = .green
        
        
        imageView1.mas_makeConstraints { (make) in
            
            make?.left.top().mas_equalTo()(20)
            make?.right.equalTo()(self.view.mas_right)?.offset()(-20)
            make?.height.equalTo()(self.imageView2.mas_height)
            
        }
        
        imageView2.mas_makeConstraints { (make) in
            make?.left.right().equalTo()(self.imageView1)
            make?.top.equalTo()(self.imageView1.mas_bottom)?.offset()(20)
            make?.height.equalTo()(self.imageView3.mas_height)
        }
        
        imageView3.mas_makeConstraints { (make) in
            make?.left.right().equalTo()(self.imageView2)
            make?.top.equalTo()(self.imageView2.mas_bottom)?.offset()(20)
            make?.height.equalTo()(self.imageView4.mas_height)
        }
        
        imageView4.mas_makeConstraints { (make) in
            make?.left.right().equalTo()(self.imageView3)
            make?.top.equalTo()(self.imageView3.mas_bottom)?.offset()(20)
            make?.height.equalTo()(self.imageView1.mas_height)
            make?.bottom.equalTo()(self.view.mas_bottom)?.offset()(-20)
        }
        
        
    }
    //设置item
    func setupNavigationItem(){
        
        let leftItem = UIBarButtonItem.init(title: "返回", style: .done, target:self , action: #selector(leftAction))
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem.init(title: "加载", style: .done, target:self , action: #selector(rightAction))
        
        self.navigationItem.rightBarButtonItem = rightItem
    }
    //左侧事件监听
    func leftAction() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    //右侧事件监听
    func rightAction() {
        
        guard let type = demoType else {
            return
        }
        switch type {
        
        case .basic:
            startBasicDemo()
            break
        case .priority:
            startPriorityDemo()
            break
        case .dependency:
            startDepencyDemo()
            break
        default:
            break
            
        }
        
    }
    
}

//三种Operation
extension OperationDetailViewController {
    
    //基础
    func startBasicDemo() {
        
        operationQueue.maxConcurrentOperationCount = 3
        for imageview in imageViews! {
            
            if let url = URL(string: "https://placebeard.it/355/140") {
                do {
                    
                    let image = UIImage(data: try Data(contentsOf: url))
                    
                    DispatchQueue.main.async {
                        imageview.image = image
                    }
                    
                } catch  {
                    print(error)
                }
            }
            
        }
        
        
        DispatchQueue.global().async { [weak self] in
            
            self?.operationQueue.waitUntilAllOperationsAreFinished()
            DispatchQueue.main.async {
                print("结束加载进度")
            }
            
        }
        
        
    }
    //优先级
    func startPriorityDemo() {
        
        operationQueue.maxConcurrentOperationCount  = 3
        var operations = [Operation]()
        for (index,imagView) in (imageViews?.enumerated())! {
            
            if let url = URL(string: "https://placebeard.it/355/140"){
                
                let operation = convenienceOperation.init(setImageView: imagView, withURL: url)
                
                //根据索引设置优先级
                switch index {
                case 0:
                    operation.queuePriority = .veryHigh
                case 1:
                    operation.queuePriority = .high
                case 2:
                    operation.queuePriority = .normal
                case 3:
                    operation.queuePriority = .low
                default:
                    operation.queuePriority = .veryLow
                }
                
                operations.append(operation)
                
                
            }
            
        }
        
        DispatchQueue.global().async { [weak self] in
            
            self?.operationQueue.addOperations(operations, waitUntilFinished: true)
            DispatchQueue.main.async {
                print("加载完成")
            }
        }
        
        
    }
    //依赖关系
    func startDepencyDemo() {
        
        operationQueue.maxConcurrentOperationCount = 4
        guard let url = URL(string: "https://placebeard.it/355/140") else { return }
        
        let op1 = convenienceOperation.init(setImageView: imageView1, withURL: url)
        let op2 = convenienceOperation.init(setImageView: imageView2, withURL: url)
        op2.addDependency(op1)
        let op3 = convenienceOperation.init(setImageView: imageView3, withURL: url)
        op3.addDependency(op2)
        let op4 = convenienceOperation.init(setImageView: imageView4, withURL: url)
        op4.addDependency(op3)
        
        DispatchQueue.global().async { [weak self] in
            self?.operationQueue.addOperations([op1,op2,op3,op4], waitUntilFinished: true)
            DispatchQueue.main.async {
                print("加载结束")
            }
        }
        
        
        
    }
    
}

//构造函数
class convenienceOperation: Operation {
    let url:URL
    let imageView:UIImageView
    init(setImageView:UIImageView,withURL:URL) {
        imageView = setImageView
        url = withURL
        super.init()
    }
    
    override func main() {
        
        do {
            if isCancelled {
                return
            }
            
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                [weak self] in
                self?.imageView.image = image
            }
            
        } catch {
            
            print(error)
            
        }
        
    }

}

