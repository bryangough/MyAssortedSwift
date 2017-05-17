//
//  CameraWithLevelView.swift
//  CameraWithLevel
//
//  Created by Bryan Gough on 2017-04-27.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit
import CoreMotion


class CameraWithLevelView: UIView
{
    @IBOutlet var DualBar: DualLevelBar!
    @IBOutlet var shootToggleButton: UIButton!

    var timer:Timer = Timer()
    var motionManager: CMMotionManager!
    //var delegate:CameraWithLevelDelegate! = nil
    var syncedValue:CMAcceleration?;    
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if newWindow == nil {
            timer.invalidate()
        } else {
            motionManager = CMMotionManager()
            motionManager.startAccelerometerUpdates()
            runTimer()
        }
    }
    func runTimer() {
        //timer = Timer.scheduledTimer(timeInterval: 0.02, target: self,   selector: (#selector(CameraViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if let accelerometerData = motionManager.accelerometerData {
            DualBar.setPosition(x: CGFloat(accelerometerData.acceleration.x), y: CGFloat(accelerometerData.acceleration.y))
            DualBar.setNeedsDisplay();
        }
    }
    
}
