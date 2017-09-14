//
//  MasonryViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/7/31.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class MasonryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        test4()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test0() {
        
        let view1 = UIView()
        view1.backgroundColor = .red
        view.addSubview(view1)
        view1.mas_makeConstraints { (make) in
            make?.left.equalTo()(10)
            make?.top.equalTo()(10)
            make?.size.mas_equalTo()(CGSize(width: 100, height: 100))
        }
        
    }
    
    func test1() {
        
        let view1 = UIView()
        view1.backgroundColor = .red
        view.addSubview(view1)
        view1.mas_makeConstraints { (make) in
            make?.size.mas_equalTo()(CGSize(width: 100, height: 100))
            make?.left.and().top().equalTo()(20)
        }
        
        
        let view2 = UIView()
        view2.backgroundColor = .blue
        view.addSubview(view2)
        view2.mas_makeConstraints { (make) in
            make?.size.and().top().equalTo()(view1)
            make?.right.equalTo()(-20)
        }
        
        
    }
    
    func test2() {
        let view1 = UIView()
        view1.backgroundColor = .red
        view.addSubview(view1)
        view1.mas_makeConstraints { (make) in
            
            make?.left.top().mas_equalTo()(20)
            make?.right.mas_equalTo()(-20)
            
        }
        
        
        let view2 = UIView()
        view2.backgroundColor = .blue
        view.addSubview(view2)
        weak var weakSelf = self
        view2.mas_makeConstraints { (make) in
            
            make?.bottom.right().mas_equalTo()(-20)
            make?.height.equalTo()(view1)
            make?.top.equalTo()(view1.mas_bottom)?.offset()(20)
            make?.left.equalTo()(weakSelf?.view.mas_centerX)?.offset()(0)
            
        }
    }
    
    func test3() {
        //红
        let view1 = UIView()
        view1.backgroundColor = .red
        view.addSubview(view1)
        weak var weakSelf = self
        view1.mas_makeConstraints { (make) in
            
            make?.left.equalTo()(weakSelf?.view.mas_left)?.offset()(0)
            make?.top.equalTo()(weakSelf?.view.mas_top)?.offset()(0)
            make?.width.equalTo()(weakSelf?.view.mas_width)?.multipliedBy()(0.5)
            make?.height.equalTo()(weakSelf?.view.mas_height)?.multipliedBy()(0.5)
            
        }
        
        //蓝
        let view2 = UIView()
        view2.backgroundColor = .blue
        view.addSubview(view2)
        view2.mas_makeConstraints { (make) in
            
            make?.width.height().equalTo()(view1)
            make?.top.equalTo()(view1.mas_top)
            make?.right.equalTo()(weakSelf?.view.mas_right)?.offset()(0)
            
        }
        
        //黄
        let view3 = UIView()
        view3.backgroundColor = .yellow
        view.addSubview(view3)
        view3.mas_makeConstraints { (make) in
            
            make?.width.height().equalTo()(view1)
            make?.top.equalTo()(view1.mas_bottom)
            make?.left.mas_equalTo()(0)
            
        }
        
        //绿
        let view4 = UIView()
        view4.backgroundColor = .green
        view.addSubview(view4)
        view4.mas_makeConstraints { (make) in
            
            make?.width.height().equalTo()(view3)
            make?.left.equalTo()(view3.mas_right)
            make?.top.equalTo()(view2.mas_bottom)
        }
        
        
        
        
    }
    
    func test4() {
        

        //灰1
        let view1 = UIView()
        view1.backgroundColor = .gray
        view.addSubview(view1)
        
        //红1
        let view2 = UIView()
        view2.backgroundColor = .red
        view.addSubview(view2)
        
        //灰2
        let view3 = UIView()
        view3.backgroundColor = .gray
        view.addSubview(view3)
        
        //红2
        let view4 = UIView()
        view4.backgroundColor = .red
        view.addSubview(view4)
        
        //灰3
        let view5 = UIView()
        view5.backgroundColor = .gray
        view.addSubview(view5)
        
        view1.mas_makeConstraints { (make) in
            make?.height.mas_equalTo()(20)
            make?.left.equalTo()(self.view.mas_left)?.offset()(0)
            make?.bottom.equalTo()(view2.mas_bottom)
        }
        
        
        
        view2.mas_makeConstraints { (make) in
            
            make?.width.mas_equalTo()(100)
            make?.height.mas_equalTo()(50)
            make?.left.equalTo()(view1.mas_right)
            make?.bottom.equalTo()(self.view.mas_bottom)?.offset()(-100)
           
        }
        
        
        view3.mas_makeConstraints { (make) in
            
            make?.width.height().bottom().equalTo()(view1)
            make?.left.equalTo()(view2.mas_right)
            
        }
        
        
        view4.mas_makeConstraints { (make) in
            make?.width.height().bottom().equalTo()(view2)
            make?.left.equalTo()(view3.mas_right)
        }
        

        
        view5.mas_makeConstraints { (make) in
            make?.width.height().bottom().equalTo()(view3)
            make?.left.equalTo()(view4.mas_right)
            make?.right.equalTo()(self.view.mas_right)
        }
        
        
    }
}
