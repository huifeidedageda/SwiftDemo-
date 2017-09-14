//
//  GCDViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/2.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class GCDViewController: UIViewController {

    @IBOutlet weak var loadImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        globalAsyn()
        mainAsyn()
        downloadImageAsyn()
    }

    //全局 + 异步
    func globalAsyn() {
        //创建一个全局队列。
        //get a global queue
        let globalQueue = DispatchQueue.global()
        for i in 1..<10 {
            
            //使用全局队列，开启异步任务。
            //use the global queue , run in asynchronous
            globalQueue.async {
                
                print("I am No.\(i), current thread name is:\(Thread.current)")
                
            }
            
        }
        
    }
    
    //主队列 + 异步
    func mainAsyn() {
        //创建一个主队列
        //get a main queue
        let mainQueue = DispatchQueue.main
        
        for i in 0...10 {
            
            //使用主队列，开启异步任务
            //use the main queue, run in asynchronous
            mainQueue.async {
                print("I am No.\(i), current thread name is:\(Thread.current)")
                
            }
        }
    }
    
    
    //异步下载图片
    func downloadImageAsyn()  {
        
        //
        DispatchQueue.global().async {
            
            if let  url = URL.init(string: "https://placebeard.it/355/140") {
            
                
                do {
                    
                    let imageData = try Data(contentsOf: url)
                    let image = UIImage(data: imageData)
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(2), execute: {
                        self.loadImageView.image = image
//                        self.loadImageView.sizeToFit()
                    })
                    
                } catch {
                    
                    print("下载失败")
                }
            
            
        
            }
        
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
