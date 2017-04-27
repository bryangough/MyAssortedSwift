//
//  ViewController.swift
//  CameraWithLevel
//
//  Created by Bryan Gough on 2017-04-26.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//
//http://stackoverflow.com/questions/35015846/how-to-expand-camera-view-to-full-screen-in-swift-uiimagepickercontroller


import UIKit
import CoreMotion
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CameraWithLevelDelegate {
    
    @IBOutlet var XValue: UILabel!
    @IBOutlet var YValue: UILabel!
    @IBOutlet var ZValue: UILabel!
    @IBOutlet weak var imagePicked: UIImageView!
    
    var timer:Timer = Timer()
    var motionManager: CMMotionManager!
    var imagePicker:UIImagePickerController = UIImagePickerController()
    
    @IBAction func openCameraTouch(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let customView:CameraWithLevelView = CameraWithLevelView.instanceFromNib() as! CameraWithLevelView
            customView.delegate = self

            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            imagePicker.cameraOverlayView = customView
            imagePicker.showsCameraControls = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func didCancel(overlayView:CameraWithLevelView) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    func didShoot(overlayView:CameraWithLevelView) {
        print("didShoot")
        imagePicker.takePicture()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        XValue.text = "x"
        YValue.text = "y"
        ZValue.text = "z"
        /*motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        runTimer()*/
        print("view appeared")
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if let accelerometerData = motionManager.accelerometerData {
            XValue.text = String(accelerometerData.acceleration.x)
            YValue.text = String(accelerometerData.acceleration.y)
            ZValue.text = String(accelerometerData.acceleration.z)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //imageStore.setImage(image, forKey: item.itemKey)
        imagePicked.image = image
        
        saveImageToPictures(image: image)
        
        dismiss(animated: true, completion: nil)
    }
    func saveImageToPictures(image:UIImage)
    {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: { success, error in
            if success {
                // Saved successfully!
            }
            else if let error = error {
                print("\(error)")
                // Save photo failed with error
            }
            else {
                // Save photo failed with no error
            }
        })
    }
}

