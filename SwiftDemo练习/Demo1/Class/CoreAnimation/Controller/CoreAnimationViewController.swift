//
//  CoreAnimationViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/3.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class CoreAnimationViewController: UIViewController {

    //懒加载
    lazy var redView:UIView = {
        
        let redView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        redView.backgroundColor = .red
        return redView
    
    }()
    
    //全局属性
    var layer :CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showCoreAnimation()
    }

    func showCoreAnimation() {
        
        view.addSubview(redView)
        layer = redView.layer
    }
    
    
    //触摸开始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //属性动画
        //transformDemo()
        //基础动画
        //CoreAnimationBasic()
        //关键帧动画
        //CAKeyframeAnimationDemo()
        //组动画
        //CAAnimationGroupDemo()
        //过渡动画
        //CATransitionDemo()
    }
    

}

//transform属性动画
extension CoreAnimationViewController {
    
    func transformDemo() {
        
        inversionDemo()
        
    }
    
    //1、移动
    func moveDemo() {
        //每次都从当前位置平移
        redView.transform = redView.transform.translatedBy(x: -2.1, y: -2.1)
        
        //每次都从最开始的位置计算平移
        redView.transform = CGAffineTransform(translationX: 2.3, y: 2.3)
    }
    //2、旋转
    func rotateDemo() {
        //连续旋转
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(3.0)
        redView.transform = redView.transform.rotated(by: CGFloat(-Double.pi/2))
        UIView.commitAnimations()
        
        //独立旋转，以初始位置旋转
        redView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/4))
        
    }
    //3、缩放
    func scaleDemo() {
        
        //连续缩放 
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(3.0) //设置动画时间 
        redView.transform = redView.transform.scaledBy(x: 1.5 ,y: 1.5);
        UIView.commitAnimations()
        //独立缩放，以初始位置缩放 
        redView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        
        
    }
    //4、反转
    func inversionDemo() {
        
        //返回初始状态 
        redView.transform = CGAffineTransform.identity
        //连续反转
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(3.0)
        //设置动画时间 
        redView.transform = redView.transform.concatenating(redView.transform.inverted())
        UIView.commitAnimations()
        //独立反转，以初始位置反转 
//        redView.transform = redView.transform.inverted()
        
      
        
    }
}

//核心动画
//CABasicAnimation
extension CoreAnimationViewController {
    
    func CoreAnimationBasic() {
        
        let basicAni = CABasicAnimation()
        basicAni.keyPath = "position.x"
        basicAni.byValue = (100)
        basicAni.duration = 10
        basicAni.repeatCount = 5
        basicAni.fillMode = kCAFillModeForwards
        basicAni.isRemovedOnCompletion = false
        
        self.layer?.add(basicAni, forKey: nil)
        print(self.redView.frame.origin.x)
        
    }
    
    
}

//CAKeyframeAnimation
extension CoreAnimationViewController {
    
    func CAKeyframeAnimationDemo()  {
        
        let keyframeAni = CAKeyframeAnimation()
        keyframeAni.keyPath = "position"
        let  path = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 160, height: 160))
        keyframeAni.path = path.cgPath
        keyframeAni.duration = 10
        keyframeAni.repeatCount = 3
        self.layer?.add(keyframeAni, forKey: nil)
    }
    
}

//CAAnimationGroup
extension CoreAnimationViewController {
    
    func CAAnimationGroupDemo()  {
        
        let group = CAAnimationGroup()
        
        let keyframeAni = CAKeyframeAnimation()
        keyframeAni.keyPath = "position"
        let path = UIBezierPath(arcCenter: CGPoint(x: 200, y: 200), radius: 80, startAngle: 0, endAngle: CGFloat(2.0 * Double.pi), clockwise: true)
        keyframeAni.path = path.cgPath
        
        let basicAni = CABasicAnimation()
        basicAni.keyPath = "transform.rotation"
        basicAni.byValue = (Double.pi * 2 * 3)
        
        group.animations = [keyframeAni,basicAni]
        group.duration = 10
        group.repeatCount = 3
        
        self.layer?.add(group, forKey: nil)
    }
    
}

//CATransition
extension CoreAnimationViewController {
    /**
     
     1，公开动画效果：
     kCATransitionFade：翻页
     kCATransitionMoveIn：弹出
     kCATransitionPush：推出
     kCATransitionReveal：移除
     
     2，非公开动画效果：
     "cube"：立方体
     "suckEffect"：吸收
     "oglFlip"：翻转
     "rippleEffect"：波纹
     "pageCurl"：卷页
     "cameraIrisHollowOpen"：镜头开
     "cameraIrisHollowClose"：镜头关
     
     3，动画方向类型：
     kCATransitionFromRight：从右侧开始实现过渡动画
     kCATransitionFromLeft：从左侧开始实现过渡动画
     kCATransitionFromTop：从顶部开始实现过渡动画
     kCATransitionFromBottom：从底部开始实现过渡动画
     
   
     */
    
    
    func CATransitionDemo() {
        
        let transitonAni = CATransition()
        transitonAni.duration = 2
        transitonAni.type = "oglFlip"
        transitonAni.subtype = kCATransitionFromLeft
        self.layer?.add(transitonAni, forKey: nil)
        
    }
    
}

