//
//  SingleTwo.swift
//  DemoSwift
//
//  Created by 智衡宋 on 2017/7/28.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit


//3.0单例写法
class SingleTwo: NSObject {

    static let shared = SingleTwo()
    
    // 重载并私有 这里将init方法私有化了,这样在其他地方就无法init,保证了单例的唯一性.
    private override init(){
        
        super.init()
    }

}
