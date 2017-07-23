//
//  PlaySoundsViewController.swift
//  PitchPerfect-Vasanth
//
//  Created by Vasantha kumar Vijaya kumar on 7/9/17.
//  Copyright © 2017 Vasantha kumar Vijaya kumar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
   
    // IBOutlet variables for all buttons in Play Sounds View
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Playback main function
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    // IBAction tagged to Stop button
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        stopAudio()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }

    // Setting the Play Sounds View to Not playing mode initially
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        snailButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        chipmunkButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        rabbitButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        vaderButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        stopButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        configureUI(.notPlaying)
    }
}
