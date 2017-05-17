//
//  ViewController.swift
//  Accelorometer
//
//  Created by Bryan Gough on 2017-05-16.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit
import CoreMotion
import Photos



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var XValue: UILabel!
    @IBOutlet var YValue: UILabel!
    @IBOutlet var ZValue: UILabel!
    @IBOutlet weak var imagePicked: UIImageView!
    
    var toggleShooting:Bool = false;
    var timer:Timer = Timer()
    var motionManager: CMMotionManager!
    var imagePicker:UIImagePickerController = UIImagePickerController()
    var currentCameraView:CameraWithLevelView?
    var takingPicture:Bool = false;
    var _syncedValue:CMAcceleration?
    
    /*func openCamera(){
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
    }*/
    
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
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {

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


