//
//  DrawView2.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/4.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class DrawView2: UIView {

    
    //创建路径
    var path = CGMutablePath()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
       
       drawBoard()
    }
 

}

extension DrawView2 {
    
    func drawLine() {
        
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: 100, y: 100))
        context?.addLine(to: CGPoint(x: 100, y: 200))
        context?.addLine(to: CGPoint(x: 200, y: 200))
        context?.move(to:CGPoint(x: 100, y: 300))
        context?.addLine(to: CGPoint(x: 100, y: 400))
        context?.addLine(to: CGPoint(x: 200, y: 500))
        context?.setStrokeColor(red: 1.0, green: 0, blue: 0.7, alpha: 1.0)
        context?.setLineWidth(3)
        context?.strokePath()
        
    }
    
    func drawRect() {
        let context  = UIGraphicsGetCurrentContext()
        context?.addRect(CGRect(x: 10, y: 10, width: 100, height: 100))
        context?.setFillColor(red: 1.0, green: 1.0, blue: 0.3, alpha: 1.0)
        context?.fillPath()
        context?.setLineWidth(4)
        //边框颜色
        context?.setStrokeColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        context?.strokePath()
        
    }
    
    func drawCircle() {
        
        let context = UIGraphicsGetCurrentContext()
        context?.addArc(center: CGPoint(x:100,y:100), radius: 20, startAngle: 0, endAngle: 3.14, clockwise: true)
        context?.setFillColor(red: 0.5, green: 1.0, blue: 0.6, alpha: 1.0)
        context?.fillPath()
        
        //第一种方式绘制
        context?.addArc(center: CGPoint(x:100,y:100), radius: 20, startAngle: 0, endAngle: 3.14, clockwise: true)
        context?.setLineWidth(2)
        context?.closePath()
        context?.strokePath()
        //第二种方式绘制
        context?.addEllipse(in: CGRect(x: 50, y: 400, width: 200, height: 200))
        context?.strokePath()
    }
    
    //绘制图片
    func drawView() {
        let context  = UIGraphicsGetCurrentContext()
        //保存最初始的一个状态
        context?.saveGState()
        context?.translateBy(x: 10, y: 400)
        context?.scaleBy(x: 1, y: -1)
        //如果不调整坐标的话,我们会发现图片显示出来是反着的,因为CGImage和图片的坐标是反着的,上面两行为调整代码
        context?.draw((UIImage.init(named: "dice3.jpg")?.cgImage)!, in: CGRect(x: 0, y: 0, width: 200, height: 200))
         //回复最开始的状态
        context?.restoreGState()
        //如果不设置保存和恢复两种状态时会发现我们再绘制的图形会在之前绘制图片的里面,所以我们要想不影响后续的绘图时,要进行最初的一个状态的保存和恢复
        context?.stroke(CGRect(x: 50, y: 100, width: 100, height: 100))
        
    }
    
    //绘制画板
    func drawBoard()  {
        
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(path)
        context?.strokePath()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches {
            
            let p : UITouch = touch as! UITouch
            path.move(to: CGPoint(x: p.location(in: self).x, y: p.location(in: self).y))
            
            print(p.location(in: self).x, p.location(in: self).y)
            
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches {
            let p :UITouch = touch as! UITouch
            path.addLine(to: CGPoint(x: p.location(in: self).x, y: p.location(in: self).y))
             //重绘
            print(p.location(in: self).x, p.location(in: self).y)
            setNeedsDisplay()
        }
        
        
    }
    
}

/*
 
 绘画的相关介绍
 
 1 CGContextMoveToPoint 开始画线
 2 CGContextAddLineToPoint 画直线
 3 CGContextAddEllipseInRect 画一椭圆
 4 CGContextSetLineCap 设置线条终点形状
 5 CGContextSetLineDash 画虚线
 6 CGContextAddRect 画一方框
 7 CGContextStrokeRect 指定矩形
 8 CGContextStrokeRectWithWidth 指定矩形线宽度
 9 CGContextStrokeLineSegments 一些直线
 10 CGContextAddArc 画已曲线 前俩店为中心 中间俩店为起始弧度 最后一数据为0则顺时针画 1则逆时针
 11 CGContextAddArcToPoint(context,0,0, 2, 9, 40);//先画俩条线从point 到 弟1点 ， 从弟1点到弟2点的线  切割里面的圆
 12 CGContextSetShadowWithColor 设置阴影
 13 CGContextSetRGBFillColor 填充颜色
 14 CGContextSetRGBStrokeColor 画笔颜色设置
 15 CGContextSetFillColorSpace 颜色空间填充
 16 CGConextSetStrokeColorSpace 颜色空间画笔设置
 17 CGContextFillRect 补充当前填充颜色的rect
 18 CGContextSetAlaha 透明度
 
 19 CGContextTranslateCTM 改变画布位置
 20 CGContextSetLineWidth 设置线的宽度
 21 CGContextAddRects 画多个线
 22 CGContextAddQuadCurveToPoint 画曲线
 23 CGContextStrokePath 开始绘制图片
 24 CGContextDrawPath 设置绘制模式
 25 CGContextClosePath 封闭当前线路
 26 CGContextTranslateCTM(context, 0, rect.size.height);    CGContextScaleCTM(context, 1.0, -1.0);反转画布
 27 CGContextSetInterpolationQuality 背景内置颜色质量等级
 28 CGImageCreateWithImageInRect 从原图片中取小图
 */
