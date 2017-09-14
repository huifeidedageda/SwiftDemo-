//
//  DrawView.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/4.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class DrawView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
//        drawRectUIKit()
//        drawRectCoreGraphics()
    }

    
    
//    override func draw(_ layer: CALayer, in ctx: CGContext) {
//        drawLayerUIKit(ctx: ctx)
//        drawLayerCoreGraphics(ctx: ctx)
//    }


}

extension DrawView {
    
    //1 . 在UIView的子类方法drawRect：中绘制一个蓝色圆, 使用 UIKit方式:
    func drawRectUIKit() {
        let p = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 100, height: 100))
        UIColor.blue.setFill()
        p.fill()
    }
    //2 . 在UIView的子类方法drawRect：中绘制一个蓝色圆, 使用 Core Graphics方式:
    func drawRectCoreGraphics() {
        let con = UIGraphicsGetCurrentContext()
        con?.addEllipse(in: CGRect(x: 10, y: 10, width: 100, height: 100))
        con?.setFillColor(UIColor.red.cgColor)
        con?.fillPath()
    }
    //3 . 在UIView子类的drawLayer:inContext：方法中,使用UIKit方式:
    func drawLayerUIKit(ctx :CGContext) {
        
        UIGraphicsPushContext(ctx)
        let p =  UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 100, height: 100))
        UIColor.blue.setFill()
        p.fill()
        UIGraphicsPushContext(ctx)
        
    }
    //4 . 在UIView子类的drawLayer:inContext：方法中,使用Core Graphics方式:
    func drawLayerCoreGraphics(ctx :CGContext) {
        
        ctx.addEllipse(in: CGRect(x: 10, y: 10, width: 100, height: 100))
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fillPath()
        
    
    }
    
    
}
