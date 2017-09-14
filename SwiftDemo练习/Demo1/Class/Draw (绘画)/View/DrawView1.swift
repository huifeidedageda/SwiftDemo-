//
//  DrawView1.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/4.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class DrawView1: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        drawText()
        drawLine()
        drawRectangle()
        drawCircle()
        drawCircle2()
        drawBesierPath()
    }
    
}
extension DrawView1 {
    
    //绘制文字
    func drawText()  {
        let magentaColor = UIColor.green
        let myString:NSString = "我的剑就是你的剑"
        let helveticaBold = UIFont.init(name: "HelveticaNeue-Bold", size: 30.0);
        myString.draw(at: CGPoint(x: 20, y: 100), withAttributes: [NSFontAttributeName: helveticaBold!, NSForegroundColorAttributeName: magentaColor])
    }
    
    //绘制直线
    func drawLine()  {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setShouldAntialias(false)
        context?.setLineWidth(2.0)
        context?.move(to: CGPoint(x: 30, y: 200))
        context?.addLine(to: CGPoint(x: 150, y: 200))
        context?.strokePath()
    }
    
    //绘制矩形
    func drawRectangle()  {
        
        /// 无框的
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        context?.fill(CGRect(x: 30, y: 260, width: 100, height: 60))
        context?.strokePath()
        
        
        /// 有框的
        context?.setFillColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        context?.fill(CGRect(x: 30, y: 350, width: 100, height: 60))
        context?.setStrokeColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        context?.setLineWidth(1.0)
        context?.addRect(CGRect(x: 30, y: 350, width: 100, height: 60))
        context?.strokePath()
        
    }
    
    //绘制圆形
    func drawCircle() {
        let context  = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: CGRect(x: 50, y: 430, width: 100, height: 100))
        context?.setStrokeColor(red: 0.3, green: 0.7, blue: 0.0, alpha: 1.0)
        context?.strokePath()
    }
    
    //绘制扇形与椭圆
    func drawCircle2() {
    
        //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.red.cgColor)
        context?.move(to: CGPoint(x: 160, y: 180))
        context?.addArc(center: CGPoint(x: 180, y: 180), radius: 30, startAngle: 120, endAngle: 200, clockwise: true)
        context?.closePath()
        context?.drawPath(using: CGPathDrawingMode.fillStroke)
        
        //画椭圆
        context!.addEllipse(in: CGRect(x: 200, y: 230, width: 100, height: 30)) //椭圆
        context!.drawPath(using: CGPathDrawingMode.fillStroke)
    }
    
    //绘制贝塞尔曲线
    func drawBesierPath() {
        let context = UIGraphicsGetCurrentContext()
        // 二次曲线
        context?.move(to: CGPoint(x: 240, y: 380))
        context?.addQuadCurve(to: CGPoint(x: 240, y: 420), control: CGPoint(x: 200, y: 300))
        context?.strokePath()
        
        //三次曲线函数
        context?.move(to: CGPoint(x: 200, y: 300))
        context?.addCurve(to: CGPoint(x: 280, y: 300), control1: CGPoint(x: 250, y: 280), control2: CGPoint(x: 250, y: 400))
        context?.strokePath()
        
    }
    
}
