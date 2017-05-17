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
    var syncedValue:CMAcceleration{get set}
}

class CameraWithLevelView: UIView
{
    @IBOutlet var DualBar: DualLevelBar!
    @IBOutlet var shootToggleButton: UIButton!

    var timer:Timer = Timer()
    var motionManager: CMMotionManager!
    var delegate:CameraWithLevelDelegate! = nil
    var syncedValue:CMAcceleration?;    
    
    @IBAction func shootPic(_ sender: Any) {
        delegate.didShoot(overlayView: self)
    }
    @IBAction func caneclPress(_ sender: Any) {
        delegate.didCancel(overlayView: self)
    }
    @IBAction func syncPress(_ sender: Any) {
        if let accelerometerData = motionManager.accelerometerData {
            DualBar.setSyncPosition(x: CGFloat(accelerometerData.acceleration.x), y: CGFloat(accelerometerData.acceleration.y))
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
    //http://stackoverflow.com/questions/26682450/set-camera-focus-on-tap-point-with-swift
   /* override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let screenSize = videoView.bounds.size
        if let touchPoint = touches.first {
            let x = touchPoint.location(in: videoView).y / screenSize.height
            let y = 1.0 - touchPoint.location(in: videoView).x / screenSize.width
            let focusPoint = CGPoint(x: x, y: y)
            
            if let device = captureDevice {
                do {
                    try device.lockForConfiguration()
                    
                    device.focusPointOfInterest = focusPoint
                    //device.focusMode = .continuousAutoFocus
                    device.focusMode = .autoFocus
                    //device.focusMode = .locked
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                }
                catch {
                    // just ignore
                }
            }
        }
    }*/

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
    func shootingPics()
    {
        shootToggleButton.setTitle("Stop", for: .normal)
    }
    func stopShooting()
    {
        shootToggleButton.setTitle("Start", for: .normal)
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self,   selector: (#selector(CameraViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if let accelerometerData = motionManager.accelerometerData {
            DualBar.setPosition(x: CGFloat(accelerometerData.acceleration.x), y: CGFloat(accelerometerData.acceleration.y))
            DualBar.setNeedsDisplay();
        }
    }
    
    // Mark - Class Functions
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CameraView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    
}
