//
//  LevelBar.swift
//  CameraWithLevel
//
//  Created by Bryan Gough on 2017-04-27.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit
@IBDesignable

class DualLevelBar:UIView
{
    @IBInspectable var fillColor: UIColor = UIColor.green
    @IBInspectable var positon: CGPoint = CGPoint(x:0.0,y:0.0);
    @IBInspectable var syncPositon: CGPoint = CGPoint(x:0.0,y:0.0);
    
    let plusSize: CGFloat = 10.0
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
    }
    //
    func setPosition( x:CGFloat, y:CGFloat){
        positon.x = limitTo1(floatValue:x)
        positon.y = limitTo1(floatValue:y)
    }
    func setSyncPosition( x:CGFloat, y:CGFloat){
        syncPositon.x = limitTo1(floatValue:x)
        syncPositon.y = limitTo1(floatValue:y)
    }
    func limitTo1(floatValue:CGFloat)->CGFloat
    {
        var newValue = floatValue;
        if floatValue >= 1{
            newValue = 1.0;
        }
        if floatValue <= -1{
            newValue = -1.0
        }
        return newValue
    }
    //
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        let path = UIBezierPath()
        path.lineWidth = plusSize
        let newPosition:CGPoint = CGPoint(x: positon.x*bounds.width/2, y: positon.y*bounds.height/2)
        //drawSquare(path:path, newPosition: newPosition, colour: UIColor.white)
        print("\(newPosition) ")
        
        
        /*let path2 = UIBezierPath()
        path2.lineWidth = plusSize
        let newSyncPosition:CGPoint = CGPoint(x: syncPositon.x*bounds.width/2, y: syncPositon.y*bounds.height/2)
        drawSquare(path:path2, newPosition: newSyncPosition, colour: fillColor)*/

        
        let path2 = UIBezierPath()
         path2.lineWidth = plusSize
        let newSyncPosition:CGPoint = CGPoint(x: positon.x*bounds.width/2+center.x, y: positon.y*bounds.height/2+center.y);
         drawSquare(path:path2, newPosition: newSyncPosition, colour: fillColor)

    }

    func drawSquare(path:UIBezierPath, newPosition:CGPoint, colour:UIColor){
        colour.setStroke()
        path.addArc(withCenter: newPosition, radius: 10, startAngle: 0, endAngle: -0.0001, clockwise: true)
        path.stroke()
    }

    
}
