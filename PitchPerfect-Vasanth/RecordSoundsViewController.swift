//
//  RecordSoundsViewController.swift
//  PitchPerfect-Vasanth
//
//  Created by Vasantha kumar Vijaya kumar on 7/9/17.
//  Copyright © 2017 Vasantha kumar Vijaya kumar. All rights reserved.
//

import UIKit
import AVFoundation

class RecordsSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIstateForRecording(isRecording: false) // Disabling the stop recording record when sound is not recorded
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        recordButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        stopRecordingButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    // IBAction to be performed once the Start recording button is pressed
    
    @IBAction func recordAudio(_ sender: Any) {
        setUIstateForRecording(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // IBAction to be performed once the Stop recording button is pressed
    
    @IBAction func stopRecording(_ sender: Any) {
        setUIstateForRecording(isRecording: false)
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }

    // Performing the transition to next view only after the recording is completed successfully
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func setUIstateForRecording(isRecording: Bool) {
        stopRecordingButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
    
        recordLabel.text = !isRecording ? "Tap to Record" : "Recording in Progress"
    }
    
}

