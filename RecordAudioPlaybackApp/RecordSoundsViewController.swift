//
//  RecordSoundsViewController.swift
//  RecordAudioPlaybackApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tapToRecord: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordAudio:RecordedAudio!
    
    var recordAudioStruct : RecordAudioStruct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
        tapToRecord.hidden = false
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        tapToRecord.hidden = true
        recordingInProgress.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        
        // date formatter - not used
        /*
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        */
        
        
        // set filePathUrl
        /*let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)*/
        
        
        // set up audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // initilize and prepare recorder
        audioRecorder = try! AVAudioRecorder(URL: audioFileUrl(), settings: [String : AnyObject]())
        audioRecorder.delegate = self // add delegate as self, allows use of AVAudioRecorderDelegate functions
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecordAudio(sender: UIButton) {
        recordingInProgress.hidden = true
        stopButton.hidden = true
        
        // stop audio recorder, kill audio session
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    /* Returns a URL to the audio file.
    *  This is the code that was refactored out of the recordAudio() method in this step.
    */
    func audioFileUrl() ->  NSURL {
        let filename = "usersVoice.wav"
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let pathArray = [dirPath, filename]
        let fileURL =  NSURL.fileURLWithPathComponents(pathArray)!
        
        return fileURL
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            // Save the recorded audio
            recordAudio = RecordedAudio() // initialize the new object
            recordAudio.filePathUrl = recorder.url
            recordAudio.title = recorder.url.lastPathComponent
            
            recordAudioStruct = RecordAudioStruct()
            recordAudioStruct.filePathURL = recorder.url
            recordAudioStruct.titleString = recorder.url.lastPathComponent
            
            // Move to the second scene aka perform segue
            self.performSegueWithIdentifier("stopRecording", sender: recordAudio)
            
        } else {
            print("recording failed")
            recordingInProgress.hidden = true
            recordButton.enabled = true
            stopButton.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }
    }
}

