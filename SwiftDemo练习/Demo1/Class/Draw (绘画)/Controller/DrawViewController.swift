//
//  DrawViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/4.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        customDraw5()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}

extension DrawViewController {
    
    
    func customDraw1()  {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 100), false, 0)
        let con = UIGraphicsGetCurrentContext()
        con!.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        con!.setFillColor(UIColor.red.cgColor)
        con?.fillPath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let imageView = UIImageView(image: image)
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
    }
    
    
    func customDraw2()  {
        
        let viewDraw = DrawView(frame:view.bounds)
        viewDraw.backgroundColor = .white
        view.addSubview(viewDraw)
        
    }
    
    func customDraw3()  {
        
        let viewDraw = DrawView1(frame:view.bounds)
        viewDraw.backgroundColor = .white
        view.addSubview(viewDraw)
        
    }
    
    func customDraw4()  {
        
        let viewDraw = DrawView2(frame:view.bounds)
        viewDraw.backgroundColor = .white
        view.addSubview(viewDraw)
        
    }
    
    func customDraw5()  {
        
        let viewDraw = DrawView3(frame:CGRect(x: 50, y: 50, width: 200, height: 200))
        viewDraw.backgroundColor = .white
        view.addSubview(viewDraw)
        
    }
    
    
}
