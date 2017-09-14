//
//  ViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/7/31.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
 
    
    @IBAction func shixianButtonAction(_ sender: Any) {
        

        
       
    }
    
    
    //网络请求
    func requst() {
        
        NetworkTools.shareInstance.request(methodType: .GET, urlString: "http://zz.oricg.com/appapi/get2044.php", parameters: ["type":"2044","classid":"501"]) { (result, error) in
            
            print(result ?? "")
            
        }
    }
    
    //函数式编程
    func function()  {
        
        let function = FunctionViewController()
        
        self.present(function, animated: true, completion: nil)
        
    }
    
    //GCD
    func GCD() {
        let gcd = GCDViewController()
        self.present(gcd, animated: true, completion: nil)
    }
    
    //Operation
    func Operation() {
        let op = OperationViewController()
        self.present(op, animated: true, completion: nil)
    }
    
    //UserDefault
    func userdefault() {
        
        let defaults = UserDefaultViewController()
        self.present(defaults, animated: true, completion: nil)
    }
    
    //CATranslate3D
    func CATranslate3D()  {
        let defaults = Tranform3DViewController()
        self.present(defaults, animated: true, completion: nil)
    }
    
    //CoreAnimation
    func CoreAnimationDemo()  {
        let animation = CoreAnimationViewController()
        self.present(animation, animated: true, completion: nil)
    }
    
    //Draw
    func drawDemo()  {
        
        let draw = DrawViewController()
        self.present(draw, animated: true, completion: nil)
        
    }
    
    //BezierPath
    func bezierPathDemo() {
        let path = BezierPathViewController()
        self.present(path, animated: true, completion: nil)
    }
    
    //KVO
    func KVODemo() {
        
        let kvo = KVOViewController()
        self.present(kvo, animated: true, completion: nil)
        
    }
    
    //AVPlayer
    func AVPlayerDemo()  {
        let avplayer = AVPlayerViewController()
        self.present(avplayer, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


