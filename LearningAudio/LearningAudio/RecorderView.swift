//
//  RecorderView.swift
//  LearningAudio
//
//  Created by Bryan Gough on 2017-04-10.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//
// https://www.hackingwithswift.com/example-code/media/how-to-record-audio-using-avaudiorecorder
//
// Playback isn't currently working

import AVFoundation
import UIKit

class RecorderView: UIViewController, AVAudioRecorderDelegate {
    
    var myAudio: AVAudioPlayer!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var filename:String = "recording.m4a"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        //self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(filename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            view.backgroundColor = UIColor.green
            //recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    func finishRecording(success: Bool) {
        view.backgroundColor = UIColor.white
        if audioRecorder != nil
        {
            
            audioRecorder.stop()
            print(audioRecorder.url)
            audioRecorder = nil
    
            if success {
                //recordButton.setTitle("Tap to Re-record", for: .normal)
            } else {
                //recordButton.setTitle("Tap to Record", for: .normal)
                // recording failed :(
            }
        }
        else
        {
            print("Not currently recording")
        }
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    //
    @IBAction func recordPress(_ sender: Any) {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    func playSound() {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        print("\(url)")
        //guard let url = Bundle.main.url(forResource: "Documents/recording", withExtension: "m4a") else {
        /*if url == nil {
            print("url not found")
            return
        }*/
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
    
    
    @IBAction func stopPress(_ sender: Any) {
        finishRecording(success: true)
    }
    @IBAction func playbackPress(_ sender: Any) {
        playSound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
