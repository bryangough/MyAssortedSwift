//
//  CameraWithLevelView.swift
//  CameraWithLevel
//
//  Created by Bryan Gough on 2017-04-27.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit
import CoreMotion


protocol CameraWithLevelDelegate{
    func didCancel(overlayView:CameraWithLevelView)
    func didShoot(overlayView:CameraWithLevelView)
}

class CameraWithLevelView: UIView
{

    var timer:Timer = Timer()
    var motionManager: CMMotionManager!
    var delegate:CameraWithLevelDelegate! = nil
    
    @IBOutlet var XBar: LevelBar!
    @IBOutlet var YBar: LevelBar!
    @IBOutlet var ZBar: LevelBar!
    
    /*@IBOutlet var XValue: UILabel!
    @IBOutlet var YValue: UILabel!
    @IBOutlet var ZValue: UILabel!*/
    @IBOutlet var syncdLabel: UILabel!
    @IBOutlet var shootToggleButton: UIButton!
    
    
    var syncedValue:CMAcceleration?;
    //var currentValue:CMAcceleration?;
    
    @IBAction func shootPic(_ sender: Any) {
        delegate.didShoot(overlayView: self)
    }
    @IBAction func caneclPress(_ sender: Any) {
        delegate.didCancel(overlayView: self)
    }
    @IBAction func syncPress(_ sender: Any) {
        var str = ""
        if let accelerometerData = motionManager.accelerometerData {
            str = String(accelerometerData.acceleration.x)
            str += String(accelerometerData.acceleration.y)
            str += String(accelerometerData.acceleration.z)
            
            XBar.syncPositon = CGFloat(accelerometerData.acceleration.x)
            YBar.syncPositon = CGFloat(accelerometerData.acceleration.y)
            ZBar.syncPositon = CGFloat(accelerometerData.acceleration.z)
            syncedValue = accelerometerData.acceleration;
        }
        //syncdLabel.text = str
    }
    func getCurrentLevels()->CMAcceleration?{
        if let accelerometerData = motionManager.accelerometerData {
            return accelerometerData.acceleration;
        }
        return nil
    }
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if newWindow == nil {
            timer.invalidate()
        } else {
          //  XValue.text = "x"
           // YValue.text = "y"
           // ZValue.text = "z"
            motionManager = CMMotionManager()
            motionManager.startAccelerometerUpdates()
            runTimer()
        }
    }
    func shootingPics()
    {
        shootToggleButton.setTitle("Stop", for: .normal)
    }
    func stopShooting()
    {
        shootToggleButton.setTitle("Start", for: .normal)
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if let accelerometerData = motionManager.accelerometerData {
           // XValue.text = String(accelerometerData.acceleration.x)
           // YValue.text = String(accelerometerData.acceleration.y)
           // ZValue.text = String(accelerometerData.acceleration.z)
            
            XBar.positon = CGFloat(accelerometerData.acceleration.x)
            YBar.positon = CGFloat(accelerometerData.acceleration.y)
            ZBar.positon = CGFloat(accelerometerData.acceleration.z)
            
            XBar.setNeedsDisplay()
            YBar.setNeedsDisplay()
            ZBar.setNeedsDisplay()
        }
    }
    
    // Mark - Class Functions
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CameraView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
}
