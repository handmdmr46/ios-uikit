//
//  PlaySoundsViewController.swift
//  RecordAudioPlaybackApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // globally declared vars
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uses "movie_quote.mp3" instead of recording
        /*
        if let filePathUrl = NSBundle.mainBundle().URLForResource("movie_quote", withExtension: "mp3") {
        try! audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl)
        audioPlayer.enableRate = true
        } else {
        print("the file path is empty")
        }
        */
        
        // create audioPlayer using receivedAudio NSURL
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        
        // initialize audioEngine
        audioEngine = AVAudioEngine()
        //stopButton.hidden = true
        //playButton.hidden = false
        
        // create audioFile using receivedAudio NSURL
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        //        setUserInterfaceToPlayMode(false)
    }
    
    func setUserInterfaceToPlayMode(isPlayMode: Bool) {
        //        playButton.hidden = isPlayMode
        //        stopButton.hidden = !isPlayMode
        //        pitchSlider.enabled = !isPlayMode
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        setUserInterfaceToPlayMode(true)
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        // Get the pitch from the slider
        let pitch = pitchSlider.value
        
        // Play the sound
        playVariableAudio(pitch)
        
        // Set the UI
        //        setUserInterfaceToPlayMode(true)
    }
    
    /*func playAudio() {
    audioPlayer.stop()
    audioEngine.stop()
    audioEngine.reset()
    audioPlayer.currentTime = 0.0 // start at beginning of recording
    audioPlayer.play()
    }*/
    
    func playVariableAudio(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        // connect audio player node to pitch effect
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        
        // connect pitch effect to output (speakers)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        // schedule file
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        /*audioPlayerNode.scheduleFile(audioFile, atTime: nil) {
        // When the audio completes, set the user interface on the main thread
        dispatch_async(dispatch_get_main_queue()) {self.setUserInterfaceToPlayMode(false) }
        }*/
        
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
    @IBAction func pitchSliderDidMove(sender: UISlider) {
        // Do Nothing?
        print("slider Moved")
    }
}


