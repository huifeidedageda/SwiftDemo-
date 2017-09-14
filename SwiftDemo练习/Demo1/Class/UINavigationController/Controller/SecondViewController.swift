//
//  SecondViewController.swift
//  TestSwiftDemo
//
//  Created by 智衡宋 on 2017/7/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

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


extension SecondViewController {
    
    func setupUI() {
        
        let  item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(returnup))
        self.navigationItem.leftBarButtonItem = item
        
        
       
        
    }
    
    
  
    
    
    func returnup() {
        
        
        self.navigationController?.popViewController(animated: true)
        
    }

    
    
    
}
