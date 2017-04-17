//
//  ViewController.swift
//  LearningAudio
//
//  Created by Bryan Gough on 2017-04-10.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController {

    
    var myAudio: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playTouch(_ sender: Any) {
        playSound()
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "sounds/Pickup_Coin", withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /// change fileTypeHint according to the type of your audio file (you can omit this)
            myAudio = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
            
            // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
            myAudio!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    func stopSound(){
        if myAudio != nil {
            myAudio!.stop()
            myAudio = nil
        }
    }

}
