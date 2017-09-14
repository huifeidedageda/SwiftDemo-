//
//  KVOViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/7.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class KVOViewController: UIViewController {

    @IBOutlet weak var kvoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1、KVO
        kvoButton.addObserver(self, forKeyPath: "backgroundColor", options: .new, context: nil)
    }

    @IBAction func KVOButtonAction(_ sender: Any) {
        
        kvoButton.backgroundColor = .blue
        
        //2、属性观察器
        let  observer = PropertyObserverExmple()
        observer.number = 4
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        if let newValue = change?[NSKeyValueChangeKey.newKey] {
            
            print(newValue)
            
        }

        
    }
    
  
    deinit {
        
        
        kvoButton.removeObserver(self, forKeyPath: "backgroundColor")
        
    }

}

/**
 
 属性观察器
 
 1、简单介绍
 
 属性观察器相当于內建的KVO，监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，甚至新的值和现在的值相同的时候也不例外。
 
 可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重载属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。
 
 注意：
 
 不需要为无法重载的计算属性添加属性观察器，因为可以通过 setter 直接监控和响应值的变化。
 
 2、监测方式
 
 可以为属性添加如下的一个或全部观察器：
 
 willSet在设置新的值之前调用
 didSet在新的值被设置之后立即调用
 
 分析：
 
 willset观察器会将新的属性值作为固定参数传入，在willSet的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称
 
 newValue表示。类似地，didSet观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名oldValue。
 
 注意：
 
 willSet和didSet观察器在属性初始化过程中不会被调用，它们只会当属性的值在初始化之外的地方被设置时被调用。
 
 
 */



class PropertyObserverExmple {
    
    var number: Int = 0 {
        willSet(newNumber) {
            print("About to change to \(newNumber)")
        }
        didSet(oldNumber) {
            print("Just changed from \(oldNumber) to \(self.number)")
        }
    }
    
}



