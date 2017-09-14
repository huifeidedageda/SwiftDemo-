//
//  BezierPathViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/4.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class BezierPathViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        drawCircle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}

//复合使用 CAShapeLayer + UIBezierPath
extension BezierPathViewController {
    
    /**
     1.CAShapeLayer继承CALayer,可以使用CALayer的全部属性.
     2.CAShapeLayer需要配合贝塞尔曲线使用, CAShapeLayer需要贝塞尔曲线的path
     3.使用CAShapeLayer与贝塞尔曲线可以实现不在view的drawRect方法中画出一下想要的图形, drawRect 是属于Core Graphics框架走CPU,比较耗性能. CAShapeLayer属于Core Animation框架,走GPU,动画渲染直接提交给手机GPU.
     备注:
     drawRect是UIView的方法，重写此方法可以完成绘制图形功能
     
     
     
     */
    
    //绘图的关键就是用CAShapeLayer创建的对象去获取UIBezierPath绘制的路径
    
    //1.绘制折线图
    func drawBrokenLine() {
        //创建路径
        let linePath = UIBezierPath()
        //起点
        linePath.move(to: CGPoint(x: 30, y: 30))
        //添加其他点
        linePath.addLine(to: CGPoint(x: 150, y: 150))
        linePath.addLine(to: CGPoint(x: 180, y: 20))
        
        //设施路径画布
        let lineShape = CAShapeLayer()
        lineShape.frame = CGRect(x: 10, y: 10, width: 350, height: 400)
        //宽度
        lineShape.lineWidth = 2
        //线条之间点的样式
        lineShape.lineJoin = kCALineJoinMiter
        //线条结尾的样式
        lineShape.lineCap = kCALineCapSquare
        //路径颜色
        lineShape.strokeColor = UIColor.red.cgColor
        //获取贝塞尔曲线的路径
        lineShape.path = linePath.cgPath
        //填充色
        lineShape.fillColor = UIColor.clear.cgColor
        //把绘制的图放到layer上
        view.layer.addSublayer(lineShape)
        
        
    }
    
    //2.绘制三角形
    func drawTriangle() {
        //创建路径
        let linePath = UIBezierPath()
        //起点
        linePath.move(to: CGPoint(x: 30, y: 30))
        //添加其他点
        linePath.addLine(to: CGPoint(x: 160, y: 160))
        linePath.addLine(to: CGPoint(x: 140, y: 50))
        //闭合路径
        linePath.close()
        //设施路径画布
        let lineShape = CAShapeLayer()
        lineShape.frame = CGRect(x: 0, y: 0, width: 350, height: 400)
        lineShape.lineWidth = 2
        lineShape.lineJoin = kCALineJoinMiter
        lineShape.lineCap = kCALineCapSquare
        lineShape.strokeColor = UIColor.red.cgColor
        lineShape.path = linePath.cgPath
        lineShape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(lineShape)
        
    }
    
    //3.绘制五角形
    func drawPentagon() {
        //创建路径 
        let linePath = UIBezierPath()
        //起点 
        linePath.move(to: CGPoint.init(x: 100, y: 0))
        //添加其他点 
        linePath.addLine(to: CGPoint.init(x: 200, y: 40))
        linePath.addLine(to: CGPoint.init(x: 160, y: 140))
        linePath.addLine(to: CGPoint.init(x: 40, y: 140))
        linePath.addLine(to: CGPoint.init(x: 0, y: 40))
        
        //闭合路径
        linePath.close()
        
        //设施路径画布 
        let lineShape = CAShapeLayer()
        lineShape.frame = CGRect.init(x: 0, y: 0, width: 350, height: 400)
        lineShape.lineWidth = 2
        lineShape.lineJoin = kCALineJoinMiter
        lineShape.lineCap = kCALineCapSquare
        lineShape.strokeColor = UIColor.red.cgColor
        lineShape.path = linePath.cgPath
        lineShape.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(lineShape)
      
      
    }
    
    //4.绘制圆和椭圆
    func drawCircle()  {
        
        //椭圆
        //        let linePath = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: 260, height: 200))
        //圆
        let linePath = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        let lineShape = CAShapeLayer()
        lineShape.frame = view.bounds
        lineShape.lineWidth = 2
        lineShape.strokeColor = UIColor.red.cgColor
        lineShape.path = linePath.cgPath
        lineShape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(lineShape)
        
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 4
        pathAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        lineShape.add(pathAnimation, forKey: "strokeEndAnimation")
    }
    
    //5.绘制矩形
    func drawRect() {
        
        //创建路径 
        let linePath = UIBezierPath.init(rect: CGRect.init(x: 50, y: 50, width: 200, height: 200))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect.init(x: 0, y:0, width: 300, height: 200)
        shapeLayer.path = linePath.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(shapeLayer)
        
        
    }
    
    //6.绘制圆角图形
    func drawCap() {
        
        //四个角都是圆角 
        //        let path = UIBezierPath.init(roundedRect: CGRect.init(x: 50, y: 50, width: 200, height: 200), cornerRadius: 25) 
        //可设置某个角是圆角 
        let path = UIBezierPath.init(roundedRect: CGRect.init(x: 50, y: 50, width: 200, height: 200), byRoundingCorners: UIRectCorner.topLeft, cornerRadii: CGSize.init(width: 50, height: 0))
        
       
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect.init(x: 0, y:0, width: 300, height: 300)
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.orange.cgColor
        self.view.layer.addSublayer(shapeLayer)
        
       
    }
}


//单独使用 UIBezierPath
extension BezierPathViewController {
    
    func useBezierPath()  {
        let viewRect = CGRect(x: 50, y: 50, width: 100, height: 100)
        let view1 = MyCanvas(frame: viewRect)
        self.view.addSubview(view1)
    }
    
}

//重绘
class MyCanvas: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //创建一个矩形，它的所有边都内缩5%
        let drawingRect = self.bounds.insetBy(dx: self.bounds.size.width * 0.05,
                                              dy: self.bounds.size.height * 0.05)
        
        //确定组成绘画的点
        let topLeft = CGPoint(x:drawingRect.minX, y: drawingRect.minY)
        let topRight = CGPoint(x:drawingRect.maxX, y:drawingRect.minY)
        let bottomRight = CGPoint(x:drawingRect.maxX, y:drawingRect.maxY)
        let bottomLeft = CGPoint(x:drawingRect.minX, y:drawingRect.maxY)
        let center = CGPoint(x:drawingRect.midX, y:drawingRect.midY)
        
        //创建一个贝塞尔路径
        let bezierPath = UIBezierPath()
        //开始绘制
        bezierPath.move(to: topLeft)
        bezierPath.addLine(to: topRight)
        bezierPath.addLine(to: bottomLeft)
        bezierPath.addCurve(to: bottomRight, controlPoint1: center, controlPoint2: center)
        //使路径闭合，结束绘制
        bezierPath.close()
        
        //设定颜色，并绘制它们
        UIColor.green.setFill()
        UIColor.black.setStroke()
        bezierPath.fill()
        bezierPath.stroke()
    }
}

