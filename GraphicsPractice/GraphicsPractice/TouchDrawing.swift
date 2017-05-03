//
//  TouchDrawing.swift
//  GraphicsPractice
//
//  Created by Bryan Gough on 2017-04-28.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//



import UIKit

class TouchDrawing: UIView {



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if touches.count==2
        {
        
        }
        else
        {
            
            for touch in touches {
                let location = touch.location(in: self)
                print(location)
  //              let newLine = Line(begin: location, end: location)
            
    //            let key = NSValue(nonretainedObject: touch)
     //           currentLines[key] = newLine
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()
    }
}
