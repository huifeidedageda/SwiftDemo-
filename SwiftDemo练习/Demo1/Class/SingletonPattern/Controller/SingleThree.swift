//
//  SingleThree.swift
//  DemoSwift
//
//  Created by 智衡宋 on 2017/7/28.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

let single = SingleThree()
class SingleThree: NSObject {

    class var sharedInstance : SingleThree {
        return single
    }

}
