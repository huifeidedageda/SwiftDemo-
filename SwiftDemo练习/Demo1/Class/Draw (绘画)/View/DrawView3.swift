//
//  DrawView3.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/4.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class DrawView3: UIView {

  
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        drawCircle()
        drawTwiceBesierPathLine()
        drawThirdBesierPathLine()

    }
 

}

extension DrawView3 {
    
    //设置实线
    func drawLine() {
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.minY))
        path.addLine(to: CGPoint(x: drawingRect.midX, y: drawingRect.minY))
        path.addLine(to: CGPoint(x: drawingRect.midX, y: drawingRect.midY))
        //添加路径到图形上下文
        context.addPath(path)
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        
        //设置连接点样式（圆角）
        context.setLineJoin(CGLineJoin.round)
        //设置顶点样式（圆角)
        context.setLineCap(.round)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //设置阴影
        context.setShadow(offset: CGSize(width:3, height:3), blur: 0.6)
        //绘制路径
        context.strokePath()
        
        
    }
    
    //设置虚线
    func drawEmptyLine() {
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x:drawingRect.minX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.maxY))
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //虚线每个线段的长度与间隔
        let lengths: [CGFloat] = [15,4]
        //设置虚线样式
        context.setLineDash(phase: 0, lengths: lengths)
        
        //绘制路径
        context.strokePath()
    }
    
    //设置圆弧
    func drawCircle() {
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        
        //圆弧半径
        let radius = min(drawingRect.width, drawingRect.height)/2
        //圆弧中点
        let center = CGPoint(x:drawingRect.midX, y:drawingRect.midY)
        //绘制圆弧
        path.addArc(center: center, radius: radius, startAngle: 0,
                    endAngle: CGFloat.pi * 1.5, clockwise: false)

        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //绘制路径
        context.strokePath()
        
        
    }
    
    //设置二次贝塞尔曲线
    func drawTwiceBesierPathLine() {
        
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //创建一个矩形，它的所有边都内缩3点
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        //移动起点
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.maxY))
        //二次贝塞尔曲线终点
        let toPoint = CGPoint(x: drawingRect.maxX, y: drawingRect.maxY)
        //二次贝塞尔曲线控制点
        let controlPoint = CGPoint(x: drawingRect.midX, y: drawingRect.minY)
        //绘制二次贝塞尔曲线
        path.addQuadCurve(to: toPoint, control: controlPoint)
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //绘制路径
        context.strokePath()
        
    }
    //设置三次贝塞尔曲线
    func drawThirdBesierPathLine() {
        
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
        
        //创建并设置路径
        let path = CGMutablePath()
        //移动起点
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.maxY))
        //三次贝塞尔曲线终点
        let toPoint = CGPoint(x: drawingRect.maxX, y: drawingRect.minY)
        //三次贝塞尔曲线第1个控制点
        let controlPoint1 = CGPoint(x: (drawingRect.minX+drawingRect.midX)/2, y: drawingRect.minY)
        //三次贝塞尔曲线第2个控制点
        let controlPoint2 = CGPoint(x: (drawingRect.midX+drawingRect.maxX)/2, y: drawingRect.maxY)
        //绘制三次贝塞尔曲线
        path.addCurve(to: toPoint, control1: controlPoint1, control2: controlPoint2)
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        //绘制路径
        context.strokePath()
        
    }
}
