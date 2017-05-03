//
//  Arcs.swift
//  GraphicsPractice
//
//  Created by Bryan Gough on 2017-04-28.
//  Copyright © 2017 Bryan Gough. All rights reserved.
// https://www.raywenderlich.com/90690/modern-core-graphics-with-swift-part-1
// https://developer.apple.com/reference/uikit/uibezierpath/1624358-init

import UIKit

//http://stackoverflow.com/questions/29179692/how-can-i-convert-from-degrees-to-radians
extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}


let NoOfGlasses = 8
let π:CGFloat = CGFloat(Double.pi)

@IBDesignable class Arcs: UIView {
    
    @IBInspectable var counter: Int = 5
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    var currentPoint:CGPoint = CGPoint()
    
    override func draw(_ rect: CGRect) {
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        // 2
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3
        let arcWidth: CGFloat = 76
        
        // 4
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = 3 * π / 4 - 0.00001 //π / 4
        
        // 5
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        // 6
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        //Draw the outline
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 - draw the outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        //3 - draw the inner arc
        outlinePath.addArc(withCenter: center,
                                     radius: bounds.width/2 - arcWidth + 2.5,
                                     startAngle: outlineEndAngle,
                                     endAngle: startAngle,
                                     clockwise: false)
        
        //4 - close the path
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
        
        let path2 = UIBezierPath()
        path2.lineWidth = 5
        path2.lineCapStyle = .round
        
        path2.move(to: center)
        path2.addLine(to: currentPoint)
        path2.stroke()

    }
    
    func getAngle(p1:CGPoint, p2:CGPoint)->CGFloat
    {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let v1 = CGVector(dx: p1.x - center.x, dy: p1.y - center.y)
        let v2 = CGVector(dx: p2.x - center.x, dy: p2.y - center.y)
        let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
        return angle
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let location = touch.location(in: self)
        currentPoint = location;
        //print("\(location)")
            
            
            
            
            /*for touch in touches {
                let location = touch.location(in: self)
                
                /*let newLine = Line(begin: location, end: location)
                
                let key = NSValue(nonretainedObject: touch)
                currentLines[key] = newLine
 */
            }*/
        
    }
    //
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Log statement to see the order of events
        //print(#function)
        
        let touch = touches.first!
        let location = touch.location(in: self)
        //print("\(location)")
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let angle = getAngle(p1: center, p2: location)
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = 3 * π / 4 - 0.00001 //π / 4
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        let cal:Float = (Float(angle).radiansToDegrees-Float(startAngle).radiansToDegrees)
        //+Float(startAngle).radiansToDegrees
        
        //let counter = angle/arcLengthPerGlass;// - startAngle
        //Float(startAngle).radiansToDegrees
        print("\(cal) \(Float(startAngle).radiansToDegrees)")
        
        currentPoint = location;
        //for touch in touches {
            //let key = NSValue(nonretainedObject: touch)
            //currentLines[key]?.end = touch.location(in: self)
        //}
        
        setNeedsDisplay()
    }
    //
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Log statement to see the order of events
        //print(#function)
        
        //let touch = touches.first!
        //for touch in touches {
            //let key = NSValue(nonretainedObject: touch)
            /*if var line = currentLines[key] {
                line.end = touch.location(in: self)
                
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }*/
        //}
        
        setNeedsDisplay()
    }
}
