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

enum PictureLevelErrors: Error {
    case noCameraView
}
struct GlobalVariables {
    static var variance:Float = 0.1
}

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CameraWithLevelDelegate {
    
    @IBOutlet var XValue: UILabel!
    @IBOutlet var YValue: UILabel!
    @IBOutlet var ZValue: UILabel!
    @IBOutlet weak var imagePicked: UIImageView!
    
    //let variance:Float = 0.1
    let store:LeveledPictureStore = LeveledPictureStore()
    var currentPic:LeveledPicture?
    
    var toggleShooting:Bool = false;
    var timer:Timer = Timer()
    var motionManager: CMMotionManager!
    var imagePicker:UIImagePickerController = UIImagePickerController()
    var currentCameraView:CameraWithLevelView?
    var takingPicture:Bool = false;
    var _syncedValue:CMAcceleration?
    
    @IBAction func openCameraTouch(_ sender: Any) {
        openCamera()
    }
    func openCamera(){
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
        
        toggleShooting = !toggleShooting
        print("didShoot \(toggleShooting)")
        if toggleShooting
        {
            runTimer()
            overlayView.shootingPics()
            currentCameraView = overlayView
        }
        else
        {
            overlayView.stopShooting()
            currentCameraView = nil
            timer.invalidate()
        }
        
    }
    //
    var syncedValue:CMAcceleration{
        get{
            return _syncedValue!
        }
        set{
            _syncedValue = newValue
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        openCamera();
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self,   selector: (#selector(CameraViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if toggleShooting
        {
            
            do {
                
                let pic:LeveledPicture = LeveledPicture()
                let tryPic = try checkPic(pic:pic)
                
                if tryPic
                {
                    if takingPicture
                    {
                        return
                    }
                    takingPicture = true;
                    currentPic = pic
                    imagePicker.takePicture()
                }
            }
            catch {
                print("No camera view.")
                dismiss(animated: true, completion: nil)//?
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        takingPicture = false
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        guard let pic = currentPic else
        {
                return
        }
        //imageStore.setImage(image, forKey: pic.key)
        store.addItem(pic)
        imagePicked.image = image
        dismiss(animated: true, completion: nil)
        //
        //print("Save pic \(info)")
    }
    func checkPic(pic:LeveledPicture)throws ->Bool {
        guard let view = currentCameraView else {
            throw PictureLevelErrors.noCameraView
        }
        
        if view.getCurrentLevels()==nil || view.syncedValue==nil
        {
            return false
        }
        pic.setLevels(level: view.getCurrentLevels()!, sync:view.syncedValue!)
        if(pic.testAllVariance(variance: GlobalVariables.variance))
        {
            return true;
        }
        return false;
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
            }
            else {
                print("Picture didn't save.")
            }
        })
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        if(screenWidth > screenHeight){
            //Landscape
            print("Landscape")
        }
        else{
            print("Portrait")
            //Portrait
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
}

