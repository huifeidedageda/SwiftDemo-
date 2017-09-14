//
//  SingleFour.swift
//  DemoSwift
//
//  Created by 智衡宋 on 2017/7/28.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class SingleFour: NSObject {
 
    static var sharedInstance : SingleFour {
        
        struct Static {
            static let instance : SingleFour = SingleFour()
        }
        return Static.instance
        
    }
}
