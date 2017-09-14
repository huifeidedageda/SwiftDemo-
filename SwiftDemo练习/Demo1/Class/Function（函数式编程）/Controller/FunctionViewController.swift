//
//  FunctionViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/1.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class FunctionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        
//     let b = add(x: 1)(2)
        
        let arr1 = [1,2,3,4]
        
        let customMapResultArray1 = self.customMap1(arr: arr1) { (num) -> (Int) in
            return num + 1
        }
        
        print(customMapResultArray1)
        
        
        let customMapResultArray2 = arr1.customMap { (num:Int) -> String in
            return "\(num)"
        }
        print("自定义Map函数测试结果>>>>> customMapResultArray1:\(customMapResultArray2)")
        
        
        
        
        //调用形式
        let customFilterResultArray3 = arr1.customFilter { (num:Int) -> Bool in
            return num > 2
        }
        print("自定义Filter函数测试结果>>>>> customFilterResultArray1:\(customFilterResultArray3)")
        
        
        let sum = arr1.customReduce(initial: 10) { (a:Int, b:Int) -> Int in
            return a + b
        }
        print("自定义Reduce函数测试结果>>>>> sum:\(sum)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func add(x:Int) -> ((Int)->(Int)) {
        return { y in return x + y }
    }
    
    
    func customMap1(arr:[Int],tramsform:((Int)->(Int))) -> [Int] {
        
        var rs : [Int] = []
        
        for x in arr {
            rs.append(tramsform(x))
        }
        return rs
    }
    
    
    //泛型
    func customMap2<T>(arr:[Int],transform:((Int)->(T))) -> [T] {
        var rs: [T] = []
        for x in arr {
            rs.append(transform(x))
        }
        return rs
    }
    

}


extension Array {
    
    //Map的实现
    func customMap<T>(transfom:((Element)->(T))) -> [T] {
        var rs:[T] = []
        for element in self {
            rs.append(transfom(element))
        }
        return rs
    }
    
    
    //Filter的实现
    func customFilter(includeElement:(Element) -> Bool) -> [Element] {
        var rs:[Element] = []
        for x in self {
            if includeElement(x) == true {
                rs.append(x)
            }
        }
        return rs
    }
    
    //Reduce函数的实现
    func customReduce<T>(initial:T, combine:(T,Element)->T) -> T {
        var rs = initial
        for x in self {
            rs = combine(rs, x)
        }
        return rs
    }

}

