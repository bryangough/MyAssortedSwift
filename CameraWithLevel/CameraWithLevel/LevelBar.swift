//
//  LevelBar.swift
//  CameraWithLevel
//
//  Created by Bryan Gough on 2017-04-27.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit
@IBDesignable

class LevelBar:UIView
{
    @IBInspectable var fillColor: UIColor = UIColor.green
    @IBInspectable var positon: CGFloat = 0.0
    @IBInspectable var syncPositon: CGFloat = 0.0
    
    let plusHeight: CGFloat = 10.0
    var plusWidth: CGFloat = 1.0
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if newWindow == nil {
            
        } else {
            plusWidth = min(bounds.width, bounds.height) * 1.0
        }
    }
    
    override func draw(_ rect: CGRect) {
        //limits
        let path = UIBezierPath()
        let path2 = UIBezierPath()
        if positon >= 1{
            positon = 1;
        }
        if positon <= -1{
            positon = -1
        }
        let posx = bounds.width/2;
        let posy = bounds.height/2
        
        //
        path.lineWidth = plusHeight
        path2.lineWidth = plusHeight
        
        
        let newPosition2 = syncPositon * bounds.width/2
        drawSquare(path:path2,posx:posx, posy:posy, newPosition:newPosition2, colour: UIColor.white)

        let newPosition = positon * bounds.width/2
        drawSquare(path:path,posx:posx, posy:posy, newPosition:newPosition, colour: fillColor)

    }
    func drawSquare(path:UIBezierPath,posx:CGFloat, posy:CGFloat, newPosition:CGFloat, colour:UIColor){
        path.move(to: CGPoint(
            x:posx + 0.5 + newPosition,
            y:posy - plusWidth/2 + 0.5))
        path.addLine(to: CGPoint(
            x:posx + 0.5 + newPosition,
            y:posy + plusWidth/2 + 0.5))
        colour.setStroke()
        path.stroke()
    }
    /*func inverseColor(color:UIColor)->UIColor
    {
        var r:UnsafeMutablePointer<CGFloat>
        var g:UnsafeMutablePointer<CGFloat>
        var b:UnsafeMutablePointer<CGFloat>
        var a:UnsafeMutablePointer<CGFloat>
        var one:UnsafeMutablePointer<CGFloat>
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(displayP3Red: 1.0-&r, green: &one-&g, blue: &one-&b, alpha: &a)
    }*/
    
}
