//
//  Tranform3DViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/2.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class Tranform3DViewController: UIViewController {

   let diceView = UIView()
    var angle1 = CGPoint.init(x: 0, y: 0)
    override func viewDidLoad() {
        super.viewDidLoad()

        
        addDice()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTransform))
        diceView.addGestureRecognizer(panGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addDice() {
        
        let viewFrame = UIScreen.main.bounds
        var diceTransform = CATransform3DIdentity
        
        diceView.frame = CGRect(x: 0, y: viewFrame.maxY / 2 - 50, width: viewFrame.width, height: 100)
        
        //1
        let dice1 = UIImageView.init(image: UIImage(named: "dice1.jpg"))
        dice1.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice1.layer.transform = diceTransform
        
        //6
        let dice6 = UIImageView.init(image: UIImage(named: "dice6.jpg"))
        dice6.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -50)
        dice6.layer.transform = diceTransform
        
        //2
        let dice2 = UIImageView.init(image: UIImage(named: "dice2.jpg"))
        dice2.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform  = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice2.layer.transform = diceTransform
        
        //5
        let dice5 = UIImageView.init(image: UIImage(named: "dice5.jpg"))
        dice5.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi / 2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice5.layer.transform = diceTransform
        
        //3
        let dice3 = UIImageView.init(image: UIImage(named: "dice3.jpg"))
        dice3.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi / 2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice3.layer.transform = diceTransform
        
        //4
        let dice4 = UIImageView.init(image: UIImage(named: "dice4.jpg"))
        dice4.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice4.layer.transform = diceTransform
        
        
        
        diceView.addSubview(dice1)
        diceView.addSubview(dice2)
        diceView.addSubview(dice3)
        diceView.addSubview(dice4)
        diceView.addSubview(dice5)
        diceView.addSubview(dice6)
        
        view.addSubview(diceView)
        
        
    }
    
    func viewTransform(pan:UIPanGestureRecognizer) {
        
        let point = pan.translation(in: diceView)
        let angelX = angle1.x + (point.x/30)
        let angelY = angle1.y - (point.y/30)
        
        //透过设置 CATransform3D 的 m34 为 -1.0 / d 来让影像有远近的 3D 效果，d 代表了想象中视角与屏幕的距离，这个距离只需要大概估算，不需要很精准的计算。
        //m34 用于按比例缩放 x 和 y 的值来呈现视角的远近。
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, angelX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angelY, 1, 0, 0)
        
        diceView.layer.sublayerTransform = transform
        
        if pan.state == .ended {
            angle1.x = angelX
            angle1.y = angelY
        }
        
    }

}
