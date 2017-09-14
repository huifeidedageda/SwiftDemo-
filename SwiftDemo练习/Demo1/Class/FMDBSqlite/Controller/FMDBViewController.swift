//
//  FMDBViewController.swift
//  DemoSwift
//
//  Created by 智衡宋 on 2017/7/29.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class FMDBViewController: UIViewController {

    lazy var manager = FMDBManager.shareInstance
    var number :Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        
        let person = Person()
        person.name = "song"
        person.age = "18"
        person.number = "\(number)"
        
        
        manager.insertData(person: person)
        number += 1
        
    }

    @IBAction func deleteAction(_ sender: Any) {
        
      
        let person = Person()
        person.name = "song"
        person.age = "18"
        person.number = "\(number)"
        
        manager.deleteData(person: person)
        number -= 1
    }
    
    
    @IBAction func changeAction(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func selectOneAction(_ sender: Any) {
        
        
        
    }
    
    @IBAction func selectionAllAction(_ sender: Any) {
        
        manager.selectAllData()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
