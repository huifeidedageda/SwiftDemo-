//
//  ProtocolView.swift
//  DemoSwift
//
//  Created by 智衡宋 on 2017/7/29.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

protocol DelegateName:NSObjectProtocol {
    
    func songMusic()
    func shouMusic()
    
}

class ProtocolView: UIView {

    
    weak var delegate:DelegateName?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
        
    }
    
    
    func setupUI(){
        
        let button1 = UIButton(type: .system)
        button1.backgroundColor = .red
        button1.addTarget(self, action: #selector(songMusic), for: .touchUpInside)
        self.addSubview(button1)

        button1.mas_makeConstraints { (mas) in
            
            mas?.left.equalTo()(100)
            mas?.top.equalTo()(100)
            mas?.width.equalTo()(100)
            mas?.height.equalTo()(100)
            
        }
        
    
        
        
        
        let button2 = UIButton(type: .system)
        button2.backgroundColor = .blue
        button2.addTarget(self, action: #selector(shouMusic), for: .touchUpInside)
        self.addSubview(button2)
        
        button2.mas_makeConstraints { (mas) in
            
            mas?.left.equalTo()(250)
            mas?.top.equalTo()(100)
            mas?.width.equalTo()(100)
            mas?.height.equalTo()(100)
        }
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    //协议方法
    func songMusic(){
        delegate?.songMusic()
        
    }
    
    func shouMusic(){
        
        delegate?.shouMusic()
    }
    
}
